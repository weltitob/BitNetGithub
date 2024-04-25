import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/isCompleteJSON.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Stream<RestResponse> subscribeInvoicesStream() async* {
  Logs().w("Called subscribeInvoices Stream!"); // The combined JSON response
  String restHost = AppTheme.baseUrlLightningTerminal;
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file

  // Read the macaroon file and convert it to a hexadecimal string
  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  // The data map seems empty here, adjust as necessary
  final Map<String, dynamic> data = {};

  HttpOverrides.global = MyHttpOverrides();

  try {
    Logs().w("Trying to make request to subscribeInvoices Stream!");
    var request = http.Request('GET', Uri.parse('https://$restHost/v1/invoices/subscribe'))
      ..headers.addAll(headers)
      ..body = json.encode(data);

    var streamedResponse = await request.send();
    var accumulatedData = StringBuffer(); // Used to accumulate chunks

    await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
      accumulatedData.write(chunk); // Accumulate each chunk

      // Check if accumulated data forms a complete JSON object
      if (isCompleteJson(accumulatedData.toString())) {
        try {
          var jsonResponse = json.decode(accumulatedData.toString());
          // Clear accumulatedData for the next JSON object
          accumulatedData.clear();

          // Yield the successful response
          yield RestResponse(statusCode: "success", message: "Successfully subscribed to invoices", data: jsonResponse);
        } catch (e) {
          // Handle JSON decode error or other errors
          yield RestResponse(statusCode: "error", message: "Error during JSON processing: $e", data: {});
        }
      }
    }

  } catch (e) {
    print('Error: $e');
    // If an error occurs, yield an error RestResponse. Adjust as necessary for your error handling.
    yield RestResponse(statusCode: "error", message: "Error during network call: $e", data: {});
  }
}
