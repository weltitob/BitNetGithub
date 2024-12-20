import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<RestResponse> addInvoice(int amount, String? memo) async {

  final logger = Get.find<LoggerService>();
  logger.i("Called addInvoice()"); // The combined JSON response

  // String restHost =
  //     AppTheme.baseUrlLightningTerminal; // Update the host as needed

  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;
  // const String macaroonPath =
  //     'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
  // Make the GET request
  String url = 'https://$restHost/v1/invoices';
  // Read the macaroon file and convert it to a hexadecimal string
  ByteData byteData = await loadAdminMacaroonAsset();
  // Convert ByteData to List<int>
  List<int> bytes = byteData.buffer.asUint8List();
  // Convert bytes to hex string
  String macaroon = base64.encode(bytes);

  logger.i("Macaroon: $macaroon used in addInvoice()");


  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };
  final Map<String, dynamic> data = {
    'memo': memo ?? "",
    'value': amount,
    'expiry': 1200,
    'fallback_addr': 'bc1qtfmrfu3n5vx8jgep5vw2s7z68u0aq40c24e2ps',
    'private': false,
    'is_keysend': true
  };

  HttpOverrides.global = MyHttpOverrides();

  try {

    logger.i("Trying to make request to addInvoice()");
    final DioClient dioClient = Get.find<DioClient>();
    var response = await dioClient.post(url: url, headers: headers, data: data);
    // Print raw response for debugging
    logger.i('Raw Response: ${response.data} from addInvoice()');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully added invoice",
          data: response.data);
    } else {
      print('Failed to load data: ${response.statusCode}, ${response.data}');
      return RestResponse(
          statusCode: "error",
          message:
              "Failed to load data: ${response.statusCode}, ${response.data}",
          data: {});
    }
  } catch (e) {
    print('Error: $e');
    return RestResponse(
        statusCode: "error",
        message:
            "Failed to load data: Could not get response from Lightning node!",
        data: {});
  }
}
