import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';

Future<void> generateSeed() async {
  const String restHost = '3.88.166.128:8443';
  String url = 'https://$restHost/v1/genseed?aezeed_passphrase=Test';

  // Example mnemonic seed and seed entropy
  String mnemonicSeed = "abandon ability able about above absent absorb abstract absurd abuse access accident account accuse achieve acid acoustic acquire across act action actor actress actual";
  String seedEntropy = ""; // Can be generated using a secure method if needed

  // Data payload (currently commented out fields as in the original Python code)
  Map<String, dynamic> data = {
    //'aezeed_passphrase': base64Encode(utf8.encode(mnemonicSeed)),
    //'seed_entropy': base64Encode(utf8.encode(seedEntropy)),
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

    // Send GET request with query parameters and headers
    Response response = await dio.get(
      url,
      options: Options(
        headers: headers,
        validateStatus: (status) => status! < 500, // Allow handling 4xx errors
      ),
    );

    // Attempt to parse JSON response if available
    if (response.statusCode == 200) {
      print("Status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      try {
        Map<String, dynamic> jsonResponse = response.data;
        print("JSON Response: $jsonResponse");
      } catch (e) {
        print("Response is not valid JSON: ${response.data}");
      }
    } else {
      print("Failed to get seed: ${response.statusCode}, ${response.data}");
    }
  } catch (e) {
    print("Error in generating seed: $e");
  }
}