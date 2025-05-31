import 'dart:convert';
import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

//verifymessage

dynamic verifyMessage(String did, String challengeId, String signature, {String? nodeId}) async {
  HttpsCallable callable =
  FirebaseFunctions.instance.httpsCallable('verify_lightning_signature_func');

  final logger = Get.find<LoggerService>();

  logger.i("🔐 Lightning Verification - DID: $did");
  logger.i("🔐 Lightning Verification - Challenge ID: $challengeId");
  logger.i("🔐 Lightning Verification - Signature: $signature");
  logger.i("🔐 Lightning Verification - Node ID: $nodeId");

  // If nodeId is not provided, try to get it from user's node mapping
  String? userNodeId = nodeId;
  if (userNodeId == null) {
    try {
      final UserNodeMapping? nodeMapping = await NodeMappingService.getUserNodeMapping(did);
      if (nodeMapping != null) {
        userNodeId = nodeMapping.nodeId;
        logger.i("🔍 Retrieved user's node ID from mapping: $userNodeId");
      } else {
        logger.e("❌ No node mapping found for user DID: $did");
        throw Exception("No Lightning node found for user");
      }
    } catch (e) {
      logger.e("❌ Failed to get user's node ID: $e");
      throw Exception("Failed to determine user's Lightning node: $e");
    }
  }

  final HttpsCallableResult<dynamic> response =
  await callable.call(<String, dynamic>{
    'did': did,
    'challengeid': challengeId,
    'signature': signature,
    'node_id': userNodeId,  // Send node_id to backend
  });

  logger.i("Response VERIFY MESSAGE: ${response.data}");

  // Assuming response.data is a Map, cast it appropriately
  final Map<String, dynamic> responseData =
  deepMapCast(response.data as Map<Object?, Object?>);
  final RestResponse callback = RestResponse.fromJson(responseData);

  logger.i("CloudfunctionCallback: ${callback.toString()}");
  logger.i("Message: ${callback.message}");

  // Parse the message string to a Map
  final Map<String, dynamic> messageData =
  jsonDecode(callback.message) as Map<String, dynamic>;

  // Extract the 'data' field
  if (messageData.containsKey('data')) {
    final Map<String, dynamic> data =
    messageData['data'] as Map<String, dynamic>;

    // Safely extract the customToken from the data
    if (data.containsKey('customToken')) {
      String customToken = data['customToken'] as String;
      logger.i("Custom Token: $customToken");
      return customToken;
    } else {
      logger.i("Custom Token not found in message data.");
      return null;
    }
    } else {
      logger.e("Data field not found in message.");
      return null;
    }
}
