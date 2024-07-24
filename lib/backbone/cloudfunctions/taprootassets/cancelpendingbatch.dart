import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

//USING DIO HERE WILL BREAK THE CODE PLEASE DO NOT UPDATE
cancelMintAsset() async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  String restHost = AppTheme.baseUrlLightningTerminal;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  String url =
  //  kDebugMode
  //     ? ''
  //     :
       'https://$restHost/v1/taproot-assets/assets/mint/cancel';

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode({}),
    );

    logger.i("Raw Response: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      // Process responseData if needed
      return responseData;
    } else {
      logger.e('Failed to cancel minting: ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    logger.e('Error requesting cancel minting: $e');
  }
}
