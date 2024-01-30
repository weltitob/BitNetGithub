import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/list_assets.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/models/firebase/cloudfunction_callback.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<ByteData> loadMacaroonAsset() async {
  return await rootBundle.load('assets/keys/lnd_admin.macaroon');
}

Future<CloudfunctionCallback> sendPaymentV2(String invoice_string) async {
  const String restHost = 'mybitnet.com:8443'; // Update the host as needed
  const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
  // Make the GET request
  String url = 'https://$restHost/v2/router/send';
  // Read the macaroon file and convert it to a hexadecimal string
  ByteData byteData = await loadMacaroonAsset();
  // Convert ByteData to List<int>
  List<int> bytes = byteData.buffer.asUint8List();
  // Convert bytes to hex string
  String macaroon = bytesToHex(bytes);

  //String macaroon = bytesToHex(await File(macaroonPath).readAsBytes());
  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };
  final Map<String, dynamic> data = {
    'timeout_seconds': 60,
    'fee_limit_sat': 1000,
    'payment_request': "lnbc10u1pjms27wpp5e9tyddqgj97ks0zz88wqurme2quu7z8tw9lv6p70tr4c8nazehqqdqqcqzzsxqyz5vqsp5h77xfzrxkfh60x6wv5ahyyq7te7es48mrjarkcs45f8txdvfj5yq9qyyssqj8h4mwk73ac00prygv8yf74vwdqmv4r20uucsgk6avnyesvfxgk4h7w6t04dyp8x95scg773z6q0ahhgze5j69ckpngrxhxs3f80engp2538ys" //invoice_string,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    var request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = json.encode(data);

    var streamedResponse = await request.send();
    var completeResponse = StringBuffer();

    await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
      completeResponse.write(chunk);
    }

    // Here we have the complete response
    var jsonResponse = json.decode(completeResponse.toString());
    print(jsonResponse); // The combined JSON response

    // Now create the CloudfunctionCallback from the combined JSON
    return CloudfunctionCallback.fromJson(jsonResponse);
  } catch (e) {
    print('Error: $e');
    return CloudfunctionCallback(statusCode: "error", message: "Error during network call: $e", data: {});
  }

  // try {
  //   var response = await http.post(Uri.parse(url), headers: headers, body: json.encode(data));
  //   // Print raw response for debugging
  //   print('Raw Response: ${response.body}');
  //
  //   if (response.statusCode == 200) {
  //     print(json.decode(response.body));
  //     return CloudfunctionCallback.fromJson(json.decode(response.body));
  //
  //   } else {
  //     print('Failed to load data: ${response.statusCode}, ${response.body}');
  //     return CloudfunctionCallback(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.body}", data: {});
  //   }
  // } catch (e) {
  //   print('Error: $e');
  //   return CloudfunctionCallback(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
  // }
}