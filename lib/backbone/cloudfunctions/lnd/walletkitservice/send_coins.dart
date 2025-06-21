import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
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
    // Get user's node mapping - userId is the recovery DID
    final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);
    
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
    
    // Get the admin macaroon from node mapping (stored as base64)
    final macaroonBase64 = nodeMapping.adminMacaroon;
    if (macaroonBase64.isEmpty) {
      logger.e("No macaroon found in node mapping for node: $nodeId");
      return RestResponse(
        statusCode: "error",
        message: "Failed to load node credentials",
        data: {},
      );
    }
    
    // Convert base64 macaroon to hex format
    final macaroonBytes = base64Decode(macaroonBase64);
    final macaroon = bytesToHex(macaroonBytes);
    
    // Get Caddy URL for the user's node using LightningConfig
    final url = '${LightningConfig.caddyBaseUrl}/$nodeId/v1/transactions';
    
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
    // Get user's node mapping - userId is the recovery DID
    final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);
    
    if (nodeMapping == null) {
      logger.e("No node mapping found for user: $userId");
      return RestResponse(
        statusCode: "error",
        message: "No Lightning node assigned to user",
        data: {},
      );
    }
    
    final nodeId = nodeMapping.nodeId;
    logger.i("Using node: $nodeId for fee estimation");
    
    // Get the admin macaroon from node mapping (stored as base64)
    final macaroonBase64 = nodeMapping.adminMacaroon;
    if (macaroonBase64.isEmpty) {
      logger.e("No macaroon found in node mapping for node: $nodeId");
      return RestResponse(
        statusCode: "error",
        message: "Failed to load node credentials",
        data: {},
      );
    }
    
    // Convert base64 macaroon to hex format
    final macaroonBytes = base64Decode(macaroonBase64);
    final macaroon = bytesToHex(macaroonBytes);
    logger.i("🔑 Using user-specific macaroon for ${nodeId}: ${macaroon.substring(0, 20)}... (truncated)");
    
    // Get Caddy URL for the user's node using LightningConfig  
    // Use the same format as the old working version: GET with path parameter
    final url = '${LightningConfig.caddyBaseUrl}/$nodeId/v2/wallet/estimatefee/$targetConf';
    logger.i("Fee estimation URL: $url");
    
    // Set up headers (same as old version)
    final headers = {
      'Grpc-Metadata-macaroon': macaroon,
    };
    
    logger.i("Fee estimation headers: ${headers.keys.toList()}");
    
    // Set up HTTP override for SSL
    HttpOverrides.global = MyHttpOverrides();
    
    logger.i("Making GET request for fee estimation (like old version)...");
    
    // Make the request using GET (like old version)
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    
    logger.i("Fee estimation response status: ${response.statusCode}");
    logger.i("Fee estimation response body: ${response.body}");
    logger.i("Fee estimation response headers: ${response.headers}");
    
    if (response.statusCode == 200) {
      try {
        final decoded = jsonDecode(response.body);
        logger.i("Successfully decoded fee estimation response: $decoded");
        
        // Convert sat_per_kw to sat_per_vbyte
        // 1 kw (kilo-weight) = 4 vbytes, so sat_per_kw / 4 = sat_per_vbyte
        int satPerKw = int.tryParse(decoded['sat_per_kw']?.toString() ?? '0') ?? 0;
        double satPerVbyte = satPerKw / 4.0;
        
        // Don't calculate total fee here - just return the fee rate
        // The controller will calculate the actual fee based on transaction size
        
        logger.i("Converted fee rate: $satPerKw sat/kw → $satPerVbyte sat/vbyte");
        
        return RestResponse(
          statusCode: "success",
          message: "Fee estimated successfully",
          data: {
            'feerate_sat_per_vbyte': satPerVbyte.ceil(), // Return as int
            'sat_per_kw': satPerKw,
            'min_relay_fee_sat_per_kw': decoded['min_relay_fee_sat_per_kw'],
            ...decoded,
          },
        );
      } catch (e) {
        logger.e("Failed to parse fee estimation response: $e");
        return RestResponse(
          statusCode: "error",
          message: "Failed to parse fee response: $e",
          data: {'raw_response': response.body},
        );
      }
    } else {
      logger.e("Fee estimation failed with status ${response.statusCode}");
      logger.e("Error response body: ${response.body}");
      
      try {
        final error = jsonDecode(response.body);
        logger.e("Parsed error: ${error['message'] ?? error['error'] ?? 'Unknown error'}");
        
        return RestResponse(
          statusCode: "error",
          message: error['message'] ?? error['error'] ?? 'Failed to estimate fee',
          data: error,
        );
      } catch (e) {
        logger.e("Failed to parse error response: $e");
        return RestResponse(
          statusCode: "error",
          message: "Failed to estimate fee: HTTP ${response.statusCode}",
          data: {'raw_response': response.body, 'status_code': response.statusCode},
        );
      }
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