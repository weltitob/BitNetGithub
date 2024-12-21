import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';

Future<RestResponse> addInvoice(int amount, String? memo, String fallbackAddress) async {
  HttpOverrides.global = MyHttpOverrides();

  final logger = Get.find<LoggerService>();
  logger.i("Calling addInvoice() with fallback address $fallbackAddress");

  // 1. Try finding LitdController
  LitdController? litdController;
  try {
    litdController = Get.find<LitdController>();
  } catch (e) {
    logger.e("LitdController not found: $e");
    return RestResponse(
        statusCode: "error",
        message: "LitdController not found!",
        data: {}
    );
  }

  // 2. Check if litd_baseurl is set
  final String? restHost = litdController?.litd_baseurl.value.isNotEmpty == true
      ? litdController.litd_baseurl.value
      : null;
  if (restHost == null) {
    logger.e("litd_baseurl is null or empty.");
    return RestResponse(
        statusCode: "error",
        message: "LITD base URL is empty!",
        data: {}
    );
  }

  // 3. Load macaroon
  ByteData? byteData;
  try {
    byteData = await loadMacaroonAsset();
    if (byteData == null) {
      throw Exception("Macaroon asset is null");
    }
  } catch (e, stackTrace) {
    logger.e("Error loading macaroon asset: $e\n$stackTrace");
    return RestResponse(
        statusCode: "error",
        message: "Error loading macaroon asset",
        data: {}
    );
  }

  // Convert bytes to base64
  final List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare headers and payload
  final String url = 'https://$restHost/v1/invoices';
  final Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  final Map<String, dynamic> data = {
    'memo': memo ?? "",
    'value': amount,
    'expiry': 1200,
    'fallback_addr': fallbackAddress,
    'private': false,
    'is_keysend': true,
  };

  // 4. Post invoice request using http package
  try {
    logger.i("Making POST request to $url with headers $headers and payload $data");
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    // Check the response
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      logger.i("Successfully added invoice: $responseData");
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully added invoice",
          data: responseData
      );
    } else {
      logger.e("Failed to add invoice. Status: ${response.statusCode}, Body: ${response.body}");
      return RestResponse(
          statusCode: "error",
          message: "Failed to add invoice: ${response.statusCode}",
          data: jsonDecode(response.body)
      );
    }
  } catch (e, stackTrace) {
    logger.e("Error in HTTP POST: $e\nStackTrace: $stackTrace");
    return RestResponse(
        statusCode: "error",
        message: "Failed to add invoice due to an error",
        data: {}
    );
  }
}
