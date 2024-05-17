import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<RestResponse> walletBalance() async {
  String restHost = AppTheme.baseUrlLightningTerminal;
  // const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
  String url = 'https://$restHost/v1/balance/blockchain';

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
      final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.get(
      url:url,
      headers: headers,
    );
    // Print raw response for debugging
    print('Raw Response: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully retrieved OnChain Balance",
          data: response.data);
    } else {
      print('Failed to load data: ${response.statusCode}, ${response.data}');
      return RestResponse(
          statusCode: "error",
          message:
              "Failed to load data: ${response.statusCode}, ${response.data}",
          data: {});
    }
  } catch (e) {
    print('Error: $e');
    return RestResponse(
        statusCode: "error",
        message:
            "Failed to load data: Could not get response from Lightning node!",
        data: {});
  }
}
