import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// Bakes a new macaroon with limited permissions for invoice tracking
/// This macaroon will be stored in Firebase and used by backend services
/// to track payment status without having full admin access
Future<String> bakeLimitedMacaroon({
  required String nodeId,
  required String adminMacaroon,
  List<String>? permissions,
}) async {
  final logger = Get.find<LoggerService>();
  logger.i("bakeLimitedMacaroon: Creating limited macaroon for node $nodeId");
  
  try {
    // Get Caddy URL
    final litdController = Get.find<LitdController>();
    final baseUrl = litdController.litd_baseurl.value;
    final url = 'https://$baseUrl/$nodeId/v1/macaroon';
    
    logger.i("Baking macaroon at: $url");
    
    // Default permissions for invoice tracking
    final macaroonPermissions = permissions ?? [
      'invoices:read',      // Can list and read invoices
      'offchain:read',      // Can read payment status
      'info:read',          // Can read node info
    ];
    
    // LND expects permissions in a specific format
    final permissionsList = macaroonPermissions.map((perm) => {
      'entity': perm.split(':')[0],
      'action': perm.split(':')[1],
    }).toList();
    
    // Prepare request data
    final Map<String, dynamic> data = {
      'permissions': permissionsList,
      'root_key_id': '0',  // Use default root key
      'allow_external_permissions': false,
    };
    
    // Set up headers
    final headers = {
      'Grpc-Metadata-macaroon': adminMacaroon,
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
    
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final bakedMacaroon = decoded['macaroon'] ?? '';
      
      if (bakedMacaroon.isEmpty) {
        logger.e("Received empty macaroon from bake request");
        return '';
      }
      
      logger.i("✅ Successfully baked limited macaroon with permissions: $macaroonPermissions");
      return bakedMacaroon;
    } else {
      final error = jsonDecode(response.body);
      logger.e("Failed to bake macaroon: ${error['message'] ?? error['error'] ?? 'Unknown error'}");
      return '';
    }
  } catch (e) {
    logger.e("Error baking macaroon: $e");
    return '';
  }
}

/// Common macaroon permission sets
class MacaroonPermissions {
  /// Read-only invoice tracking permissions
  static const List<String> invoiceTracking = [
    'invoices:read',
    'offchain:read',
    'info:read',
  ];
  
  /// Payment sending permissions
  static const List<String> paymentSending = [
    'invoices:write',
    'offchain:write',
    'offchain:read',
    'info:read',
  ];
  
  /// Read-only wallet permissions
  static const List<String> walletRead = [
    'onchain:read',
    'offchain:read',
    'info:read',
    'invoices:read',
  ];
}