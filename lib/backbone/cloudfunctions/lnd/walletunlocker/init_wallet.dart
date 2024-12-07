import 'dart:io';
import 'dart:convert';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<RestResponse> initWallet(List<String> mnemonicSeed, macaroonRootKey) async {
  LoggerService logger = Get.find();
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;
  String url = 'https://$restHost/v1/initwallet';

  logger.i("Macaroon Root Key: $macaroonRootKey");

  String macaroonRootKeyBase64 = base64Encode(macaroonRootKey);

  logger.i("Macaroon Root Key Base64: $macaroonRootKeyBase64");

  Map<String, dynamic> data = {
    'wallet_password': base64Encode(utf8.encode('development_password_dj83zb')),
    'cipher_seed_mnemonic': mnemonicSeed, //this is a list of strings here
    'recovery_window': 0,
    'channel_backups': null,
    'stateless_init': false,
    'macaroon_root_key': macaroonRootKeyBase64,
  };

  dynamic byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  // Configure HTTP overrides to handle self-signed certificates
  HttpOverrides.global = MyHttpOverrides();

  try {
    // Create an HttpClient instance

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(data),
    );

    // Log the raw response
    logger.i('Raw Response Init Wallet: $response');

    // Check if the response was successful
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String adminMacaroon = responseData['admin_macaroon'] ?? 'Admin macaroon not found';
      logger.i("Admin Macaroon: $adminMacaroon");

      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Wallet initialized successfully",
          data: responseData);
    } else {
      logger.e('Failed to initialize wallet: ${response.statusCode}, ${response.body}');
      return RestResponse(
          statusCode: "error",
          message: "Failed to initialize wallet: ${response.statusCode}, ${response.body}",
          data: {});
    }
  } catch (e) {
    logger.e('Error in initializing wallet: $e');
    return RestResponse(
        statusCode: "error",
        message: "Failed to initialize wallet: Could not get response from server!",
        data: {});
  }
}