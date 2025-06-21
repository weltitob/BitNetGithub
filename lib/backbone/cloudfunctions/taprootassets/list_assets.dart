import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:get/get.dart';

Future<List<Asset>> listTaprootAssets() async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  try {
    final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();
    
    // Wait for remote config to be loaded before proceeding
    if (remoteConfigController.baseUrlLightningTerminalWithPort.value.isEmpty) {
      logger.w("Lightning terminal URL not loaded yet, waiting...");
      await remoteConfigController.fetchRemoteConfigData();
      
      // Check again after fetching
      if (remoteConfigController.baseUrlLightningTerminalWithPort.value.isEmpty) {
        logger.e("Lightning terminal URL failed to load");
        return [];
      }
    }
    
    String restHost = remoteConfigController.baseUrlLightningTerminalWithPort.value;
    if (restHost.isEmpty) {
      logger.e("Lightning terminal URL not configured");
      return [];
    }

    dynamic byteData = await loadTapdMacaroonAsset();
    List<int> bytes = byteData.buffer.asUint8List();
    String macaroon = bytesToHex(bytes);
    // Prepare the headers
    Map<String, String> headers = {
      'Grpc-Metadata-macaroon': macaroon,
    };

    // Make the GET request
    String url = 'https://$restHost/v1/taproot-assets/assets';
    
    final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.get(url: url, headers: headers);
    logger.i("Raw Response: ${response}");

    if (response.statusCode == 200) {
      List<dynamic> data = response.data['assets'];
      return data.map((item) => Asset.fromJson(item)).toList();
    } else {
      logger.e('Failed to load Taproot asset data: ${response.statusCode}, ${response}');
      return [];
    }
  } catch (e) {
    logger.e('Error requesting taproot assets: $e');
    return [];
  }
}
