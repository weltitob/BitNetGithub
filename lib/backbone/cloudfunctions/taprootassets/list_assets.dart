import 'dart:io';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


listTaprootAssets() async {

  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  String restHost = AppTheme.baseUrlLightningTerminal;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    // 'User-Agent': 'Your custom user agent' // Uncomment if needed
  };

  // Make the GET request
  String url = 'https://$restHost/v1/taproot-assets/assets';
  try {
    print('http ...listTaprootAssets');

    //final DioClient dioClient = Get.find<DioClient>();
    //var response = await dioClient.get(url: url, headers: headers);
    var response = await http.get(Uri.parse(url), headers: headers);


    logger.i("Raw Response: ${response}");

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      print(response);
      //return response;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      print('Failed to load data: ${response.statusCode}, ${response}');
    }
  } catch (e) {
    logger.e('Error requesting taproot assets: $e');
  }
}
