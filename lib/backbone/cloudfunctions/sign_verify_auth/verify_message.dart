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
  final logger = Get.find<LoggerService>();
  logger.i("🛡️ ✅ VERIFY_MESSAGE FUNCTION CALLED");
  
  logger.i("🛡️ === VERIFY_MESSAGE FUNCTION START ===");
  logger.i("🛡️ Input DID: '$did'");
  logger.i("🛡️ Input Challenge ID: '$challengeId'");
  logger.i("🛡️ Input Signature: '${signature.substring(0, 20)}...'");
  logger.i("🛡️ Input Node ID: $nodeId");

  try {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('verify_lightning_signature_http');

    // If nodeId is not provided, try to get it from user's node mapping
    String? userNodeId = nodeId;
    if (userNodeId == null) {
      logger.i("🛡️ 🔍 === RETRIEVING USER NODE MAPPING ===");
      logger.i("🛡️ 🔍 About to call NodeMappingService.getUserNodeMapping('$did')...");
      
      try {
        final UserNodeMapping? nodeMapping = await NodeMappingService.getUserNodeMapping(did);
        
        logger.i("🛡️ 🔍 Node mapping response: ${nodeMapping != null ? 'NOT NULL' : 'NULL'}");
        
        if (nodeMapping != null) {
          userNodeId = nodeMapping.nodeId;
          logger.i("🛡️ 🔍 Retrieved user's node ID from mapping: $userNodeId");
        } else {
          logger.e("🛡️ ❌ No node mapping found for user DID: $did");
          throw Exception("No Lightning node found for user");
        }
      } catch (e, stackTrace) {
        logger.e("🛡️ ❌ Failed to get user's node ID: $e");
        logger.e("🛡️ ❌ Error type: ${e.runtimeType}");
        logger.e("🛡️ ❌ Stack trace: $stackTrace");
        if (e is StateError) {
          logger.e("🛡️ ❌ 🚨 THIS IS A STATE ERROR in getUserNodeMapping - likely the 'Bad state: No element'!");
        }
        throw Exception("Failed to determine user's Lightning node: $e");
      }
    }

    final Map<String, dynamic> requestData = {
      'did': did,
      'challengeid': challengeId,
      'signature': signature,
      'node_id': userNodeId,  // Send node_id to backend
    };

    logger.i("🛡️ 📤 === CALLING FIREBASE CLOUD FUNCTION ===");
    logger.i("🛡️ 📤 Function name: 'verify_lightning_signature_func'");
    logger.i("🛡️ 📤 Request data: $requestData");
    logger.i("🛡️ 📤 About to call Firebase function...");

    final HttpsCallableResult<dynamic> response = await callable.call(requestData);

    logger.i("🛡️ 📥 === FIREBASE CLOUD FUNCTION RESPONSE ===");
    logger.i("🛡️ 📥 Response received: ${response != null ? 'NOT NULL' : 'NULL'}");
    logger.i("🛡️ 📥 Response data type: ${response.data?.runtimeType}");
    logger.i("🛡️ 📥 Response data: ${response.data}");

    // Follow the same pattern as create_challenge
    if (response.data != null && response.data is Map) {
      logger.i("🛡️ 📥 Response data is valid Map, converting...");
      
      final Map<String, dynamic> responseData = Map<String, dynamic>.from(response.data as Map);
      logger.i("🛡️ 📥 Converted response data: $responseData");

      // Check if the response contains a customToken directly in the message field
      if (responseData.containsKey('message')) {
        final String messageJson = responseData['message'] as String;
        logger.i("🛡️ 📥 Message JSON: $messageJson");
        
        try {
          final Map<String, dynamic> messageData = jsonDecode(messageJson) as Map<String, dynamic>;
          logger.i("🛡️ 📥 Parsed message data: $messageData");
          
          if (messageData.containsKey('data') && messageData['data'].containsKey('customToken')) {
            String customToken = messageData['data']['customToken'] as String;
            logger.i("🛡️ 📥 Custom Token extracted: ${customToken.substring(0, 20)}...");
            return customToken;
          }
        } catch (e) {
          logger.e("🛡️ ❌ Error parsing message JSON: $e");
        }
      }
      
      logger.e("🛡️ ❌ Custom Token not found in response");
      return null;
    } else {
      logger.e("🛡️ ❌ Response data is null or not a Map");
      logger.e("🛡️ ❌ Response data type: ${response.data?.runtimeType}");
      logger.e("🛡️ ❌ Response data value: ${response.data}");
      return null;
    }
  } catch (e, stackTrace) {
    logger.e("🛡️ ❌ Error in verifyMessage: $e");
    logger.e("🛡️ ❌ Error type: ${e.runtimeType}");
    logger.e("🛡️ ❌ Stack trace: $stackTrace");
    if (e is StateError) {
      logger.e("🛡️ ❌ 🚨 THIS IS A STATE ERROR in verifyMessage - likely the 'Bad state: No element'!");
    }
    rethrow;
  }
}
