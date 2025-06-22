import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

Future<RestResponse> getLoopOutQuote(String userId, String price) async {
  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();
  final logger = Get.find<LoggerService>();
  
  // Get user's node mapping
  final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);
  if (nodeMapping == null) {
    logger.e("No node mapping found for user: $userId");
    return RestResponse(
      statusCode: "error",
      message: "No Lightning node assigned to user",
      data: {}
    );
  }

  final nodeId = nodeMapping.nodeId;
  logger.i("Using node: $nodeId for user: $userId");

  // Get the admin macaroon from node mapping (stored as base64)
  final macaroonBase64 = nodeMapping.adminMacaroon;
  if (macaroonBase64.isEmpty) {
    logger.e("No macaroon found in node mapping for node: $nodeId");
    return RestResponse(
      statusCode: "error",
      message: "Failed to load node credentials",
      data: {}
    );
  }
  
  // Convert base64 macaroon to hex format
  final macaroonBytes = base64Decode(macaroonBase64);
  final macaroon = bytesToHex(macaroonBytes);
  
  // Build URL using Caddy endpoint
  String url = '${LightningConfig.caddyBaseUrl}/$nodeId/v1/loop/out/quote/$price';
  logger.i("Loop Out Quote URL: $url");

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
      final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.get(url: url, headers: headers);
    print('Raw Response: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully retrieved Loop In Quote",
          data: response.data);
    } else {
      print('Failed to load data: ${response.statusCode}, ${response.data}');
      Map<String, dynamic> decodedBody = json.decode(response.data);
      return RestResponse(
          statusCode: "error", message: decodedBody['message'], data: {});
    }
  } catch (e) {
    print('Error: $e');
    return RestResponse(
        statusCode: "error",
        message: "Failed to load data: Could not get response from server!",
        data: {});
  }
}



//  {
//     "swap_fee_sat": <int64>,
//     "prepay_amt_sat": <int64>,
//     "htlc_sweep_fee_sat": <int64>,
//     "swap_payment_dest": <bytes>,
//     "cltv_delta": <int32>,
//     "conf_target": <int32>,
// }

