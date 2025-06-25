import 'dart:io';
import 'dart:convert';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<RestResponse> getNodeInfo(
    {String? nodeId, String? adminMacaroon, String? userDid}) async {
  LoggerService logger = Get.find();

  // Use centralized Lightning configuration
  String selectedNode = nodeId ?? LightningConfig.getDefaultNodeId();
  String url =
      LightningConfig.getLightningUrl('v1/getinfo', nodeId: selectedNode);

  logger.i("=== GET NODE INFO DEBUG ===");
  logger.i("Target URL: $url");
  logger.i("Selected Node: $selectedNode");
  logger.i("User DID: $userDid");
  logger.i("Caddy Base URL: ${LightningConfig.caddyBaseUrl}");

  // Use provided admin macaroon or load user-specific macaroon
  String macaroon;
  if (adminMacaroon != null && adminMacaroon.isNotEmpty) {
    // Use the specific admin macaroon provided (e.g., from initwallet response)
    macaroon = adminMacaroon;
    logger.i(
        "🔑 Using provided admin macaroon: ${macaroon.substring(0, 20)}... (truncated)");
  } else if (userDid != null && userDid.isNotEmpty) {
    // Load user-specific macaroon from storage
    try {
      final UserNodeMapping? nodeMapping =
          await NodeMappingService.getUserNodeMapping(userDid);
      if (nodeMapping != null && nodeMapping.adminMacaroon.isNotEmpty) {
        // Convert base64 macaroon to hex format
        final macaroonBase64 = nodeMapping.adminMacaroon;
        final macaroonBytes = base64Decode(macaroonBase64);
        macaroon = bytesToHex(macaroonBytes);
        selectedNode = nodeMapping.nodeId; // Use user's specific node
        url =
            LightningConfig.getLightningUrl('v1/getinfo', nodeId: selectedNode);
        logger.i(
            "🔑 Using user-specific macaroon for ${nodeMapping.nodeId}: ${macaroon.substring(0, 20)}... (truncated)");
      } else {
        throw Exception("No user-specific macaroon found for DID: $userDid");
      }
    } catch (e) {
      logger.e("❌ Failed to load user-specific macaroon: $e");
      throw Exception("Failed to load user macaroon: $e");
    }
  } else {
    // Fallback to global admin macaroon (should be avoided in production)
    final RemoteConfigController remoteConfigController =
        Get.find<RemoteConfigController>();
    ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
    List<int> bytes = byteData.buffer.asUint8List();
    macaroon = bytesToHex(bytes);
    logger.w(
        "⚠️ Using global admin macaroon as fallback: ${macaroon.substring(0, 20)}... (truncated)");
  }

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  logger.i("=== REQUEST HEADERS ===");
  headers.forEach((key, value) {
    if (key == 'Grpc-Metadata-macaroon') {
      logger.i("$key: ${value.substring(0, 20)}... (truncated)");
    } else {
      logger.i("$key: $value");
    }
  });

  // Override HTTP settings if necessary
  HttpOverrides.global = MyHttpOverrides();

  logger.i("=== MAKING HTTP REQUEST ===");
  logger.i("About to make GET request to: $url");

  try {
    var response = await http
        .get(
          Uri.parse(url),
          headers: headers,
        )
        .timeout(Duration(seconds: LightningConfig.defaultTimeoutSeconds));

    logger.i("=== HTTP RESPONSE RECEIVED ===");
    logger.i("Response Status Code: ${response.statusCode}");
    logger.i("Response Headers: ${response.headers}");
    logger.i("Response Body Length: ${response.body.length}");
    logger.i("Raw Response Body: ${response.body}");

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        logger.i("=== PARSED NODE INFO ===");
        responseData.forEach((key, value) {
          if (key == 'identity_pubkey') {
            logger.i("$key: $value ← LIGHTNING NODE IDENTITY");
          } else if (key == 'alias') {
            logger.i("$key: $value");
          } else if (key == 'version') {
            logger.i("$key: $value");
          } else if (key == 'num_active_channels') {
            logger.i("$key: $value");
          } else if (key == 'num_peers') {
            logger.i("$key: $value");
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

        String identityPubkey = responseData['identity_pubkey'] ?? '';
        if (identityPubkey.isNotEmpty) {
          logger.i(
              "✅ Successfully extracted Lightning node identity: $identityPubkey");
        } else {
          logger.w("⚠️ No identity_pubkey found in response");
        }

        return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Node info retrieved successfully",
          data: responseData,
        );
      } catch (jsonError) {
        logger.e("Error parsing JSON response: $jsonError");
        return RestResponse(
          statusCode: "error",
          message: "Failed to parse response: $jsonError",
          data: {"raw_response": response.body},
        );
      }
    } else {
      logger.e("=== HTTP ERROR RESPONSE ===");
      logger.e("Status Code: ${response.statusCode}");
      logger.e("Status Text: ${response.reasonPhrase}");
      logger.e("Response Body: ${response.body}");
      logger.e("Response Headers: ${response.headers}");

      return RestResponse(
        statusCode: "error",
        message:
            "Failed to get node info: ${response.statusCode}, ${response.body}",
        data: {
          "status_code": response.statusCode,
          "raw_response": response.body
        },
      );
    }
  } catch (e, stackTrace) {
    logger.e("=== EXCEPTION CAUGHT ===");
    logger.e("Exception Type: ${e.runtimeType}");
    logger.e("Exception Message: $e");
    logger.e("Stack Trace: $stackTrace");

    if (e.toString().contains('timeout')) {
      logger.e("CONNECTION TIMEOUT - Check if Caddy server is running on $url");
    } else if (e.toString().contains('connection')) {
      logger.e(
          "CONNECTION ERROR - Check network connectivity and server availability");
    }

    return RestResponse(
      statusCode: "error",
      message: "Failed to get node info: $e",
      data: {
        "exception_type": e.runtimeType.toString(),
        "exception_message": e.toString()
      },
    );
  }
}
