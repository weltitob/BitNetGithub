import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:blockchain_utils/hex/hex.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

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
  };

  String url = 'https://$restHost/v1/taproot-assets/assets/mint/cancel';

  try {
    Dio dio = Dio();
    var response = await dio.post(
      url,
      data: json.encode({}),
      options: Options(
        headers: headers,
        contentType: Headers.jsonContentType,
      ),
    );

    logger.i("Raw Response: ${response.data}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      // Process responseData if needed
      return responseData;
    } else {
      logger.e('Failed to cancel minting: ${response.statusCode}, ${response.data}');
    }
  } catch (e) {
    logger.e('Error requesting cancel minting: $e');
  }
}
