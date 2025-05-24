import 'dart:io';
import 'dart:convert';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_info.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// Check Lightning node status and readiness
/// 
/// Uses the /v1/status endpoint to determine if Lightning services are ready
/// instead of blind retries. This is much more reliable than waiting arbitrary time.
Future<RestResponse> getNodeStatus({String? nodeId, String? adminMacaroon}) async {
  LoggerService logger = Get.find();
  
  // Use centralized Lightning configuration
  String selectedNode = nodeId ?? LightningConfig.getDefaultNodeId();
  String url = LightningConfig.getLightningUrl('v1/status', nodeId: selectedNode);

  logger.i("=== GET NODE STATUS DEBUG ===");
  logger.i("Target URL: $url");
  logger.i("Selected Node: $selectedNode");
  logger.i("Caddy Base URL: ${LightningConfig.caddyBaseUrl}");

  // Use provided admin macaroon (from initwallet) or fallback to global one
  String macaroon;
  if (adminMacaroon != null && adminMacaroon.isNotEmpty) {
    // Use the specific admin macaroon provided (e.g., from initwallet response)
    macaroon = adminMacaroon;
    logger.i("🔑 Using provided admin macaroon for status check: ${macaroon.substring(0, 20)}... (truncated)");
  } else {
    // Fallback to global admin macaroon
    final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();
    ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
    List<int> bytes = byteData.buffer.asUint8List();
    macaroon = bytesToHex(bytes);
    logger.i("🔑 Using global admin macaroon for status check: ${macaroon.substring(0, 20)}... (truncated)");
  }

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  logger.i("=== STATUS REQUEST HEADERS ===");
  headers.forEach((key, value) {
    if (key == 'Grpc-Metadata-macaroon') {
      logger.i("$key: ${value.substring(0, 20)}... (truncated)");
    } else {
      logger.i("$key: $value");
    }
  });

  // Override HTTP settings if necessary
  HttpOverrides.global = MyHttpOverrides();

  logger.i("=== MAKING STATUS HTTP REQUEST ===");
  logger.i("About to make GET request to: $url");

  try {
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    ).timeout(Duration(seconds: LightningConfig.statusCheckTimeoutSeconds));

    logger.i("=== STATUS HTTP RESPONSE RECEIVED ===");
    logger.i("Response Status Code: ${response.statusCode}");
    logger.i("Response Headers: ${response.headers}");
    logger.i("Response Body Length: ${response.body.length}");
    logger.i("Raw Response Body: ${response.body}");

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        logger.i("=== PARSED STATUS RESPONSE ===");
        
        // Log important status fields
        responseData.forEach((key, value) {
          if (key == 'wallet' || key == 'server_active' || key == 'state' || key == 'subserver_states') {
            logger.i("$key: $value ← STATUS INFO");
          } else {
            // Truncate long values for cleaner logs
            String valueStr = value.toString();
            if (valueStr.length > 50) {
              logger.i("$key: ${valueStr.substring(0, 50)}... (truncated)");
            } else {
              logger.i("$key: $value");
            }
          }
        });
        
        // Check if Lightning services are ready
        bool isReady = _checkLightningReadiness(responseData, logger);
        logger.i("Lightning services ready: $isReady");

        return RestResponse(
          statusCode: "${response.statusCode}",
          message: isReady ? "Lightning services are ready" : "Lightning services not ready yet",
          data: {
            ...responseData,
            'lightning_ready': isReady,
          },
        );
      } catch (jsonError) {
        logger.e("Error parsing JSON response: $jsonError");
        return RestResponse(
          statusCode: "error",
          message: "Failed to parse status response: $jsonError",
          data: {"raw_response": response.body},
        );
      }
    } else {
      logger.e("=== STATUS HTTP ERROR RESPONSE ===");
      logger.e("Status Code: ${response.statusCode}");
      logger.e("Status Text: ${response.reasonPhrase}");
      logger.e("Response Body: ${response.body}");
      logger.e("Response Headers: ${response.headers}");
      
      return RestResponse(
        statusCode: "error",
        message: "Failed to get status: ${response.statusCode}, ${response.body}",
        data: {"status_code": response.statusCode, "raw_response": response.body},
      );
    }
  } catch (e, stackTrace) {
    logger.e("=== STATUS CHECK EXCEPTION ===");
    logger.e("Exception Type: ${e.runtimeType}");
    logger.e("Exception Message: $e");
    logger.e("Stack Trace: $stackTrace");
    
    if (e.toString().contains('timeout')) {
      logger.e("STATUS CHECK TIMEOUT - Node might still be starting");
    } else if (e.toString().contains('connection')) {
      logger.e("STATUS CHECK CONNECTION ERROR - Check network connectivity");
    }
    
    return RestResponse(
      statusCode: "error",
      message: "Failed to check status: $e",
      data: {"exception_type": e.runtimeType.toString(), "exception_message": e.toString()},
    );
  }
}

