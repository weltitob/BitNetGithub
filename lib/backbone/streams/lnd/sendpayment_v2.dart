import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//
// //THIS SENDS BITCOIN BE CAREFUL NOT HAT IT SENDS AGAIN AND AGAIN I WANT IT TO RETURN WHAT HAPPENS WITH THE PAYMENT AFTER I CALL IT ONCE FROM THE SERVER
// Stream<RestResponse> sendPaymentsStream(List<String> invoiceStrings) async* {
//   const String restHost = 'mybitnet.com:8443'; // Update the host as needed
//   const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
//   String url = 'https://$restHost/v2/router/send';
//
//   ByteData byteData = await loadMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);
//
//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };
//
//   for (var invoiceString in invoiceStrings) {
//     final Map<String, dynamic> data = {
//       'timeout_seconds': 60,
//       'fee_limit_sat': 1000,
//       'payment_request': invoiceString,
//     };
//
//     HttpOverrides.global = MyHttpOverrides();
//
//     try {
//       var request = http.Request('POST', Uri.parse(url))
//         ..headers.addAll(headers)
//         ..body = json.encode(data);
//
//       var streamedResponse = await request.send();
//       var completeResponse = StringBuffer();
//
//       await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
//         completeResponse.write(chunk);
//       }
//
//       var jsonResponse = json.decode(completeResponse.toString());
//       yield RestResponse.fromJson(jsonResponse);
//     } catch (e) {
//       yield RestResponse(statusCode: "error", message: "Error during network call: $e", data: {});
//     }
//
//     // Implement your logic for when to send the next payment
//     // For example, wait for some time before sending the next one
//     await Future.delayed(Duration(seconds: 10)); // Adjust delay as needed
//   }
// }



Future<RestResponse> sendPaymentV2(String invoice_string) async {
  const String restHost = 'mybitnet.com:8443'; // Update the host as needed
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
  // Make the GET request
  String url = 'https://$restHost/v2/router/send';
  // Read the macaroon file and convert it to a hexadecimal string
  ByteData byteData = await loadMacaroonAsset();
  // Convert ByteData to List<int>
  List<int> bytes = byteData.buffer.asUint8List();
  // Convert bytes to hex string
  String macaroon = bytesToHex(bytes);

  //String macaroon = bytesToHex(await File(macaroonPath).readAsBytes());
  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };
  final Map<String, dynamic> data = {
    'timeout_seconds': 60,
    'fee_limit_sat': 1000,
    'payment_request': invoice_string //invoice_string,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    var request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = json.encode(data);

    var streamedResponse = await request.send();
    var completeResponse = StringBuffer();

    await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
      completeResponse.write(chunk);
    }

    // Here we have the complete response
    var jsonResponse = json.decode(completeResponse.toString());
    print(jsonResponse); // The combined JSON response

    // Now create the CloudfunctionCallback from the combined JSON
    return RestResponse.fromJson(jsonResponse);
  } catch (e) {
    print('Error: $e');
    return RestResponse(statusCode: "error", message: "Error during network call: $e", data: {});
  }

  // try {
  //   var response = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));
  //   // Print raw response for debugging
  //   print('Raw Response: ${response.body}');
  //
  //   if (response.statusCode == 200) {
  //     print(json.decode(response.body));
  //     return CloudfunctionCallback.fromJson(json.decode(response.body));
  //
  //   } else {
  //     print('Failed to load data: ${response.statusCode}, ${response.body}');
  //     return CloudfunctionCallback(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.body}", data: {});
  //   }
  // } catch (e) {
  //   print('Error: $e');
  //   return CloudfunctionCallback(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  // }
}