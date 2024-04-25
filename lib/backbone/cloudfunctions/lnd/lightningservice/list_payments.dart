import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<RestResponse> listPayments() async {
  String restHost = AppTheme.baseUrlLightningTerminal;
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
  String url = 'https://$restHost/v1/payments';

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  //data still needs to add the include_incomplete parameter

  try {
    var response = await http.get(Uri.parse(url), headers: headers,);
    // Print raw response for debugging
    Logs().d('Raw Response Payments: ${response.body}');

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return RestResponse(statusCode: "${response.statusCode}", message: "Successfully retrieved Lightning Payments", data: json.decode(response.body));

    } else {
      print('Failed to load data: ${response.statusCode}, ${response.body}');
      return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.body}", data: {});
    }
  } catch (e) {
    print('Error: $e');
    return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  }
}