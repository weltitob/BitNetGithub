import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:http/http.dart' as http;

Future<RestResponse> getLoopOutQuote(String price) async {
  String restHost = AppTheme.baseUrlLightningTerminal;
  String url = 'https://$restHost/v1/loop/out/quote/$price';

  ByteData byteData = await loadLoopMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    var response = await http.get(Uri.parse(url), headers: headers);
    print('Raw Response: ${response.body}');

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully retrieved Loop In Quote",
          data: json.decode(response.body));
    } else {
      print('Failed to load data: ${response.statusCode}, ${response.body}');
      Map<String, dynamic> decodedBody = json.decode(response.body);
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