/// Check if Lightning services are ready based on status response
bool _checkLightningReadiness(Map<String, dynamic> statusData, LoggerService logger) {
  try {
    // Check various indicators of Lightning readiness
    
    // 1. Check overall server state
    bool serverActive = statusData['server_active'] ?? false;
    logger.d("Server active: $serverActive");
    
    // 2. Check wallet state (might not be in status response for some LitD versions)
    var walletState = statusData['wallet'];
    bool walletUnlocked = false;
    if (walletState != null && walletState is Map) {
      walletUnlocked = walletState['exists'] == true && walletState['unlocked'] == true;
      logger.d("Wallet exists and unlocked: $walletUnlocked");
    } else {
      // If wallet state not in status, assume it's ready since we just initialized it
      logger.d("Wallet state not in status response, assuming ready since we just initialized");
      walletUnlocked = true;
    }
    
    // 3. Check subserver states (this is the key indicator!)
    var subServers = statusData['sub_servers']; // Note: different from subserver_states
    bool subserversReady = false;
    int runningCount = 0;
    int totalCount = 0;
    
    if (subServers != null && subServers is Map) {
      subServers.forEach((service, serviceData) {
        totalCount++;
        if (serviceData is Map) {
          bool isRunning = serviceData['running'] == true;
          bool hasError = serviceData['error'] != null && serviceData['error'].toString().isNotEmpty;
          bool serviceReady = isRunning && !hasError;
          
          logger.d("Subserver $service: running=$isRunning, error=${serviceData['error']}, ready=$serviceReady");
          
          if (serviceReady) {
            runningCount++;
          }
        }
      });
      
      // Consider ready if most subservers are running (especially lnd)
      subserversReady = runningCount >= totalCount * 0.7; // 70% threshold
      logger.d("Subservers ready: $runningCount/$totalCount (threshold: 70%)");
    }
    
    // 4. Check legacy subserver_states format (if available)
    var subserverStates = statusData['subserver_states'];
    bool legacySubserversReady = true;
    if (subserverStates != null && subserverStates is Map) {
      subserverStates.forEach((service, state) {
        bool serviceReady = state == 'READY' || state == 'RPC_ACTIVE';
        logger.d("Legacy subserver $service: $state (ready: $serviceReady)");
        if (!serviceReady) {
          legacySubserversReady = false;
        }
      });
    }
    
    // 5. Check state field (if available)
    String? overallState = statusData['state']?.toString();
    bool stateReady = overallState == 'RPC_ACTIVE' || overallState == 'READY';
    logger.d("Overall state: $overallState (ready: $stateReady)");
    
    // CONSERVATIVE LOGIC: Lightning is ready ONLY if:
    // - Subservers are running (most important), AND
    // - Server is active, AND
    // - Wallet is unlocked
    // This ensures all critical services are actually running
    bool isReady = subserversReady && serverActive && walletUnlocked;
    
    // Fallback: If subservers info isn't available, use legacy logic
    if (subServers == null || (subServers as Map).isEmpty) {
      isReady = legacySubserversReady && serverActive && walletUnlocked;
    }
    
    logger.i("Lightning readiness check:");
    logger.i("- Wallet unlocked: $walletUnlocked");
    logger.i("- Server active: $serverActive");
    logger.i("- State ready: $stateReady");
    logger.i("- Subservers ready: $subserversReady ($runningCount/$totalCount running)");
    logger.i("- Legacy subservers ready: $legacySubserversReady");
    logger.i("- Overall ready: $isReady");
    
    return isReady;
    
  } catch (e) {
    logger.w("Error checking Lightning readiness: $e");
    return false;
  }
}

