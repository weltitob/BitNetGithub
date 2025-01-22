import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:get/get.dart';

Future<AssetMetaResponse?> fetchAssetMeta(String asset_id) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();
  String restHost = remoteConfigController.baseUrlLightningTerminalWithPort.value;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  List<int> decodedBytes = base64Decode(asset_id);
  String hexStr =
      decodedBytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  print("Hex string: $hexStr");

  // Make the GET request
  String url = 'https://$restHost/v1/taproot-assets/assets/meta/asset-id/$hexStr';
  // String url = kDebugMode
  //     ? ''
  //     : 'https://$restHost/v1/taproot-assets/assets/meta/asset-id/$hexStr';
  try {
    final DioClient dioClient = Get.find<DioClient>();
    var response = await dioClient.get(url: url, headers: headers);

    logger.i("Raw Response assets meta data : ${response}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      if (responseData.containsKey('data')) {
        return AssetMetaResponse.fromJson(responseData);
      } else {
        logger.e("The response JSON does not contain 'data' key.");
        return null;
      }
    } else {
      logger.e(
          'Failed to fetch asset meta data: ${response.statusCode}, ${response}');
      return null;
    }
  } catch (e) {
    logger.e('Error requesting asset meta data: $e');
    return null;
  }
}
