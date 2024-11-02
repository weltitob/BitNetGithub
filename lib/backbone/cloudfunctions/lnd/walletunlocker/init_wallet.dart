import 'dart:io';
import 'dart:convert';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

Future<RestResponse> initWallet(String restHostIP) async {
  LoggerService logger = Get.find();
  final DioClient dioClient = Get.find<DioClient>();
  String restHost = '$restHostIP:8443';
  String url = 'https://$restHost/v1/initwallet';

  List<String> mnemonicSeed = [
    'about', 'double', 'estate', 'saddle', 'floor', 'where', 'nut', 'soon',
    'beach', 'address', 'describe', 'maple', 'child', 'razor', 'claim', 'mountain',
    'kitten', 'struggle', 'boost', 'useful', 'prevent', 'baby', 'more', 'rescue'
  ];

  Map<String, dynamic> data = {
    'wallet_password': base64Encode(utf8.encode('development_password_dj83zb')),
    'cipher_seed_mnemonic': mnemonicSeed,
    'recovery_window': 0,
    'channel_backups': null,
    'stateless_init': false,
  };

  // Configure HTTP overrides to handle self-signed certificates
  HttpOverrides.global = MyHttpOverrides();

  try {
    // Perform the HTTP POST request using DioClient
    var response = await dioClient.post(
      url: url,
      headers: {'Content-Type': 'application/json'},
      data: data,
    );

    // Log the raw response
    logger.i('Raw Response Init Wallet: ${response.data}');

    // Check if the response was successful
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      String adminMacaroon = responseData['admin_macaroon'] ?? 'Admin macaroon not found';
      logger.i("Admin Macaroon: $adminMacaroon");

      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Wallet initialized successfully",
          data: responseData);
    } else {
      logger.e('Failed to initialize wallet: ${response.statusCode}, ${response.data}');
      return RestResponse(
          statusCode: "error",
          message: "Failed to initialize wallet: ${response.statusCode}, ${response.data}",
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
