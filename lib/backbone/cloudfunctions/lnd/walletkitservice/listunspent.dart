import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<RestResponse> listUnspent(String account) async {
  LoggerService logger = Get.find();

  try {
    final litdController = Get.find<LitdController>();
    final remoteConfigController = Get.find<RemoteConfigController>();

    // Wait for remote config to be loaded before proceeding
    if (remoteConfigController.adminMacaroonByteData == null ||
        litdController.litd_baseurl.value.isEmpty) {
      logger.w("Remote config not loaded yet, waiting...");
      await remoteConfigController.fetchRemoteConfigData();

      // Check again after fetching
      if (remoteConfigController.adminMacaroonByteData == null ||
          litdController.litd_baseurl.value.isEmpty) {
        logger.e("Remote config failed to load properly");
        return RestResponse(
            statusCode: "error",
            message: "Remote configuration not available",
            data: {});
      }
    }

    final String restHost = litdController.litd_baseurl.value;
    if (restHost.isEmpty) {
      logger.e("Lightning node URL not configured");
      return RestResponse(
          statusCode: "error",
          message: "Lightning node URL not configured",
          data: {});
    }

    String url = 'https://$restHost/v2/wallet/utxos';

    ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
    List<int> bytes = byteData.buffer.asUint8List();
    String macaroon = bytesToHex(bytes);

    Map<String, String> headers = {
      'Grpc-Metadata-macaroon': macaroon,
    };
    final Map<String, dynamic> data = {
      'min_confs': 4,
      'max_confs': 999999,
      'account': account,
      'unconfirmed_only':
          false, //false or true decides if only unconfirmed utxos are returned
    };

    HttpOverrides.global = MyHttpOverrides();

    final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.post(
        url: url, headers: headers, data: json.encode(data));
    logger.i('Raw Response List Unspent: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully added invoice",
          data: response.data);
    } else {
      logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
      return RestResponse(
          statusCode: "error",
          message:
              "Failed to load data: ${response.statusCode}, ${response.data}",
          data: {});
    }
  } catch (e) {
    logger.e('Error trying to list unspent: $e');
    return RestResponse(
        statusCode: "error",
        message:
            "Failed to load data: Could not get response from Lightning node!",
        data: {});
  }
}
