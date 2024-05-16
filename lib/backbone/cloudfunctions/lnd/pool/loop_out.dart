import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

Future<RestResponse> loopOut(Map<String, dynamic> data) async {
  String restHost = AppTheme.baseUrlLightningTerminal;
  String url = 'https://$restHost/v1/loop/out';

  ByteData byteData = await loadLoopMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  // int amount = int.parse(data['amt']);
  // int maxswapFree = int.parse(data['swapFee']);
  // int maxMinerfee = int.parse(data['minerFee']);
  // int maxPrepay = int.parse(data['maxPrepay']);

  data = {
    'amt': data['amt'],
    'max_swap_fee': data['swapFee'],
    'max_miner_fee': data['minerFee'],
    'dest': data['dest'],
    'max_prepay_amt': data['maxPrepay'],
  };

  try {
      final DioClient dioClient = Get.find<DioClient>();

    var response =
        await dioClient.post(url:url, headers: headers, data: data);
    print('Raw Response: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully retrieved Loop out",
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
//     "swap_fee_sat": <int64>,
//     "prepay_amt_sat": <int64>,
//     "htlc_sweep_fee_sat": <int64>,
//     "swap_payment_dest": <bytes>,
//     "cltv_delta": <int32>,
//     "conf_target": <int32>,
// }

