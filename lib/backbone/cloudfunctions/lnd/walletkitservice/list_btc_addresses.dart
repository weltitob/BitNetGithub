import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<RestResponse> listBtcAddresses() async {
  LoggerService logger = Get.find();
  String baseUrl = AppTheme.baseUrlLightningTerminal;

  // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
  String url = 'https://$baseUrl/v2/wallet/addresses';

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };
  final Map<String, dynamic> data = {
    'account_name': '' //maybe it will default like the other functions do?
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.get(url: url, headers: headers, data: data);
    logger.i('Raw Response list addresses: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(statusCode: "${response.statusCode}", message: "Successfully listed Adresses", data: response.data);
    } else {
      logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
      return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.data}", data: {});
    }
  } catch (e) {
    logger.e('Error trying to list addresses: $e');
    return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  }
}
