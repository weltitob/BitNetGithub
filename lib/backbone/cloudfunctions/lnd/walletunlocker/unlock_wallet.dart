import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:get/get.dart';

Future<dynamic> unlockWallet({String? nodeId}) async {
  // Original litd controller approach (commented out for Caddy MVP)
  // final litdController = Get.find<LitdController>();
  // final String restHost = litdController.litd_baseurl.value;
  // String url = 'https://$restHost/v1/unlockwallet';

  // Use Caddy server routing for MVP - hardcoded to node5 for now
  String caddyBaseUrl = 'https://api.bitnet.ai/';
  String selectedNode = nodeId ?? 'node12'; // Default to node8 for MVP

  // Encode the password to Base64
  String password = "development_password_dj83zb"; //i__hate..passwords!!
  String encodedPassword = base64Encode(utf8.encode(password));

  // URL and data payload via Caddy
  String url = '$caddyBaseUrl/$selectedNode/v1/unlockwallet';
  Map<String, dynamic> data = {
    'wallet_password': encodedPassword,
    'recovery_window': 0,
    'stateless_init': true,
  };

  // Configure HTTP overrides to handle self-signed certificates
  HttpOverrides.global = MyHttpOverrides();

  try {
    // Initialize HttpClient for HTTP requests
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    // Prepare the request
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.contentType = ContentType.json;
    request.add(utf8.encode(jsonEncode(data)));

    // Await the response
    HttpClientResponse response = await request.close();
    String responseData = await response.transform(utf8.decoder).join();

    // Log the response
    if (response.statusCode == 200) {
      print("Response data: $responseData");
    } else {
      print("Failed to unlock wallet: ${response.statusCode}, $responseData");
    }
  } catch (e) {
    print("Error in unlocking wallet: $e");
  }
}
