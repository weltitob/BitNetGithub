import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Stream<RestResponse> subscribeInvoicesStream() async* {
  print("Called subscribeInvoices Stream!"); // The combined JSON response
  const String restHost = 'mybitnet.com:8443'; // Update the host as needed
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
    print("Trying to make request to subscribeInvoices Stream!");
    var request = http.Request('GET', Uri.parse('https://$restHost/v1/invoices/subscribe'))
      ..headers.addAll(headers)
      ..body = json.encode(data);

    var streamedResponse = await request.send();
    var completeResponse = StringBuffer();

    await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
      print("CHUNK RECEIVED!");
      completeResponse.write(chunk);
    }

    // Here we have the complete response
    var jsonResponse = json.decode(completeResponse.toString());
    print(jsonResponse); // The combined JSON response
  } catch (e) {
    print('Error: $e');
    // If an error occurs, yield an error RestResponse. Adjust as necessary for your error handling.
    yield RestResponse(statusCode: "error", message: "Error during network call: $e", data: {});
  }
}