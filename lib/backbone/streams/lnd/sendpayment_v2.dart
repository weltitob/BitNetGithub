import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/isCompleteJSON.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;



Stream<RestResponse> sendPaymentV2Stream(List<String> invoiceStrings) async* {
  String restHost = AppTheme.baseUrlLightningTerminal;
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon';  // Update the path to the macaroon file

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  String url = 'https://$restHost/v2/router/send';

  HttpOverrides.global = MyHttpOverrides();

  for (var invoiceString in invoiceStrings) {
    final Map<String, dynamic> data = {
      'timeout_seconds': 60,
      'fee_limit_sat': 1000,
      'payment_request': invoiceString,
    };

    try {
      var request = http.Request('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..body = json.encode(data);

      var streamedResponse = await request.send();
      var accumulatedData = StringBuffer();  // Used to accumulate chunks

      await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
        accumulatedData.write(chunk);  // Accumulate each chunk

        // Check if accumulated data forms a complete JSON object
        if (isCompleteJson(accumulatedData.toString())) {
          try {
            var jsonResponse = json.decode(accumulatedData.toString());
            // Clear accumulatedData for the next JSON object
            accumulatedData.clear();

            // Yield the successful response
            yield RestResponse(statusCode: "success", message: "Payment processed", data: jsonResponse);
          } catch (e) {
            // Handle JSON decode error or other errors
            yield RestResponse(statusCode: "error", message: "Error during JSON processing: $e", data: {});
          }
        }
      }
    } catch (e) {
      yield RestResponse(statusCode: "error", message: "Error during network call: $e", data: {});
    }

    // Implement your logic for when to send the next payment
    // For example, wait for some time before sending the next one
    await Future.delayed(Duration(seconds: 10));  // Adjust delay as needed
  }
}



//
// Future<RestResponse> sendPaymentV2(String invoice_string, dynamic amountInSat) async {
//   const String restHost = 'mybitnet.com:8443'; // Update the host as needed
//   const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
//   // Make the GET request
//   String url = 'https://$restHost/v2/router/send';
//   // Read the macaroon file and convert it to a hexadecimal string
//   ByteData byteData = await loadMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);
//
//   // Calculate the fee limit as 2% of the amount and round it up
//   int feeLimitSat = (amountInSat * 0.02).ceil();
//
//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };
//
//   final Map<String, dynamic> data = {
//     'timeout_seconds': 60,
//     'fee_limit_sat': feeLimitSat,
//     'payment_request': invoice_string //invoice_string,
//   };
//
//   HttpOverrides.global = MyHttpOverrides();
//
//   try {
//     var request = http.Request('POST', Uri.parse(url))
//       ..headers.addAll(headers)
//       ..body = json.encode(data);
//
//     var streamedResponse = await request.send();
//     var completeResponse = StringBuffer();
//
//     await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
//       completeResponse.write(chunk);
//     }
//
//     // Here we have the complete response
//     var jsonResponse = json.decode(completeResponse.toString());
//     print(jsonResponse); // The combined JSON response
//
//     // Now create the CloudfunctionCallback from the combined JSON
//     return RestResponse.fromJson(jsonResponse);
//   } catch (e) {
//     print('Error: $e');
//     return RestResponse(statusCode: "error", message: "Error during network call: $e", data: {});
//   }
// }