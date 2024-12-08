import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

Future<dynamic> generateSeed() async {

  // final litdController = Get.find<LitdController>();
  // final String restHost = litdController.litd_baseurl.value;

  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;
  String url = 'https://$restHost/v1/genseed?aezeed_passphrase=Test';

  // Example headers
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // Configure HTTP overrides to handle self-signed certificates
  HttpOverrides.global = MyHttpOverrides();

  try {
    // Initialize HttpClient for HTTP requests
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    // Prepare the request
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    headers.forEach((key, value) {
      request.headers.set(key, value);
    });

    // Await the response
    HttpClientResponse response = await request.close();
    String responseData = await response.transform(utf8.decoder).join();

    // Attempt to parse JSON response if available
    if (response.statusCode == 200) {
      print("Status code: ${response.statusCode}");
      print("Response data: $responseData");

      try {
        Map<String, dynamic> jsonResponse = jsonDecode(responseData);
        print("JSON Response: $jsonResponse");
      } catch (e) {
        print("Response is not valid JSON: $responseData");
      }
    } else {
      print("Failed to get seed: ${response.statusCode}, $responseData");
    }
  } catch (e) {
    print("Error in generating seed: $e");
  }
}
