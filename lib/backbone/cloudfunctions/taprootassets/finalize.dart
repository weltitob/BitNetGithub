import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<dynamic> finalizeMint() async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  String restHost = AppTheme.baseUrlLightningTerminal;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  String url =
  //  kDebugMode
  //     ? ''
  //     : 
      'https://$restHost/v1/taproot-assets/assets/mint/finalize';

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  // Prepare the data to be sent in the request
  Map<String, dynamic> data = {
    'short_response': false,
    // 'fee_rate': , // Optional fee rate to use to mint transaction in sat/kw
    // 'full_tree': [], // An ordered list of TapLeafs, which will be used to construct a Tapscript tree
    // 'branch': , // A TapBranch that represents a Tapscript tree managed externally
  };

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(data),
    );

    logger.i("Raw Response: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      // Log the response data
      logger.i(
          "Finalized minting batch response: ${json.encode(responseData, toEncodable: (e) => e.toString())}");

      // Return the response data
      return responseData;
    } else {
      logger.e(
          "Failed to finalize minting batch. Status code: ${response.statusCode}, ${response.body}");
      return null;
    }
  } catch (e) {
    logger.e("Error finalizing mint batch: $e");
    return null;
  }
}
