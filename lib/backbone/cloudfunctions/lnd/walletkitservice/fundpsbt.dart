// import 'package:flutter/material.dart';
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:bitnet/backbone/helper/http_no_ssl.dart';
// import 'package:bitnet/backbone/helper/loadmacaroon.dart';
// import 'package:bitnet/models/firebase/restresponse.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:matrix/matrix.dart';
//
// Future<RestResponse> fundPsbt(FundPsbtRawModel model, double sat_per_kw, String label) async {
//   const String restHost = 'mybitnet.com:8443';
//   const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
//   String url = 'https://$restHost/v2/wallet/utxos';
//
//   ByteData byteData = await loadMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);
//
//   raw ={
//     'inputs': inputs,
//   'outputs': outputs
//   },
//
//   inputs = [
//     {
//       "txid_str": "1d545dab6ebf19136a43cc2562ef22eb43bc6ef0a7052ae21aedf0a2c5934e51",
//       "txid_bytes": "UU6TxaLw7RriKgWn8G68Q+si72IlzENqExm/bqtdVB0=",
//       "output_index": 0,
//     },
//   ]
//
//   outputs = {
//     "key": "bc1qxyz",  # bitcoin address to receive the funds
//     "value": 10000  # value is this the amount of satoshis???
//   }
//
//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };
//   final Map<String, dynamic> data = {
//   //'psbt': base64.b64encode(<bytes>), This stands for Partially Signed Bitcoin Transaction. It's a base64-encoded string representing a transaction that has not been fully signed yet. To generate a PSBT, you would typically use a Bitcoin wallet or library that supports PSBT creation. The library or tool you choose would allow you to specify transaction details such as inputs, outputs, amounts, and more. After creating a PSBT, you would encode it in base64 format to use in this field.
//   'raw': raw,
//   'target_conf': 4, //The number of blocks to aim for when confirming the transaction. If the transaction cannot be confirmed in the specified number of blocks, it will be rejected. If this field is not set, the wallet will use the default number of blocks specified in the server configuration.
//   'sat_per_vbyte': sat_per_kw,//sat_per_vbyte, #feerate in sat/vbyte >> will get this from feerate servcie
//   'account': "", //#The name of the account to fund the PSBT with. If empty, the default wallet account is used.
//   'min_confs': 4, //#going for safety and not speed because for speed oyu would use the lightning network
//   'spend_unconfirmed': //False, #Whether unconfirmed outputs should be used as inputs for the transaction.
//   'change_type': 0, //#CHANGE_ADDRESS_TYPE_UNSPECIFIED
//   };
//
//   HttpOverrides.global = MyHttpOverrides();
//
//   try {
//     var response = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));
//     Logs().w('Raw Response Publish Transaction: ${response.body}');
//
//     if (response.statusCode == 200) {
//       print(json.decode(response.body));
//       return RestResponse(statusCode: "${response.statusCode}", message: "Successfully added invoice", data: json.decode(response.body));
//
//     } else {
//       Logs().e('Failed to load data: ${response.statusCode}, ${response.body}');
//       return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.body}", data: {});
//     }
//   } catch (e) {
//     Logs().e('Error trying to publish transaction: $e');
//     return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
//   }
// }