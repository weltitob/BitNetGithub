import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/isCompleteJSON.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Stream<RestResponse> sendPaymentV2Stream(List<String> invoiceStrings, int? amount) async* {
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;
  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  String url = 'https://$restHost/v2/router/send';

  HttpOverrides.global = MyHttpOverrides();

  final logger = Get.find<LoggerService>();

  for (var invoiceString in invoiceStrings) {
    final invoiceDecoded = Bolt11PaymentRequest(invoiceString);
    String amountInSatFromInvoice = invoiceDecoded.amount.toString();
    logger.i("amountInSatFromInvoice: $amountInSatFromInvoice");
    logger.i("Invoice sats amount: $amount");

    late Map<String, dynamic> data;

    if (amountInSatFromInvoice == "0") {
      logger.i("Invoice amount is 0 so we will use custom amount");
      data = {
        'amt': amount,
        'timeout_seconds': 60,
        'fee_limit_sat': 1000,
        'payment_request': invoiceString,
      };
    } else {
      logger.i("Invoice amount is not 0 so well use the ln invoice amount");
      data = {
        'timeout_seconds': 60,
        'fee_limit_sat': 1000,
        'payment_request': invoiceString,
      };
    }

    try {
      var request = http.Request('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..body = json.encode(data);

      var streamedResponse = await request.send();
      var accumulatedData = StringBuffer();

      await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
        accumulatedData.write(chunk);

        // Debug: Print the accumulated data so we know what we've got.
        logger.i("Accumulated Data: ${accumulatedData.toString()}");

        if (isCompleteJson(accumulatedData.toString())) {
          try {
            var decoded;
            try {
              decoded = json.decode(accumulatedData.toString());
            } catch (jsonError) {
              logger.e("JSON Decode Error: $jsonError");
              yield RestResponse(
                statusCode: "error",
                message: "Error decoding JSON: $jsonError",
                data: {},
              );
              // Clear so we don't get stuck in a loop with bad data
              accumulatedData.clear();
              continue;
            }

            // Clear accumulatedData after successful decode
            accumulatedData.clear();

            // Check if decoded is null or not a map
            if (decoded == null || decoded is! Map<String, dynamic>) {
              logger.e("Decoded JSON is null or not a Map. Decoded: $decoded");
              yield RestResponse(
                statusCode: "error",
                message: "Unexpected JSON structure.",
                data: {},
              );
              continue;
            }

            // Print the decoded JSON to verify structure
            logger.i("Decoded JSON: $decoded");

            // Now safely access fields - check if keys exist
            // For example, if you expect a "status" field:
            if (!decoded.containsKey("status")) {
              logger.e("No 'status' key found in response!");
              yield RestResponse(
                statusCode: "error",
                message: "No status key in JSON response",
                data: decoded,
              );
              continue;
            }

            yield RestResponse(
              statusCode: "success",
              message: "Payment processed",
              data: decoded,
            );
          } catch (e) {
            logger.e("Error during JSON processing: $e");
            yield RestResponse(
              statusCode: "error",
              message: "Error during JSON processing: $e",
              data: {},
            );
          }
        }
      }
    } catch (e) {
      logger.e("Network Error: $e");
      yield RestResponse(
        statusCode: "error",
        message: "Error during network call: $e",
        data: {},
      );
    }

    // Add a delay between sends if necessary
    await Future.delayed(const Duration(seconds: 10));
  }
}
