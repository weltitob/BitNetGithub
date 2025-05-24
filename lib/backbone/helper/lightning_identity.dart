import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

class LightningIdentity {
  /// Generate deterministic DID from Lightning node's identity public key
  static String generateDidFromLightningPubkey(String lightningPubkey) {
    LoggerService logger = Get.find<LoggerService>();
    
    try {
      // Remove any whitespace and ensure consistent format
      String cleanPubkey = lightningPubkey.trim();
      
      logger.i("=== GENERATING LIGHTNING DID ===");
      logger.i("Lightning pubkey: $cleanPubkey");
      logger.i("Pubkey length: ${cleanPubkey.length}");
      
      // Validate Lightning pubkey format (should be 66 hex characters for compressed pubkey)
      if (cleanPubkey.length != 66) {
        logger.w("⚠️ Warning: Lightning pubkey length is ${cleanPubkey.length}, expected 66");
      }
      
      if (!RegExp(r'^[0-9a-fA-F]+$').hasMatch(cleanPubkey)) {
        throw Exception("Invalid Lightning pubkey format: contains non-hex characters");
      }
      
      // Create deterministic DID using SHA256 hash of the Lightning pubkey
      // This ensures the DID is always the same for the same Lightning node
      var bytes = utf8.encode(cleanPubkey.toLowerCase());
      var digest = sha256.convert(bytes);
      String hash = digest.toString().substring(0, 16); // Take first 16 characters
      
      String did = 'did:lightning:$hash';
      
      logger.i("✅ Generated Lightning DID: $did");
      logger.i("Hash: $hash");
      logger.i("Full SHA256: ${digest.toString()}");
      
      return did;
    } catch (e) {
      logger.e("❌ Error generating DID from Lightning pubkey: $e");
      throw Exception("Failed to generate DID from Lightning pubkey: $e");
    }
  }
  
  /// Alternative method: Use Lightning pubkey directly as DID (for compatibility)
  static String generateDidDirectFromLightningPubkey(String lightningPubkey) {
    LoggerService logger = Get.find<LoggerService>();
    
    try {
      String cleanPubkey = lightningPubkey.trim();
      
      logger.i("=== GENERATING DIRECT LIGHTNING DID ===");
      logger.i("Lightning pubkey: $cleanPubkey");
      
      // Use the pubkey directly as DID (same format as old HDWallet approach)
      String did = cleanPubkey;
      
      logger.i("✅ Generated direct Lightning DID: $did");
      
      return did;
    } catch (e) {
      logger.e("❌ Error generating direct DID from Lightning pubkey: $e");
      throw Exception("Failed to generate direct DID from Lightning pubkey: $e");
    }
  }
  
  /// Validate if a string is a valid Lightning DID
  static bool isValidLightningDid(String did) {
    try {
      // Check for Lightning DID format: did:lightning:hash
      if (did.startsWith('did:lightning:')) {
        String hash = did.substring('did:lightning:'.length);
        return hash.length == 16 && RegExp(r'^[0-9a-f]+$').hasMatch(hash);
      }
      
      // Check for direct Lightning pubkey format (66 hex characters)
      if (did.length == 66) {
        return RegExp(r'^[0-9a-fA-F]+$').hasMatch(did);
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }
  
  /// Extract Lightning pubkey from various DID formats for backward compatibility
  static String? extractPubkeyFromDid(String did) {
    LoggerService logger = Get.find<LoggerService>();
    
    try {
      logger.d("Extracting pubkey from DID: $did");
      
      // If it's a direct pubkey (old format), return as-is
      if (did.length == 66 && RegExp(r'^[0-9a-fA-F]+$').hasMatch(did)) {
        logger.d("DID is direct pubkey format");
        return did;
      }
      
      // If it's a Lightning DID format, we can't extract the original pubkey
      // (it's a hash), so return null to indicate lookup needed
      if (did.startsWith('did:lightning:')) {
        logger.d("DID is Lightning hash format - pubkey lookup required");
        return null;
      }
      
      logger.w("Unknown DID format: $did");
      return null;
    } catch (e) {
      logger.e("Error extracting pubkey from DID: $e");
      return null;
    }
  }
}