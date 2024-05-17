import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

Future<RestResponse> getLoopinQuote(String price) async {
  String restHost = AppTheme.baseUrlLightningTerminal;
  String url = 'https://$restHost/v1/loop/in/quote/$price';

  ByteData byteData = await loadLoopMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

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
      Map<String, dynamic> decodedBody = response.data;
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
//     "id": <string>,
//     "id_bytes": <bytes>,
//     "htlc_address": <string>,
//     "htlc_address_p2wsh": <string>,
//     "htlc_address_p2tr": <string>,
//     "server_message": <string>,
//  }

