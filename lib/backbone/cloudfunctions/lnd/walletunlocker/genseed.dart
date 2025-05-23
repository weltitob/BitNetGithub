import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<RestResponse> generateSeed({String? nodeId}) async {
  LoggerService logger = Get.find();
  
  // Use Caddy server routing for MVP - hardcoded to node4 for now
  String caddyBaseUrl = 'http://[2a02:8070:880:1e60:da3a:ddff:fee8:5b94]';
  String selectedNode = nodeId ?? 'node4'; // Default to node4 for MVP
  String url = '$caddyBaseUrl/$selectedNode/v1/genseed'; // No passphrase to match Python approach

  logger.i("=== GENERATE SEED DEBUG INFO ===");
  logger.i("Target URL: $url");
  logger.i("Selected Node: $selectedNode");
  logger.i("Caddy Base URL: $caddyBaseUrl");

  // Load and convert the macaroon asset
  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();

  ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);
  logger.i("Admin macaroon loaded for genseed: ${macaroon.substring(0, 20)}... (truncated)");

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  logger.i("=== GENSEED REQUEST HEADERS ===");
  headers.forEach((key, value) {
    if (key == 'Grpc-Metadata-macaroon') {
      logger.i("$key: ${value.substring(0, 20)}... (truncated)");
    } else {
      logger.i("$key: $value");
    }
  });

  // Override HTTP settings if necessary
  HttpOverrides.global = MyHttpOverrides();

  logger.i("=== MAKING GENSEED HTTP REQUEST ===");
  logger.i("About to make GET request to: $url");

  try {
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    ).timeout(Duration(seconds: 30)); // Add explicit timeout

    logger.i("=== GENSEED HTTP RESPONSE RECEIVED ===");
    logger.i("Response Status Code: ${response.statusCode}");
    logger.i("Response Headers: ${response.headers}");
    logger.i("Response Body Length: ${response.body.length}");
    logger.i("Raw Response Body: ${response.body}");

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        logger.i("=== PARSED GENSEED RESPONSE DATA ===");
        responseData.forEach((key, value) {
          if (key == 'cipher_seed_mnemonic' && value is List) {
            logger.i("$key: ${value.length} words - ${value.join(' ')}");
          } else if (key == 'enciphered_seed') {
            logger.i("$key: ${value.toString().substring(0, 20)}... (truncated)");
          } else {
            logger.i("$key: $value");
          }
        });

        return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Seed generated successfully",
          data: responseData,
        );
      } catch (jsonError) {
        logger.e("Error parsing JSON response: $jsonError");
        return RestResponse(
          statusCode: "error",
          message: "Failed to parse genseed response: $jsonError",
          data: {"raw_response": response.body},
        );
      }
    } else {
      logger.e("=== GENSEED HTTP ERROR RESPONSE ===");
      logger.e("Status Code: ${response.statusCode}");
      logger.e("Status Text: ${response.reasonPhrase}");
      logger.e("Response Body: ${response.body}");
      logger.e("Response Headers: ${response.headers}");
      
      return RestResponse(
        statusCode: "error",
        message: "Failed to generate seed: ${response.statusCode}, ${response.body}",
        data: {"status_code": response.statusCode, "raw_response": response.body},
      );
    }
  } catch (e, stackTrace) {
    logger.e("=== GENSEED EXCEPTION CAUGHT ===");
    logger.e("Exception Type: ${e.runtimeType}");
    logger.e("Exception Message: $e");
    logger.e("Stack Trace: $stackTrace");
    
    if (e.toString().contains('timeout')) {
      logger.e("GENSEED CONNECTION TIMEOUT - Check if Caddy server is running on $url");
    } else if (e.toString().contains('connection')) {
      logger.e("GENSEED CONNECTION ERROR - Check network connectivity and server availability");
    }
    
    return RestResponse(
      statusCode: "error",
      message: "Failed to generate seed: $e",
      data: {"exception_type": e.runtimeType.toString(), "exception_message": e.toString()},
    );
  }
}
