import 'dart:io';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
 
Future<RestResponse> inboundLiquidity() async {
    final logger = Get.find<LoggerService>();
    final DioClient dioClient = Get.find<DioClient>();
    final litdController = Get.find<LitdController>();
    final String restHost = litdController.litd_baseurl.value;
    // const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
    String url = 'https://$restHost/v1/channels';

    final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();

    ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
    List<int> bytes = byteData.buffer.asUint8List();
    String macaroon = bytesToHex(bytes);

    Map<String, String> headers = {
      'Grpc-Metadata-macaroon': macaroon,
    };

    HttpOverrides.global = MyHttpOverrides();

    try {
      var response = await dioClient.get(url: url, headers: headers);

      // Print raw response for debugging
      print('Raw Response Light: ${response.data}');

      if (response.statusCode == 200) {
         final List<dynamic> channels = response.data['channels'];

        double availableInboundLiquidity = 0.0;
        for (var channel in channels) {
          if (channel['active'] == true) {
            availableInboundLiquidity += double.tryParse(channel['remote_balance']) ?? 0;
          }
        }

        return RestResponse(
            statusCode: "${response.statusCode}",
            message: "Successfully retrived Lightning Balance",
            data: {'liquidity': availableInboundLiquidity});
      } else {
        print('Failed to load data: ${response.statusCode}, ${response.data}');
        return RestResponse(
            statusCode: "error",
            message:
                "Failed to load data: ${response.statusCode}, ${response.data}",
            data: {});
      }
    } catch (e) {
      print('Error: $e');
      return RestResponse(
          statusCode: "error",
          message:
              "Failed to load data: Could not get response from Lightning node!",
          data: {});
    }
}
