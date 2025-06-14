import 'dart:convert';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/lightning_node_finder.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/sign_message.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_info.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

/// Sign a message using Lightning node's native signing capabilities
/// 
/// This function connects to the user's Lightning node and signs the provided message
/// using the node's identity key, providing cryptographic proof of node ownership.
Future<String?> signLightningMessage(String message, {String? nodeId, String? userDid}) async {
  final logger = Get.find<LoggerService>();
  logger.i("⚡ ✅ SIGN_LIGHTNING_MESSAGE FUNCTION CALLED");
  
  logger.i("⚡ === SIGN_LIGHTNING_MESSAGE FUNCTION START ===");
  logger.i("⚡ Input message: '$message'");
  logger.i("⚡ Input nodeId: $nodeId");
  logger.i("⚡ Input userDid: $userDid");
  
  try {
    logger.i("⚡ 📤 === CALLING SIGN_MESSAGE_WITH_NODE ===");
    logger.i("⚡ 📤 About to call signMessageWithNode()...");
    
    // Use the new Lightning service with user-specific authentication
    RestResponse signResponse = await signMessageWithNode(
      message: message,
      nodeId: nodeId,
      userDid: userDid,
    );
    
    logger.i("⚡ 📥 === SIGN_MESSAGE_WITH_NODE RESPONSE ===");
    logger.i("⚡ 📥 Response received: ${signResponse != null ? 'NOT NULL' : 'NULL'}");
    logger.i("⚡ 📥 Status code: ${signResponse.statusCode}");
    logger.i("⚡ 📥 Message: ${signResponse.message}");
    logger.i("⚡ 📥 Data type: ${signResponse.data?.runtimeType}");
    logger.i("⚡ 📥 Data: ${signResponse.data}");
    
    if (signResponse.statusCode == "200") {
      String signature = signResponse.data['signature'] ?? '';
      logger.i("⚡ 📥 Extracted signature: '${signature.isNotEmpty ? signature.substring(0, 20) + '...' : 'EMPTY'}'");
      
      if (signature.isNotEmpty) {
        logger.i("✅ Lightning message signed successfully");
        return signature;
      } else {
        logger.e("⚡ ❌ Empty signature in Lightning response");
        return null;
      }
    } else {
      logger.e("⚡ ❌ Lightning signing failed with status: ${signResponse.statusCode}");
      logger.e("⚡ ❌ Error message: ${signResponse.message}");
      return null;
    }
    
  } catch (e, stackTrace) {
    logger.e("⚡ ❌ Error during Lightning message signing: $e");
    logger.e("⚡ ❌ Error type: ${e.runtimeType}");
    logger.e("⚡ ❌ Stack trace: $stackTrace");
    if (e is StateError) {
      logger.e("⚡ ❌ 🚨 THIS IS A STATE ERROR in signLightningMessage - likely the 'Bad state: No element'!");
    }
    return null;
  }
}

/// Load macaroon hex for Lightning authentication
/// 
/// In a production environment, this would load the macaroon from secure storage
/// or generate it through proper authentication flows. For now, this is a placeholder.
Future<String> _loadMacaroonHex() async {
  final logger = Get.find<LoggerService>();
  
  try {
    // TODO: Implement proper macaroon loading
    // This could involve:
    // 1. Loading from secure storage
    // 2. Generating through Lightning authentication
    // 3. Using node-specific macaroons
    
    logger.w("⚠️ Using placeholder macaroon loading - implement proper authentication");
    
    // For development/testing, return empty string to use alternative auth
    return "";
    
  } catch (e) {
    logger.e("❌ Error loading macaroon: $e");
    return "";
  }
}

