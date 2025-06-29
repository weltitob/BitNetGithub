import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

universeFederation(Map<String, dynamic> universeFederationServer) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  final RemoteConfigController remoteConfigController =
      Get.find<RemoteConfigController>();

  String restHost =
      remoteConfigController.baseUrlLightningTerminalWithPort.value;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  String url =
      //  kDebugMode
      //     ? ''
      //     :
      'https://$restHost/v1/taproot-assets/universe/federation';

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  Map<String, dynamic> data = {
    'servers': universeFederationServer,
  };

  // Send POST request
  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(data),
  );

  // Print the response
  logger.i("RESPONSE ADD FEDERATION: ${jsonDecode(response.body)}");
}
