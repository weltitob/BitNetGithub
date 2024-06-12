import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

Future<List<Asset>> listTaprootAssets() async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  String restHost = AppTheme.baseUrlLightningTerminal;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  // Make the GET request
  String url = kDebugMode ? '' : 'https://$restHost/v1/taproot-assets/assets';
  try {
    final DioClient dioClient = Get.find<DioClient>();
    var response = await dioClient.get(url: url, headers: headers);

    logger.i("Raw Response: ${response}");

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['assets'];
      return data.map((item) => Asset.fromJson(item)).toList();
    } else {
      logger.e(
          'Failed to load Taproot asset data: ${response.statusCode}, ${response}');
      return [];
    }
  } catch (e) {
    logger.e('Error requesting taproot assets: $e');
    return [];
  }
}
