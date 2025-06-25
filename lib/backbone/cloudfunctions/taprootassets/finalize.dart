import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<dynamic> finalizeMint() async {
  print("🔥🔥🔥 FINALIZE MINT FUNCTION STARTED 🔥🔥🔥");
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  final RemoteConfigController remoteConfigController =
      Get.find<RemoteConfigController>();

  // Use the same host configuration as mint and other working endpoints
  String restHost =
      remoteConfigController.baseUrlLightningTerminalWithPort.value;

  print("🔥🔥🔥 HOST VALUE: $restHost 🔥🔥🔥");
  logger.i("Using baseUrlLightningTerminalWithPort: $restHost");
  logger.i("Full host value: $restHost");

  print("🔥🔥🔥 LOADING TAPD MACAROON 🔥🔥🔥");
  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);
  print("🔥🔥🔥 MACAROON LOADED SUCCESSFULLY 🔥🔥🔥");

  // Try cancel endpoint pattern first since we know it works
  String url = 'https://$restHost/v1/taproot-assets/assets/mint/cancel';

  print("🔥🔥🔥 TRYING URL PATTERN: $url 🔥🔥🔥");
  logger.i(
      "Attempting to finalize mint with URL pattern from cancel endpoint: $url");

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  print("🔥🔥🔥 HEADERS PREPARED 🔥🔥🔥");
  logger.i("Headers: $headers");

  // Prepare the data to be sent in the request
  Map<String, dynamic> data = {
    'short_response': false,
  };

  print("🔥🔥🔥 REQUEST PAYLOAD PREPARED: ${json.encode(data)} 🔥🔥🔥");

  try {
    // First let's try the cancel URL pattern but with "finalize" instead of "cancel"
    String mainUrl = 'https://$restHost/v1/taproot-assets/assets/mint/finalize';
    print("🔥🔥🔥 SENDING MAIN REQUEST TO: $mainUrl 🔥🔥🔥");

    try {
      var response = await http.post(
        Uri.parse(mainUrl),
        headers: headers,
        body: json.encode(data),
      );

      print("🔥🔥🔥 MAIN REQUEST RESPONSE CODE: ${response.statusCode} 🔥🔥🔥");
      logger.i("Raw Response: ${response.body}");
      logger.i("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print("🔥🔥🔥 MAIN REQUEST SUCCEEDED! 🔥🔥🔥");
        logger.i(
            "Finalized minting batch response: ${json.encode(responseData)}");
        return responseData;
      }
    } catch (e) {
      print("🔥🔥🔥 MAIN REQUEST FAILED: $e 🔥🔥🔥");
    }

    // Try alternative endpoints if first one fails
    List<String> fallbackUrls = [
      // Try patterns with variations
      'https://$restHost/v1/taproot-assets/assets/finalize',
      'https://$restHost/v1/taproot-assets/finalize',
      'https://$restHost/v1/taproot-assets/assets',
      'https://$restHost/v1/taproot-assets/mint/finalize',
    ];

    for (int i = 0; i < fallbackUrls.length; i++) {
      String fallbackUrl = fallbackUrls[i];
      print("🔥🔥🔥 ATTEMPTING FALLBACK URL #${i + 1}: $fallbackUrl 🔥🔥🔥");
      logger.i("Attempting fallback URL #${i + 1}: $fallbackUrl");

      try {
        var fallbackResponse = await http.post(
          Uri.parse(fallbackUrl),
          headers: headers,
          body: json.encode(data),
        );

        print(
            "🔥🔥🔥 FALLBACK #${i + 1} RESPONSE CODE: ${fallbackResponse.statusCode} 🔥🔥🔥");
        logger
            .i("Fallback response status code: ${fallbackResponse.statusCode}");
        logger.i("Fallback raw response: ${fallbackResponse.body}");

        if (fallbackResponse.statusCode == 200) {
          Map<String, dynamic> responseData =
              json.decode(fallbackResponse.body);
          print(
              "🔥🔥🔥 SUCCESS! FALLBACK #${i + 1} SUCCEEDED WITH URL: $fallbackUrl 🔥🔥🔥");
          logger
              .i("SUCCESS! Fallback request succeeded with URL: $fallbackUrl");
          return responseData;
        } else {
          print(
              "🔥🔥🔥 FALLBACK #${i + 1} FAILED WITH STATUS: ${fallbackResponse.statusCode} 🔥🔥🔥");
          logger.e(
              "Fallback request to $fallbackUrl failed. Status code: ${fallbackResponse.statusCode}");
        }
      } catch (e) {
        print("🔥🔥🔥 ERROR TRYING FALLBACK #${i + 1}: $e 🔥🔥🔥");
        logger.e("Error trying fallback URL $fallbackUrl: $e");
      }
    }

    print("🔥🔥🔥 ALL URL ATTEMPTS FAILED 🔥🔥🔥");
    logger.e("All URL attempts failed");
    return null;
  } catch (e) {
    print("🔥🔥🔥 GLOBAL ERROR IN FINALIZE MINT: $e 🔥🔥🔥");
    logger.e("Error finalizing mint batch: $e");
    return null;
  }
}
