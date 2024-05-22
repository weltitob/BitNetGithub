import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:blockchain_utils/hex/hex.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

Future<dynamic> finalizeMint() async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  String restHost = AppTheme.baseUrlLightningTerminal;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  String url = 'https://$restHost/v1/taproot-assets/assets/mint/finalize';


  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  // Prepare the data to be sent in the request
  Map<String, dynamic> data = {
    'short_response': false,
    // 'fee_rate': , // Optional fee rate to use to mint transaction in sat/kw
    // 'full_tree': [], // An ordered list of TapLeafs, which will be used to construct a Tapscript tree
    // 'branch': , // A TapBranch that represents a Tapscript tree managed externally
  };

  try {
    Dio dio = Dio();
    var response = await dio.post(
      url,
      data: json.encode(data),
      options: Options(
        headers: headers,
        contentType: Headers.jsonContentType,
      ),
    );

    logger.i("Raw Response: ${response.data}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;

      // Log the response data
      logger.i("Finalized minting batch response: ${json.encode(responseData, toEncodable: (e) => e.toString())}");

      // Return the response data
      return responseData;
    } else {
      logger.e("Failed to finalize minting batch. Status code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    logger.e("Error finalizing mint batch: $e");
    return null;
  }
}
