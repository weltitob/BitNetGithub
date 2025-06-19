import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/api/rest_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// Sends Bitcoin onchain using the user's Lightning node
/// This replaces the old complex transaction building with direct LND API call
Future<RestResponse> sendCoins({
  required String userId,
  required String address,
  required int amountSat,
  required int targetConf,
  int? satPerVbyte,
  bool sendAll = false,
}) async {
  final logger = Get.find<LoggerService>();
  logger.i("sendCoins: Sending $amountSat sats to $address for user $userId");

  try {
    // Get user's node mapping
    final nodeMappingService = Get.find<NodeMappingService>();
    final nodeMapping = await nodeMappingService.getUserNodeMapping(userId);
    
    if (nodeMapping == null) {
      logger.e("No node mapping found for user: $userId");
      return RestResponse(
        statusCode: "error",
        message: "No Lightning node assigned to user",
        data: {},
      );
    }
    
    final nodeId = nodeMapping.nodeId;
    logger.i("Using node: $nodeId for onchain send");
    
    // Load user's admin macaroon
    final macaroon = await loadMacaroonAsset(nodeId);
    if (macaroon.isEmpty) {
      logger.e("Failed to load macaroon for node: $nodeId");
      return RestResponse(
        statusCode: "error",
        message: "Failed to load node credentials",
        data: {},
      );
    }
    
    // Get Caddy URL for the user's node
    final litdController = Get.find<LitdController>();
    final baseUrl = litdController.litd_baseurl.value;
    final url = 'https://$baseUrl/$nodeId/v1/transactions';
    
    logger.i("Sending coins via: $url");
    
    // Prepare request data
    final Map<String, dynamic> data = {
      'addr': address,
      'amount': amountSat.toString(),
      'target_conf': targetConf,
      'send_all': sendAll,
    };
    
    // Add fee rate if specified
    if (satPerVbyte != null) {
      data['sat_per_vbyte'] = satPerVbyte.toString();
    }
    
    // Set up headers
    final headers = {
      'Grpc-Metadata-macaroon': macaroon,
      'Content-Type': 'application/json',
    };
    
    // Set up HTTP override for SSL
    HttpOverrides.global = MyHttpOverrides();
    
    // Make the request
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    
    logger.i("Response status: ${response.statusCode}");
    logger.i("Response body: ${response.body}");
    
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      
      return RestResponse(
        statusCode: "success",
        message: "Transaction sent successfully",
        data: {
          'txid': decoded['txid'] ?? '',
          'amount': amountSat,
          'address': address,
          'fee': decoded['total_fees'] ?? 0,
          ...decoded,
        },
      );
    } else {
      final error = jsonDecode(response.body);
      logger.e("Failed to send coins: ${error['message'] ?? error['error'] ?? 'Unknown error'}");
      
      return RestResponse(
        statusCode: "error",
        message: error['message'] ?? error['error'] ?? 'Failed to send transaction',
        data: error,
      );
    }
  } catch (e) {
    logger.e("Error sending coins: $e");
    return RestResponse(
      statusCode: "error",
      message: "Error sending coins: $e",
      data: {},
    );
  }
}

/// Estimates fee for an onchain transaction
Future<RestResponse> estimateFee({
  required String userId,
  required String address,
  required int amountSat,
  required int targetConf,
}) async {
  final logger = Get.find<LoggerService>();
  logger.i("estimateFee: Estimating fee for $amountSat sats to $address");

  try {
    // Get user's node mapping
    final nodeMappingService = Get.find<NodeMappingService>();
    final nodeMapping = await nodeMappingService.getUserNodeMapping(userId);
    
    if (nodeMapping == null) {
      logger.e("No node mapping found for user: $userId");
      return RestResponse(
        statusCode: "error",
        message: "No Lightning node assigned to user",
        data: {},
      );
    }
    
    final nodeId = nodeMapping.nodeId;
    
    // Load user's admin macaroon
    final macaroon = await loadMacaroonAsset(nodeId);
    if (macaroon.isEmpty) {
      logger.e("Failed to load macaroon for node: $nodeId");
      return RestResponse(
        statusCode: "error",
        message: "Failed to load node credentials",
        data: {},
      );
    }
    
    // Get Caddy URL for the user's node
    final litdController = Get.find<LitdController>();
    final baseUrl = litdController.litd_baseurl.value;
    final url = 'https://$baseUrl/$nodeId/v2/wallet/estimatefee';
    
    // Prepare request data
    final Map<String, dynamic> data = {
      'addr_to_amount': {
        address: amountSat,
      },
      'target_conf': targetConf,
    };
    
    // Set up headers
    final headers = {
      'Grpc-Metadata-macaroon': macaroon,
      'Content-Type': 'application/json',
    };
    
    // Set up HTTP override for SSL
    HttpOverrides.global = MyHttpOverrides();
    
    // Make the request
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      
      return RestResponse(
        statusCode: "success",
        message: "Fee estimated successfully",
        data: {
          'fee_sat': decoded['fee_sat'] ?? 0,
          'feerate_sat_per_vbyte': decoded['feerate_sat_per_vbyte'] ?? 0,
          ...decoded,
        },
      );
    } else {
      final error = jsonDecode(response.body);
      logger.e("Failed to estimate fee: ${error['message'] ?? 'Unknown error'}");
      
      return RestResponse(
        statusCode: "error",
        message: error['message'] ?? 'Failed to estimate fee',
        data: error,
      );
    }
  } catch (e) {
    logger.e("Error estimating fee: $e");
    return RestResponse(
      statusCode: "error",
      message: "Error estimating fee: $e",
      data: {},
    );
  }
}