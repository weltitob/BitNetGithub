import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

queryAssetStats(String assetIdStr) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  final RemoteConfigController remoteConfigController =
      Get.find<RemoteConfigController>();

  String restHost =
      remoteConfigController.baseUrlLightningTerminalWithPort.value;

  //String url = 'https://$restHost/v1/taproot-assets/universe/roots/asset-id/$assetIdStr';
  List<int> decodedBytes = base64Decode(assetIdStr);
  String hexStr = bytesToHex(decodedBytes);

  String url =
      // kDebugMode
      //     ? ''
      //     :
      'https://$restHost/v1/taproot-assets/universe/stats/assets?limit=1';

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  // Map<String, dynamic> data = {
  //   // Request a detailed response
  //   'asset_id': assetIdStr,
  // };

  try {
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    logger.i("Raw Response: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      var item = (responseData['asset_stats'] as List)
          .where((test) =>
              test['asset'] != null &&
              test['asset']['asset_name'] == assetIdStr)
          .firstOrNull;
      return responseData;
    } else if (response.statusCode == 500) {
      logger.e(
          "Failed to mint asset (name probably is already in another item in the batch): ${response.statusCode}");
      return null;
    } else {
      logger.e(
          'Failed to load Taproot asset data: ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    logger.e('Error requesting taproot assets: $e');
  }
  return null;
}
