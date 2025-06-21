import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bitnet/backbone/helper/http_no_ssl.dart'; // Includes bytesToHex
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';
 
// NEW: One user one node approach - Get channel balance from user's node
Future<RestResponse> channelBalance() async {
  HttpOverrides.global = MyHttpOverrides();
  
  final logger = Get.find<LoggerService>();
  logger.i("NEW channelBalance: Getting balance from user's individual node");
  
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

    // Get the admin macaroon from node mapping (stored as base64)
    final macaroonBase64 = nodeMapping.adminMacaroon;
    if (macaroonBase64.isEmpty) {
      logger.e("No macaroon found in node mapping for node: $nodeId");
      return RestResponse(
        statusCode: "error",
        message: "Failed to load node credentials",
        data: {}
      );
    }
    
    // Convert base64 macaroon to hex format
    final macaroonBytes = base64Decode(macaroonBase64);
    final macaroon = bytesToHex(macaroonBytes);

    // Build URL using Caddy endpoint
    final url = '${LightningConfig.caddyBaseUrl}/$nodeId/v1/balance/channels';
    
    logger.i("Getting channel balance from: $url");

    // Prepare headers
    final Map<String, String> headers = {
      'Grpc-Metadata-macaroon': macaroon,
    };

    // Make request to user's node
    try {
      logger.i("Making GET request to user's node");
      
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      // Check the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        logger.i("Successfully retrieved channel balance from node $nodeId");
        logger.d("Channel balance data: ${responseData}");
        
        return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully retrieved Lightning Balance",
          data: responseData
        );
      } else {
        logger.e("Failed to get channel balance. Status: ${response.statusCode}, Body: ${response.body}");
        return RestResponse(
          statusCode: "error",
          message: "Failed to load data: ${response.statusCode}",
          data: response.body.isNotEmpty ? jsonDecode(response.body) : {}
        );
      }
    } catch (e, stackTrace) {
      logger.e("Error getting channel balance from node $nodeId: $e\nStackTrace: $stackTrace");
      return RestResponse(
        statusCode: "error",
        message: "Failed to get channel balance: $e",
        data: {}
      );
    }
  } catch (e) {
    logger.e("Fatal error in channelBalance: $e");
    return RestResponse(
      statusCode: "error",
      message: "Fatal error: $e",
      data: {}
    );
  }
}
