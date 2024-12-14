import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


// Assuming isCompleteJson is implemented elsewhere and imported correctly
import 'package:bitnet/backbone/helper/isCompleteJSON.dart';

Stream<RestResponse> subscribeTransactionsStream() async* {
  LoggerService logger = Get.find();
  logger.i("Called subscribeTransactions Stream!");
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;

  ByteData byteData = await loadAdminMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  final Map<String, dynamic> data = {};

  HttpOverrides.global = MyHttpOverrides();

  try {
    var request = http.Request('GET', Uri.parse('https://$restHost/v1/transactions/subscribe'))
      ..headers.addAll(headers)
      ..body = json.encode(data);

    var streamedResponse = await request.send();
    var accumulatedData = StringBuffer();

    await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
      accumulatedData.write(chunk); // Accumulate each chunk

      if (isCompleteJson(accumulatedData.toString())) {
        try {
          var jsonResponse = json.decode(accumulatedData.toString());
          accumulatedData.clear(); // Clear accumulatedData for the next JSON object

          yield RestResponse(statusCode: "success", message: "Successfully subscribed to transactions", data: jsonResponse);
        } catch (e) {
          yield RestResponse(statusCode: "error", message: "Error during JSON processing: $e", data: {});
        }
      }
    }
  } catch (e) {
    yield RestResponse(statusCode: "error", message: "Error during network call: $e", data: {});
  }
}