/// Verify a Lightning signature
/// 
/// This function verifies a Lightning signature against the original message
/// using the Lightning node's verification endpoint.
Future<bool> verifyLightningSignature(String message, String signature, {String? nodeId, String? userDid}) async {
  final logger = Get.find<LoggerService>();
  
  try {
    // Use provided nodeId or find a working one
    String? workingNodeId = nodeId;
    if (workingNodeId == null) {
      workingNodeId = await LightningNodeFinder.findWorkingNode(
        timeoutSeconds: 5,
        includeDefaultNode: true,
      );
      
      if (workingNodeId == null) {
        logger.e("❌ No working Lightning node found for verification");
        return false;
      }
    }
    
    logger.i("🔍 Verifying Lightning signature with node: $workingNodeId");
    
    // Construct the Lightning REST API URL
    String verifyMessageUrl = LightningConfig.getLightningUrl('v1/verifymessage', nodeId: workingNodeId);
    
    // Load macaroon for authentication
    String macaroonHex = await _loadMacaroonHex();
    if (macaroonHex.isEmpty) {
      logger.w("⚠️ No macaroon available, skipping Lightning verification");
      return false;
    }
    
    // Prepare headers
    Map<String, String> headers = {
      'Grpc-Metadata-macaroon': macaroonHex,
      'Content-Type': 'application/json',
    };
    
    // Prepare payload
    Map<String, dynamic> payload = {
      'msg': utf8.encode(message).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(),
      'signature': signature,
    };
    
    // Make the verification request
    final response = await http.post(
      Uri.parse(verifyMessageUrl),
      headers: headers,
      body: jsonEncode(payload),
    ).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw Exception('Lightning verification request timed out');
      },
    );
    
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      bool isValid = responseData['valid'] ?? false;
      String recoveredPubkey = responseData['pubkey'] ?? '';
      
      logger.i("✅ Lightning verification result: $isValid");
      if (isValid) {
        logger.i("🔑 Recovered pubkey: ${recoveredPubkey.substring(0, 20)}...");
      }
      
      return isValid;
    } else {
      logger.e("❌ Lightning verification failed with status ${response.statusCode}");
      return false;
    }
    
  } catch (e) {
    logger.e("❌ Error during Lightning signature verification: $e");
    return false;
  }
}

/// Get Lightning node public key for identity verification
/// 
/// This function retrieves the Lightning node's public key which serves
/// as the identity for the user in the Lightning-native authentication system.
Future<String?> getLightningNodePubkey({String? nodeId, String? userDid}) async {
  final logger = Get.find<LoggerService>();
  
  try {
    // Use provided nodeId or find a working one
    String? workingNodeId = nodeId;
    if (workingNodeId == null) {
      workingNodeId = await LightningNodeFinder.findWorkingNode(
        timeoutSeconds: 5,
        includeDefaultNode: true,
      );
      
      if (workingNodeId == null) {
        logger.e("❌ No working Lightning node found");
        return null;
      }
    }
    
    logger.i("🔍 Getting Lightning node pubkey from: $workingNodeId");
    
    // Construct the Lightning REST API URL
    String getInfoUrl = LightningConfig.getLightningUrl('v1/getinfo', nodeId: workingNodeId);
    
    // For getinfo, we might not need authentication or use minimal auth
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    
    // Add macaroon if available
    String macaroonHex = await _loadMacaroonHex();
    if (macaroonHex.isNotEmpty) {
      headers['Grpc-Metadata-macaroon'] = macaroonHex;
    }
    
    // Make the getinfo request
    final response = await http.get(
      Uri.parse(getInfoUrl),
      headers: headers,
    ).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw Exception('Lightning getinfo request timed out');
      },
    );
    
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String pubkey = responseData['identity_pubkey'] ?? '';
      String alias = responseData['alias'] ?? '';
      
      if (pubkey.isNotEmpty) {
        logger.i("✅ Lightning node pubkey retrieved: ${pubkey.substring(0, 20)}...");
        logger.i("🏷️ Node alias: $alias");
        return pubkey;
      } else {
        logger.e("❌ Empty pubkey in Lightning getinfo response");
        return null;
      }
    } else {
      logger.e("❌ Lightning getinfo failed with status ${response.statusCode}");
      return null;
    }
    
  } catch (e) {
    logger.e("❌ Error getting Lightning node pubkey: $e");
    return null;
  }
}