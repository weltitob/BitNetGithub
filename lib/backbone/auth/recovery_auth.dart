import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/sign_message.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/verify_message.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/keys/userchallenge.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

/// Recovery Authentication
///
/// Handles account recovery using mnemonics with the new recovery-safe architecture.
/// Users can recover their accounts knowing only their mnemonic phrase.
class RecoveryAuth {
  static LoggerService get _logger => Get.find<LoggerService>();

  /// Recover user account with mnemonic phrase
  ///
  /// This is the main recovery entry point. It:
  /// 1. Generates recovery DID from mnemonic
  /// 2. Finds the user's Lightning node
  /// 3. Authenticates using Lightning node signing
  /// 4. Signs user into Firebase
  static Future<bool> recoverWithMnemonic(String mnemonic) async {
    try {
      _logger.i("🔄 Starting account recovery with mnemonic");

      // STEP 1: Generate recovery DID from mnemonic
      _logger.i("=== STEP 1: GENERATING RECOVERY DID ===");
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonic);
      _logger.i("Recovery DID: $recoveryDid");

      // STEP 2: Look up user's Lightning node mapping
      _logger.i("=== STEP 2: FINDING USER'S LIGHTNING NODE ===");
      UserNodeMapping? nodeMapping =
          await NodeMappingService.getUserNodeMapping(recoveryDid);

      if (nodeMapping == null) {
        _logger.e("❌ No account found for this mnemonic");
        throw Exception(
            "No account found for this mnemonic. Please check your recovery phrase or create a new account.");
      }

      _logger.i("✅ Found user's Lightning node:");
      _logger.i("- Node ID: ${nodeMapping.nodeId}");
      _logger.i("- Lightning pubkey: ${nodeMapping.shortLightningPubkey}");
      _logger.i("- Status: ${nodeMapping.status}");

      if (!nodeMapping.isActive) {
        _logger
            .e("❌ User's Lightning node is not active: ${nodeMapping.status}");
        throw Exception("Account is not active. Please contact support.");
      }

      // STEP 3: Restore private data to secure storage
      _logger.i("=== STEP 3: RESTORING PRIVATE DATA ===");
      PrivateData privateData =
          PrivateData(did: recoveryDid, mnemonic: mnemonic);
      await storePrivateData(privateData);
      _logger.i("✅ Private data restored to secure storage");

      // STEP 4: Create authentication challenge
      _logger.i("=== STEP 4: CREATING AUTHENTICATION CHALLENGE ===");
      UserChallengeResponse? challengeResponse =
          await create_challenge(recoveryDid, ChallengeType.mnemonic_login);

      if (challengeResponse == null) {
        throw Exception("Failed to create authentication challenge");
      }

      String challengeId = challengeResponse.challenge.challengeId;
      String challengeData = challengeResponse.challenge.title;
      _logger.i("Challenge ID: $challengeId");
      _logger.i("Challenge data: ${challengeData.substring(0, 20)}...");

      // STEP 5: Sign challenge with user's Lightning node using their specific macaroon
      _logger.i("=== STEP 5: SIGNING CHALLENGE WITH LIGHTNING NODE ===");
      RestResponse signResponse = await signMessageWithNode(
        message: challengeData,
        nodeId: nodeMapping.nodeId,
        userDid: recoveryDid, // Use user's DID to load their specific macaroon
      );

      if (signResponse.statusCode != "200") {
        _logger.e(
            "❌ Failed to sign challenge with Lightning node: ${signResponse.message}");
        throw Exception(
            "Failed to sign authentication challenge: ${signResponse.message}");
      }

      String signature = signResponse.data['signature'] ?? '';
      if (signature.isEmpty) {
        throw Exception("No signature returned from Lightning node");
      }

      _logger.i("✅ Challenge signed successfully");
      _logger.i("Signature: ${signature.substring(0, 20)}...");

      // STEP 6: Verify Lightning signature and get Firebase token
      _logger.i("=== STEP 6: VERIFYING SIGNATURE AND GETTING TOKEN ===");

      dynamic customAuthToken = await verifyMessage(
        recoveryDid, // Use recovery DID (not Lightning pubkey)
        challengeId,
        signature,
        nodeId: nodeMapping.nodeId, // Send user's specific node ID
      );

      _logger.i("✅ Signature verified, received auth token");

      // STEP 7: Sign in to Firebase
      _logger.i("=== STEP 7: SIGNING IN TO FIREBASE ===");
      final userCredential =
          await Auth().signInWithToken(customToken: customAuthToken);

      if (userCredential == null) {
        throw Exception("Failed to sign in with custom token");
      }

      _logger.i("✅ Successfully signed in to Firebase");
      _logger.i("User ID: ${userCredential.user?.uid}");

      // STEP 8: Update last accessed timestamp
      _logger.i("=== STEP 8: UPDATING ACCESS TIMESTAMP ===");
      try {
        UserNodeMapping updatedMapping = nodeMapping.updateLastAccessed();
        await NodeMappingService.updateUserNodeMapping(
            recoveryDid, updatedMapping);
        _logger.i("✅ Access timestamp updated");
      } catch (e) {
        _logger.w("Failed to update access timestamp: $e");
        // Don't fail the entire recovery for this
      }

      _logger.i("🎉 ACCOUNT RECOVERY COMPLETED SUCCESSFULLY");
      return true;
    } catch (e) {
      _logger.e("❌ Account recovery failed: $e");
      rethrow;
    }
  }

  /// Quick check if an account exists for a mnemonic
  ///
  /// Useful for showing users whether they should use recovery or create new account
  static Future<bool> checkAccountExists(String mnemonic) async {
    try {
      return await NodeMappingService.userExistsByMnemonic(mnemonic);
    } catch (e) {
      _logger.e("Error checking if account exists: $e");
      return false;
    }
  }

  /// Get account info for a mnemonic without signing in
  ///
  /// Returns basic account information for display to user during recovery
  static Future<Map<String, dynamic>?> getAccountInfo(String mnemonic) async {
    try {
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonic);
      UserNodeMapping? nodeMapping =
          await NodeMappingService.getUserNodeMapping(recoveryDid);

      if (nodeMapping == null) {
        return null;
      }

      return {
        'recovery_did': nodeMapping.recoveryDid,
        'node_id': nodeMapping.nodeId,
        'lightning_pubkey': nodeMapping.shortLightningPubkey,
        'status': nodeMapping.status,
        'created_at': nodeMapping.createdAt.toIso8601String(),
        'last_accessed': nodeMapping.lastAccessed.toIso8601String(),
      };
    } catch (e) {
      _logger.e("Error getting account info: $e");
      return null;
    }
  }

  /// Validate recovery mnemonic format
  ///
  /// Basic validation before attempting recovery
  static bool validateRecoveryMnemonic(String mnemonic) {
    if (mnemonic.trim().isEmpty) {
      return false;
    }

    List<String> words = mnemonic.trim().split(' ');

    // Basic word count check (Lightning aezeed is typically 24 words)
    if (words.length < 12 || words.length > 24) {
      return false;
    }

    // Check for obvious invalid characters
    for (String word in words) {
      if (word.trim().isEmpty || word.contains(RegExp(r'[^a-zA-Z]'))) {
        return false;
      }
    }

    return true;
  }

  /// Generate QR code data for account backup
  ///
  /// Creates QR code that can be used for recovery
  static Future<String?> generateRecoveryQrCode(String mnemonic) async {
    try {
      if (!await checkAccountExists(mnemonic)) {
        throw Exception("No account found for this mnemonic");
      }

      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonic);
      return RecoveryIdentity.generateRecoveryQrData(
        recoveryDid,
        hint: "BitNET Account Recovery",
        createdAt: DateTime.now(),
      );
    } catch (e) {
      _logger.e("Error generating recovery QR code: $e");
      return null;
    }
  }

  /// Recover account from QR code data
  ///
  /// Alternative recovery method using QR codes
  static Future<bool> recoverWithQrCode(String qrData) async {
    try {
      _logger.i("🔄 Starting account recovery with QR code");

      // Extract recovery DID from QR code
      String recoveryDid = RecoveryIdentity.extractRecoveryDid(qrData);
      _logger.i("Extracted recovery DID: $recoveryDid");

      // Get the node mapping
      UserNodeMapping? nodeMapping =
          await NodeMappingService.getUserNodeMapping(recoveryDid);

      if (nodeMapping == null) {
        throw Exception("No account found for this QR code");
      }

      // QR recovery still requires the mnemonic for Lightning node access
      // This is a security feature - QR code alone is not enough
      throw Exception(
          "QR code recovery requires mnemonic phrase for security. Please enter your recovery phrase.");
    } catch (e) {
      _logger.e("❌ QR code recovery failed: $e");
      rethrow;
    }
  }
}
