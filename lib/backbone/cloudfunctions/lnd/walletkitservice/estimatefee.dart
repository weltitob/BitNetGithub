import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';

Future<RestResponse> estimateFee(String conf_target) async {
  String restHost = AppTheme.baseUrlLightningTerminal;
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
  String url = 'https://$restHost/v2/wallet/estimatefee/$conf_target';

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    var response = await http.get(Uri.parse(url), headers: headers,);
    Logs().w('Raw Response estimate fee: ${response.body}');

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return RestResponse(statusCode: "${response.statusCode}", message: "Successfully got fee estimate", data: json.decode(response.body));

    } else {
      Logs().e('Failed to load data: ${response.statusCode}, ${response.body}');
      return RestResponse(statusCode: "error", message: "Failed to load fee estimate: ${response.statusCode}, ${response.body}", data: {});
    }
  } catch (e) {
    Logs().e('Error trying to publish transaction: $e');
    return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  }
}