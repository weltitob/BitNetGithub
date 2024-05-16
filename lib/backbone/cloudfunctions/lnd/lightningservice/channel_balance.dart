import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;

Future<RestResponse> channelBalance() async {
  String restHost = AppTheme.baseUrlLightningTerminal; // Update the host as needed
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
  String url = 'https://$restHost/v1/balance/channels';

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    Dio dio = Dio();
    var response = await dio.get(url,);
    dio.options.headers['Grpc-Metadata-macaroon'] = macaroon;
 
     // Print raw response for debugging
    print('Raw Response: ${response.data}');

    if (response.statusCode == 200) {
      print(json.decode(response.data));
      return RestResponse(statusCode: "${response.statusCode}", message: "Successfully retrived Lightning Balance", data: response.data);

    } else {
      print('Failed to load data: ${response.statusCode}, ${response.data}');
      return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.data}", data: {});
    }
  } catch (e) {
    print('Error: $e');
    return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  }
}