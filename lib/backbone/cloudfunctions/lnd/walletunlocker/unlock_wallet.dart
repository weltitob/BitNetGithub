import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';

Future<void> unlockWallet() async {
  const String restHost = '98.81.97.167:8443';
  const String tlsPath = 'LND_DIR/tls.cert';

  // Encode the password to Base64
  String password = "i__hate..passwords!!";
  String encodedPassword = base64Encode(utf8.encode(password));

  // URL and data payload
  String url = 'https://$restHost/v1/unlockwallet';
  Map<String, dynamic> data = {
    'wallet_password': encodedPassword,
    'recovery_window': 0,
    'stateless_init': true,
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
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status! < 500, // Allow handling 4xx errors
      ),
    );

    // Log the response
    if (response.statusCode == 200) {
      print("Response data: ${response.data}");
    } else {
      print("Failed to unlock wallet: ${response.statusCode}, ${response.data}");
    }
  } catch (e) {
    print("Error in unlocking wallet: $e");
  }
}

// Custom HttpOverrides for self-signed certificates (define MyHttpOverrides class)