/// Validate Lightning readiness by actually calling getinfo
Future<bool> validateLightningWithGetInfo({
  String? nodeId,
  String? adminMacaroon,
}) async {
  LoggerService logger = Get.find();
  
  try {
    // We'll import the getNodeInfo function at the top of the file
    // and call it directly to test actual functionality
    RestResponse getInfoResponse = await getNodeInfo(
      nodeId: nodeId,
      adminMacaroon: adminMacaroon,
    );
    
    if (getInfoResponse.statusCode == "200") {
      logger.i("✅ GetInfo validation successful - Lightning is truly ready");
      return true;
    } else {
      logger.w("⚠️ GetInfo validation failed: ${getInfoResponse.message}");
      return false;
    }
  } catch (e) {
    logger.w("⚠️ GetInfo validation exception: $e");
    return false;
  }
}

/// Wait for Lightning services to be ready with intelligent status checking + getinfo validation
/// 
/// Much better than blind retries - actually checks when services are available
Future<bool> waitForLightningReady({
  String? nodeId,
  String? adminMacaroon,
  int? maxWaitSeconds,
  int? checkIntervalSeconds,
}) async {
  // Use config defaults if not provided
  maxWaitSeconds ??= LightningConfig.lightningReadyMaxWaitSeconds;
  checkIntervalSeconds ??= LightningConfig.lightningReadyCheckIntervalSeconds;
  
  LoggerService logger = Get.find();
  
  logger.i("=== WAITING FOR LIGHTNING SERVICES TO BE READY ===");
  logger.i("Max wait time: ${maxWaitSeconds}s, check interval: ${checkIntervalSeconds}s");
  
  int elapsed = 0;
  while (elapsed < maxWaitSeconds) {
    logger.i("Checking Lightning readiness... (${elapsed}s/${maxWaitSeconds}s elapsed)");
    
    try {
      // Step 1: Check status endpoint
      RestResponse statusResponse = await getNodeStatus(
        nodeId: nodeId,
        adminMacaroon: adminMacaroon,
      );
      
      if (statusResponse.statusCode == "200") {
        bool isReady = statusResponse.data['lightning_ready'] ?? false;
        
        if (isReady) {
          logger.i("Status endpoint reports ready, validating with getinfo...");
          
          // Step 2: Validate with actual getinfo call
          bool getInfoWorking = await validateLightningWithGetInfo(
            nodeId: nodeId,
            adminMacaroon: adminMacaroon,
          );
          
          if (getInfoWorking) {
            logger.i("✅ Lightning services are truly ready! (took ${elapsed}s)");
            return true;
          } else {
            logger.i("⏳ Status ready but getinfo still failing, continuing to wait...");
          }
        } else {
          logger.i("⏳ Lightning services not ready yet, waiting ${checkIntervalSeconds}s...");
        }
      } else {
        logger.w("⚠️ Status check failed: ${statusResponse.message}");
      }
    } catch (e) {
      logger.w("⚠️ Status check exception: $e");
    }
    
    if (elapsed + checkIntervalSeconds <= maxWaitSeconds) {
      await Future.delayed(Duration(seconds: checkIntervalSeconds));
      elapsed += checkIntervalSeconds;
    } else {
      break;
    }
  }
  
  logger.e("❌ Lightning services not ready after ${maxWaitSeconds}s");
  return false;
}