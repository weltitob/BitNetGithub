import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<RestResponse> addInvoice(int amount, String? memo) async {
  const String restHost = 'mybitnet.com:8443'; // Update the host as needed
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
  // Make the GET request
  String url = 'https://$restHost/v1/invoices';
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
    'memo': memo ?? "",
    'value': amount,
    'expiry': 1000,
    'fallback_addr': 'bc1qtfmrfu3n5vx8jgep5vw2s7z68u0aq40c24e2ps',
    'private': false,
    'is_keysend': true
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    var response = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));
    // Print raw response for debugging
    print('Raw Response: ${response.body}');

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return RestResponse(statusCode: "${response.statusCode}", message: "Successfully added invoice", data: json.decode(response.body));

    } else {
      print('Failed to load data: ${response.statusCode}, ${response.body}');
      return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.body}", data: {});
    }
  } catch (e) {
    print('Error: $e');
    return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  }
}