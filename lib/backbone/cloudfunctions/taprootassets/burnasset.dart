import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;



burnAsset(String assetIdString) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  String restHost = AppTheme.baseUrlLightningTerminal;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  final url = Uri.parse('https://$restHost/v1/taproot-assets/burn');

// Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  // Replace <bytes>, <string>, <uint64>, and <string> with actual values
  //convert string to bytes

  // Convert string to bytes
  final assetIdBytes = utf8.encode(assetIdString);

  // Convert bytes to hex
  final assetIdHex = assetIdBytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

  // Create data
  final data = {
  'asset_id': assetIdHex,
  //'asset_id_str': assetIdString,
  'amount_to_burn': 1,
  'confirmation_text': "assets will be destroyed",
  };

  // Send POST request
  final response = await http.post(url, headers: headers, body: jsonEncode(data));

  // Print the response
  print(jsonDecode(response.body));
}
