import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<RestResponse> listUnspent() async {
  LoggerService logger = Get.find();
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;
  // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
  String url = 'https://$restHost/v2/wallet/utxos';

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };
  final Map<String, dynamic> data = {
    'min_confs': 4,
    'max_confs': 999999,
    'account': "default",
    'unconfirmed_only': false, //false or true decides if only unconfirmed utxos are returned
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.post(url: url, headers: headers, data: json.encode(data));
    logger.i('Raw Response Publish Transaction: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(statusCode: "${response.statusCode}", message: "Successfully added invoice", data: response.data);
    } else {
      logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
      return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.data}", data: {});
    }
  } catch (e) {
    logger.e('Error trying to publish transaction: $e');
    return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  }
}
