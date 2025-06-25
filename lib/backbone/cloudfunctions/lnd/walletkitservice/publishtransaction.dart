import 'dart:io';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<RestResponse> publishTransaction(String tx_hex, String label) async {
  LoggerService logger = Get.find();
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;
  // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
  String url = 'https://$restHost/v2/wallet/tx';

  final RemoteConfigController remoteConfigController =
      Get.find<RemoteConfigController>();
  ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };
  final Map<String, dynamic> data = {
    'tx_hex': tx_hex,
    'label': label,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.post(url: url, headers: headers, data: data);
    logger.i('Raw Response Publish Transaction: ${response.data}');

    if (response.statusCode == 200) {
      logger.i("Successfully published transaction ${response.data}");
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully published transaction",
          data: response.data.to);
    } else {
      logger.e(
          'Failed to load data (publishtransaction.dart): ${response.statusCode}, ${response.data}');
      return RestResponse(
          statusCode: "error",
          message:
              "Failed to load data: ${response.statusCode}, ${response.data}",
          data: {});
    }
  } catch (e) {
    logger.e('Error trying to publish transaction: $e');
    return RestResponse(
        statusCode: "error",
        message:
            "Failed to load data: Could not get response from Lightning node!",
        data: {});
  }
}
