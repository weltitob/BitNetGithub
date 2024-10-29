import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';

Future<void> initWallet() async {
  const String restHost = '98.81.97.167:8443';
  const String url = 'https://$restHost/v1/initwallet';

  // Example 24-word mnemonic seed (sample values)
  List<String> mnemonicSeed = [
    'about', 'double', 'estate', 'saddle', 'floor', 'where', 'nut', 'soon',
    'beach', 'address', 'describe', 'maple', 'child', 'razor', 'claim', 'mountain',
    'kitten', 'struggle', 'boost', 'useful', 'prevent', 'baby', 'more', 'rescue'
  ];

  // Preparing data payload
  Map<String, dynamic> data = {
    'wallet_password': base64Encode(utf8.encode('development_password_dj83zb')),
    'cipher_seed_mnemonic': mnemonicSeed,
    'recovery_window': 0,
    'channel_backups': null,
    'stateless_init': false,
  };

  // Headers
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // Configure HTTP overrides to handle self-signed certificates
  HttpOverrides.global = MyHttpOverrides();

  try {
    // Initialize Dio for HTTP requests
    Dio dio = Dio();

    // Send POST request
    Response response = await dio.post(
      url,
      data: jsonEncode(data),
      options: Options(
        headers: headers,
        validateStatus: (status) => status! < 500, // Allow handling 4xx errors
      ),
    );

    // Log the response
    print("Status code: ${response.statusCode}");
    print("Response text: ${response.data}");

    // Parse JSON response if successful
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      if (responseData.containsKey('admin_macaroon')) {
        String adminMacaroon = responseData['admin_macaroon'];
        print("Admin Macaroon: $adminMacaroon");
      } else {
        print("Admin macaroon not found in response.");
      }
    } else {
      print("Failed to initialize wallet: ${response.statusCode}, ${response.data}");
    }
  } catch (e) {
    print("Error in initializing wallet: $e");
  }
}