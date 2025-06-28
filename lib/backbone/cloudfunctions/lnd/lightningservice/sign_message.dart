import 'dart:io';
import 'dart:convert';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<RestResponse> signMessageWithNode(
    {required String message,
    String? nodeId,
    String? adminMacaroon,
    String? userDid}) async {
  LoggerService logger = Get.find();

  // Use centralized Lightning configuration
  String selectedNode = nodeId ?? LightningConfig.getDefaultNodeId();
  String url =
      LightningConfig.getLightningUrl('v1/signmessage', nodeId: selectedNode);

  logger.i("=== SIGN MESSAGE DEBUG ===");
  logger.i("Target URL: $url");
  logger.i("Selected Node: $selectedNode");
  logger.i("User DID: $userDid");
  logger.i("Caddy Base URL: ${LightningConfig.caddyBaseUrl}");
  logger.i("Message to sign: '$message'");

  // Base64 encode the message
  String encodedMessage = base64Encode(utf8.encode(message));
  logger.i("Base64 encoded message: $encodedMessage");

  // Validate base64 encoding
  if (!RegExp(r'^[A-Za-z0-9+/]*={0,2}$').hasMatch(encodedMessage)) {
    logger.e("❌ Invalid base64 encoding: $encodedMessage");
    throw Exception("Message base64 encoding is invalid");
  }

  Map<String, dynamic> data = {
    'msg': encodedMessage,
  };

  logger.i("=== REQUEST PAYLOAD ===");
  logger.i("Request data: ${json.encode(data)}");

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
        // Convert base64 macaroon to hex format for Lightning API
        try {
          List<int> macaroonBytes = base64Decode(nodeMapping.adminMacaroon);
          macaroon = macaroonBytes
              .map((b) => b.toRadixString(16).padLeft(2, '0'))
              .join('');
          logger.i("🔑 Converted base64 macaroon to hex format");
        } catch (e) {
          logger.e("❌ Failed to convert base64 macaroon to hex: $e");
          throw Exception("Failed to convert macaroon format: $e");
        }

        selectedNode = nodeMapping.nodeId; // Use user's specific node
        url = LightningConfig.getLightningUrl('v1/signmessage',
            nodeId: selectedNode);
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
    // Use the hex string directly from remote config instead of converting ByteData
    macaroon = remoteConfigController.adminMacaroon.value;
    logger.w(
        "⚠️ Using global admin macaroon as fallback: ${macaroon.substring(0, 20)}... (truncated)");

    if (macaroon.isEmpty) {
      logger.e("❌ Admin macaroon from remote config is empty");
      throw Exception("Admin macaroon from remote config is empty");
    }
  }

  // Validate macaroon is valid hex
  if (!RegExp(r'^[0-9a-fA-F]+$').hasMatch(macaroon)) {
    logger.e("❌ Invalid macaroon hex format: ${macaroon.substring(0, 50)}...");
    throw Exception("Macaroon contains invalid hex characters");
  }

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  logger.i("=== REQUEST HEADERS ===");
  headers.forEach((key, value) {
    if (key == 'Grpc-Metadata-macaroon') {
      logger.i("$key: ${value.substring(0, 20)}... (truncated)");
      logger.i("Macaroon length: ${value.length} characters");
      logger.i(
          "Macaroon valid hex: ${RegExp(r'^[0-9a-fA-F]+$').hasMatch(value)}");
    } else {
      logger.i("$key: $value");
    }
  });

  // Override HTTP settings if necessary
  HttpOverrides.global = MyHttpOverrides();

  logger.i("=== MAKING HTTP REQUEST ===");
  logger.i("About to make POST request to: $url");

  // Retry mechanism for "lnd is not ready" errors
  int maxRetries = 20;
  int retryDelay = 2; // seconds

  for (int attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      logger.i("=== ATTEMPT $attempt/$maxRetries ===");

      var response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: json.encode(data),
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
          logger.i("=== PARSED SIGNATURE RESPONSE ===");
          responseData.forEach((key, value) {
            if (key == 'signature') {
              logger.i("$key: $value ← LIGHTNING NODE SIGNATURE");
            } else {
              logger.i("$key: $value");
            }
          });

          String signature = responseData['signature'] ?? '';
          if (signature.isNotEmpty) {
            logger.i("✅ Successfully generated Lightning signature");
            logger.i("Signature length: ${signature.length} characters");
          } else {
            logger.w("⚠️ No signature found in response");
          }

          return RestResponse(
            statusCode: "${response.statusCode}",
            message: "Message signed successfully with Lightning node",
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

        // Check if this is a "lnd is not ready" error that we should retry
        if (response.statusCode == 500 &&
            response.body.contains("lnd is not ready") &&
            attempt < maxRetries) {
          logger
              .w("⚠️ Lightning node not ready (attempt $attempt/$maxRetries)");
          logger.w("⏱️ Waiting ${retryDelay}s before retry...");
          await Future.delayed(Duration(seconds: retryDelay));
          continue; // Retry the request
        }

        return RestResponse(
          statusCode: "error",
          message:
              "Failed to sign message: ${response.statusCode}, ${response.body}",
          data: {
            "status_code": response.statusCode,
            "raw_response": response.body
          },
        );
      }
    } catch (e, stackTrace) {
      logger.e("=== EXCEPTION CAUGHT ON ATTEMPT $attempt ===");
      logger.e("Exception Type: ${e.runtimeType}");
      logger.e("Exception Message: $e");
      logger.e("Stack Trace: $stackTrace");

      if (e.toString().contains('timeout')) {
        logger
            .e("CONNECTION TIMEOUT - Check if Caddy server is running on $url");
      } else if (e.toString().contains('connection')) {
        logger.e(
            "CONNECTION ERROR - Check network connectivity and server availability");
      }

      // For connection errors, retry if we have attempts left
      if (attempt < maxRetries &&
          (e.toString().contains('connection') ||
              e.toString().contains('timeout'))) {
        logger.w("⚠️ Connection error (attempt $attempt/$maxRetries)");
        logger.w("⏱️ Waiting ${retryDelay}s before retry...");
        await Future.delayed(Duration(seconds: retryDelay));
        continue; // Retry the request
      }

      return RestResponse(
        statusCode: "error",
        message: "Failed to sign message: $e",
        data: {
          "exception_type": e.runtimeType.toString(),
          "exception_message": e.toString()
        },
      );
    }
  }

  // If we get here, all retries failed
  logger.e("❌ All $maxRetries attempts failed");
  return RestResponse(
    statusCode: "error",
    message: "Failed to sign message after $maxRetries attempts",
    data: {"max_retries_exceeded": true},
  );
}
