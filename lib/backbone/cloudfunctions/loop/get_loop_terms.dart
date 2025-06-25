import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

/// Fetches Loop In terms including minimum and maximum swap amounts
Future<RestResponse> getLoopInTerms(String userId) async {
  final logger = Get.find<LoggerService>();

  // Get user's node mapping
  final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);
  if (nodeMapping == null) {
    logger.e("No node mapping found for user: $userId");
    return RestResponse(
        statusCode: "error",
        message: "No Lightning node assigned to user",
        data: {});
  }

  final nodeId = nodeMapping.nodeId;
  logger.i("Getting Loop In terms from node: $nodeId for user: $userId");

  // Get the admin macaroon from node mapping (stored as base64)
  final macaroonBase64 = nodeMapping.adminMacaroon;
  if (macaroonBase64.isEmpty) {
    logger.e("No macaroon found in node mapping for node: $nodeId");
    return RestResponse(
        statusCode: "error",
        message: "Failed to load node credentials",
        data: {});
  }

  // Convert base64 macaroon to hex format
  final macaroonBytes = base64Decode(macaroonBase64);
  final macaroon = bytesToHex(macaroonBytes);

  // Build URL using Caddy endpoint
  String url = '${LightningConfig.caddyBaseUrl}/$nodeId/v1/loop/in/terms';
  logger.i("Loop In Terms URL: $url");

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    final DioClient dioClient = Get.find<DioClient>();

    logger.i('GET: $url');
    var response = await dioClient.get(url: url, headers: headers);
    logger.i('Loop In Terms Response: ${response.data}');

    if (response.statusCode == 200) {
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully retrieved Loop In Terms",
          data: response.data);
    } else {
      logger.e(
          'Failed to get Loop In terms: ${response.statusCode}, ${response.data}');
      Map<String, dynamic> decodedBody = response.data;
      return RestResponse(
          statusCode: "error", message: decodedBody['message'], data: {});
    }
  } catch (e) {
    logger.e('Error getting Loop In terms: $e');
    return RestResponse(
        statusCode: "error",
        message: "Failed to load Loop In terms: $e",
        data: {});
  }
}

/// Fetches Loop Out terms including minimum and maximum swap amounts
Future<RestResponse> getLoopOutTerms(String userId) async {
  final logger = Get.find<LoggerService>();

  // Get user's node mapping
  final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);
  if (nodeMapping == null) {
    logger.e("No node mapping found for user: $userId");
    return RestResponse(
        statusCode: "error",
        message: "No Lightning node assigned to user",
        data: {});
  }

  final nodeId = nodeMapping.nodeId;
  logger.i("Getting Loop Out terms from node: $nodeId for user: $userId");

  // Get the admin macaroon from node mapping (stored as base64)
  final macaroonBase64 = nodeMapping.adminMacaroon;
  if (macaroonBase64.isEmpty) {
    logger.e("No macaroon found in node mapping for node: $nodeId");
    return RestResponse(
        statusCode: "error",
        message: "Failed to load node credentials",
        data: {});
  }

  // Convert base64 macaroon to hex format
  final macaroonBytes = base64Decode(macaroonBase64);
  final macaroon = bytesToHex(macaroonBytes);

  // Build URL using Caddy endpoint
  String url = '${LightningConfig.caddyBaseUrl}/$nodeId/v1/loop/out/terms';
  logger.i("Loop Out Terms URL: $url");

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    final DioClient dioClient = Get.find<DioClient>();

    logger.i('GET: $url');
    var response = await dioClient.get(url: url, headers: headers);
    logger.i('Loop Out Terms Response: ${response.data}');

    if (response.statusCode == 200) {
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully retrieved Loop Out Terms",
          data: response.data);
    } else {
      logger.e(
          'Failed to get Loop Out terms: ${response.statusCode}, ${response.data}');
      Map<String, dynamic> decodedBody = response.data;
      return RestResponse(
          statusCode: "error", message: decodedBody['message'], data: {});
    }
  } catch (e) {
    logger.e('Error getting Loop Out terms: $e');
    return RestResponse(
        statusCode: "error",
        message: "Failed to load Loop Out terms: $e",
        data: {});
  }
}
