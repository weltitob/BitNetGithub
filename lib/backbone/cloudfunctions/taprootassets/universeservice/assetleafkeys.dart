import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

getAssetKeys(String assetIdStr) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();

  String restHost = remoteConfigController.baseUrlLightningTerminal.value;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  String url =
  //  kDebugMode
  //     ? ''
  //     :
      
       'https://$restHost/v1/taproot-assets/universe/keys/asset-id/$assetIdStr';

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  // Send GET request
  final response = await http.get(
    Uri.parse(url),
    headers: headers,
  );

  // Decode and print the response
  Map<String, dynamic> responseBody = jsonDecode(response.body);
  logger.i("ASSET LEAF KEYS: ${responseBody}");
}
