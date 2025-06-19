import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart'; // Includes bytesToHex
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/models/firebase/restresponse.dart';


List<int> generatePreimage() {
  final random = Random.secure();
  return List<int>.generate(32, (_) => random.nextInt(256));
}


List<int> computeHash(List<int> preimage) {
  return sha256.convert(preimage).bytes;
}


// NEW: One user one node approach - Create Lightning invoice on user's node
Future<RestResponse> addInvoice(int amount, String? memo, String fallbackAddress, dynamic preimage) async {
  HttpOverrides.global = MyHttpOverrides();

  final logger = Get.find<LoggerService>();
  logger.i("NEW addInvoice: Creating invoice on user's individual node");
  logger.i("Amount: $amount sats, fallback address: $fallbackAddress");

  try {
    // Get current user's ID
    final userId = Auth().currentUser?.uid;
    if (userId == null) {
      logger.e("No user logged in");
      return RestResponse(
          statusCode: "error",
          message: "No user logged in",
          data: {}
      );
    }

    // Get user's node mapping
    final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);
    if (nodeMapping == null) {
      logger.e("No node mapping found for user: $userId");
      return RestResponse(
          statusCode: "error",
          message: "No Lightning node assigned to user",
          data: {}
      );
    }

    final nodeId = nodeMapping.nodeId;
    logger.i("Using node: $nodeId for user: $userId");

    // Get the admin macaroon from node mapping
    final macaroon = nodeMapping.adminMacaroon;
    if (macaroon.isEmpty) {
      logger.e("No macaroon found in node mapping for node: $nodeId");
      return RestResponse(
          statusCode: "error",
          message: "Failed to load node credentials",
          data: {}
      );
    }

    // Get Caddy URL for the user's node
    final litdController = Get.find<LitdController>();
    final baseUrl = litdController.litd_baseurl.value;
    final url = 'https://$baseUrl/$nodeId/v1/invoices';
    
    logger.i("Creating invoice at: $url");

    // Prepare headers
    final Map<String, String> headers = {
      'Grpc-Metadata-macaroon': macaroon,
      'Content-Type': 'application/json',
    };

  final hash = computeHash(preimage);

  logger.i("Generated preimage: ${base64Encode(preimage)}");

  final Map<String, dynamic> data = {
    'r_hash': base64Encode(hash),
    'r_preimage': base64Encode(preimage),
    'memo': memo ?? "",
    'value': amount,
    'expiry': 1200,
    'fallback_addr': fallbackAddress,
    'private': false,
    'is_keysend': true,
  };

    // Post invoice request to user's node
    try {
      logger.i("Making POST request to user's node");
      logger.d("Headers: ${headers.keys}, Data: ${data.keys}");
      
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      // Check the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        logger.i("Successfully created invoice on node $nodeId");
        logger.d("Invoice: ${responseData['payment_request']?.substring(0, 50)}...");
        
        return RestResponse(
            statusCode: "${response.statusCode}",
            message: "Successfully added invoice",
            data: responseData
        );
      } else {
        logger.e("Failed to add invoice. Status: ${response.statusCode}, Body: ${response.body}");
        return RestResponse(
            statusCode: "error",
            message: "Failed to add invoice: ${response.statusCode}",
            data: response.body.isNotEmpty ? jsonDecode(response.body) : {}
        );
      }
    } catch (e, stackTrace) {
      logger.e("Error creating invoice on node $nodeId: $e\nStackTrace: $stackTrace");
      return RestResponse(
          statusCode: "error",
          message: "Failed to add invoice due to an error: $e",
          data: {}
      );
    }
  } catch (e) {
    logger.e("Fatal error in addInvoice: $e");
    return RestResponse(
        statusCode: "error",
        message: "Fatal error: $e",
        data: {}
    );
  }
}
