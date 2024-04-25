import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<RestResponse> listUnspent() async {
  String restHost = AppTheme.baseUrlLightningTerminal;
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
  String url = 'https://$restHost/v2/wallet/utxos';

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };
  final Map<String, dynamic> data = {
    'min_confs': 0,
    'max_confs': 0,
    'account': "default",
    'unconfirmed_only': false, //false or true decides if only unconfirmed utxos are returned
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    var response = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));
    Logs().w('Raw Response Publish Transaction: ${response.body}');

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return RestResponse(statusCode: "${response.statusCode}", message: "Successfully added invoice", data: json.decode(response.body));

    } else {
      Logs().e('Failed to load data: ${response.statusCode}, ${response.body}');
      return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.body}", data: {});
    }
  } catch (e) {
    Logs().e('Error trying to publish transaction: $e');
    return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  }
}