import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:get/get.dart';

//problem with this is that the server will need to be started to use this already


Future<dynamic> generateSeed() async {
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
    print("Making request to URL: $url");
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    headers.forEach((key, value) {
      request.headers.set(key, value);
      print("Header set: $key = $value");
    });

    // Await the response
    HttpClientResponse response = await request.close();
    String responseData = await response.transform(utf8.decoder).join();

    // Process and print response details
    print("Response received. Status code: ${response.statusCode}");
    print("Raw response data: $responseData");

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse = jsonDecode(responseData);
        print("JSON Response parsed successfully: $jsonResponse");
        return jsonResponse; // Return the parsed JSON response
      } catch (e) {
        print("Response is not valid JSON. Returning raw data.");
        return responseData; // Return raw response if JSON parsing fails
      }
    } else {
      print("Request failed with status: ${response.statusCode}");
      print("Response: $responseData");
      return {
        'error': 'Failed to generate seed',
        'statusCode': response.statusCode,
        'response': responseData,
      }; // Return error details
    }
  } catch (e) {
    print("An error occurred: $e");
    return {
      'error': 'Exception occurred',
      'details': e.toString(),
    }; // Return exception details
  }
}
