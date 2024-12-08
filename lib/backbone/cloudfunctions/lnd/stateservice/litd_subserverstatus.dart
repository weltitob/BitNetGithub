import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Modify the request function to return the SubServersStatus model directly
Future<SubServersStatus?> fetchSubServerStatus() async {
  final logger = Get.find<LoggerService>();
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;

  String url = 'https://$restHost/v1/status';

  // Load the macaroon from assets
  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    final DioClient dioClient = Get.find<DioClient>();
    var response = await dioClient.get(url: url, headers: headers);

    logger.i('Raw Response: ${response.data}');

    if (response.statusCode == 200) {
      logger.i(response.data);
      return SubServersStatus.fromJson(response.data);
    } else {
      logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
      return null;
    }
  } catch (e) {
    logger.e('Error: $e');
    return null;
  }
}

