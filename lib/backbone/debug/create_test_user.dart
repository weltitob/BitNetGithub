import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/verify_message.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/sign_lightning_message.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';

/// Debug utility for creating test users with predefined data
/// This is for development/testing only and should NOT be used in production
class CreateTestUser {
  // Predefined test data for node12
  static const String testUsername = 'node12_debug';
  static const String testEmail = 'node12debug@debug.bitnet';
  static const String testPassword = 'TestPassword123!';
  static const String testNodeId = 'node12';

  // Admin macaroon for node12 (base64) - from actual node12 logs
  static const String testMacaroon =
      'AgEDbG5kAvgBAwoQTukszzJeveaIZc4ATy8a5BIBMBoWCgdhZGRyZXNzEgRyZWFkEgV3cml0ZRoTCgRpbmZvEgRyZWFkEgV3cml0ZRoXCghpbnZvaWNlcxIEcmVhZBIFd3JpdGUaIQoIbWFjYXJvb24SCGdlbmVyYXRlEgRyZWFkEgV3cml0ZRoWCgdtZXNzYWdlEgRyZWFkEgV3cml0ZRoXCghvZmZjaGFpbhIEcmVhZBIFd3JpdGUaFgoHb25jaGFpbhIEcmVhZBIFd3JpdGUaFAoFcGVlcnMSBHJlYWQSBXdyaXRlGhgKBnNpZ25lchIIZ2VuZXJhdGUSBHJlYWQAAAYgKJMiiClRYWuZxocBWnRme5SXkYiGC/4HCGgEclNdxrE=';

  // Admin macaroon for testnode1 (provided by user)
  // AgEDbG5kAvgBAwoQTukszzJeveaIZc4ATy8a5BIBMBoWCgdhZGRyZXNzEgRyZWFkEgV3cml0ZRoTCgRpbmZvEgRyZWFkEgV3cml0ZRoXCghpb
  // nZvaWNlcxIEcmVhZBIFd3JpdGUaIQoIbWFjYXJvb24SCGdlbmVyYXRlEgRyZWFkEgV3cml0ZRoWCgdtZXNzYWdlEgRyZWFkEgV3cml0ZRoXCg
  // hvZmZjaGFpbhIEcmVhZBIFd3JpdGUaFgoHb25jaGFpbhIEcmVhZBIFd3JpdGUaFAoFcGVlcnMSBHJlYWQSBXdyaXRlGhgKBnNpZ25lchIIZ2V
  // uZXJhdGUSBHJlYWQAAAYgKJMiiClRYWuZxocBWnRme5SXkYiGC/4HCGgEclNdxrE=

  // Hardcoded DID for node12 debug login - no mnemonic needed
  static const String testRecoveryDid = 'did:mnemonic:7060df39a4c333db';
  
  // Dummy mnemonic - not used for actual authentication, just for compatibility
  static const String testMnemonic =
      'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';

  // Test addresses for node12
  static const String testTaprootAddress =
      'bc1p_debug_taproot_address_node12';
  static const String testSegwitAddress = 'bc1q_debug_segwit_address_node12';

  // Test Lightning pubkey for node12 - from actual node12 logs
  static const String testLightningPubkey =
      '02797ad37f4a6fb0d97f0fa48701e1caacbe2bcdaa6cf7b10cc686f973feee1bcc';

  /// Creates or logs in the test user using BitNET's Lightning auth flow
  static Future<bool> createOrLoginTestUser() async {
    try {
      print(
          '🔧 DEBUG: Starting test user creation/login with BitNET auth flow...');

      // First, ensure we have the private data stored locally
      print('📝 Storing private data for Lightning auth...');

      // Use hardcoded recovery DID for node12 debug
      final recoveryDid = testRecoveryDid;
      print('🔑 Using hardcoded Recovery DID: $recoveryDid');

      // Check if user already exists
      bool userExists = false;
      String? existingUserId;

      try {
        // Check if we already have a user with this recovery DID
        final userNodeMapping =
            await NodeMappingService.getUserNodeMapping(recoveryDid);
        if (userNodeMapping != null) {
          print('✅ User already exists with this mnemonic');
          
          // Check if it's using the wrong node
          if (userNodeMapping.nodeId != testNodeId) {
            print('⚠️  WARNING: Existing mapping uses ${userNodeMapping.nodeId}, but we want $testNodeId');
            print('🗑️  Deleting old node mapping to use new node...');
            
            // Delete the old mapping
            await FirebaseFirestore.instance
                .collection('user_node_mappings')
                .doc('${recoveryDid}_${userNodeMapping.nodeId}')
                .delete();
            print('✅ Old node mapping deleted');
            
            // Force new registration with correct node
            userExists = false;
          } else {
            // For debug user, we need to check if a user exists with our specific DID
            // Since node12 is mapped to our hardcoded DID, we should use that DID as the user ID
            print('📝 Node mapping exists for $testNodeId, checking for user with DID...');
            
            // Try to find user by DID (document ID)
            try {
              final userDoc = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(recoveryDid)
                  .get();
                  
              if (userDoc.exists) {
                userExists = true;
                existingUserId = recoveryDid;
                print('✅ Found user with correct DID: $existingUserId');
              } else {
                print('❌ No user document found for DID: $recoveryDid');
                print('🆕 Will create new user with this DID');
                userExists = false;
              }
            } catch (e) {
              print('❌ Error checking user by DID: $e');
              userExists = false;
            }
          }
        }
      } catch (e) {
        print('No existing user found, will create new');
      }

      // If user exists, do login flow, otherwise do registration
      if (userExists && existingUserId != null) {
        print('🔑 Performing Lightning login for existing user...');
        return await _doLightningLogin(existingUserId);
      } else {
        print('🆕 Performing Lightning registration for new user...');
        return await _doLightningRegistration();
      }
    } catch (e) {
      print('❌ Error in test user creation: $e');
      print('Stack trace: ${StackTrace.current}');
      return false;
    }
  }

  /// Performs Lightning-based login for existing user
  static Future<bool> _doLightningLogin(String userId) async {
    try {
      print('🔐 Starting Lightning login flow for existing user...');

      // Store private data for auth
      final privateData = PrivateData(
        did: userId,
        mnemonic: testMnemonic,
      );
      await storePrivateData(privateData);
      print('💾 Private data stored');

      // Wait for Lightning node to be ready
      print('⏳ Waiting for Lightning node to be ready...');
      await Future.delayed(Duration(seconds: 2)); // Shorter wait for mainnet node12

      // Create challenge for login
      print('🔐 Creating login challenge...');
      final userChallengeResponse =
          await create_challenge(userId, ChallengeType.mnemonic_login);
      if (userChallengeResponse == null) {
        throw Exception('Failed to create login challenge');
      }

      final challengeId = userChallengeResponse.challenge.challengeId;
      final challengeData = userChallengeResponse.challenge.title;
      print('📋 Challenge created: $challengeId');

      // Sign the challenge with Lightning node
      print('⚡ Signing challenge with Lightning node...');
      final lightningSignature = await signLightningMessage(
        challengeData,
        nodeId: testNodeId,
        userDid: userId,
      );

      if (lightningSignature == null) {
        throw Exception('Failed to sign with Lightning node');
      }
      print('✅ Lightning signature obtained');

      // Verify the signature and get custom token
      print('🔐 Verifying signature...');
      final customAuthToken = await verifyMessage(
        userId,
        challengeId.toString(),
        lightningSignature,
        nodeId: testNodeId,
      );

      if (customAuthToken == null) {
        throw Exception('Failed to verify signature');
      }
      print('✅ Signature verified, got custom token');

      // Sign in with Firebase
      print('🔥 Signing in with Firebase...');
      final auth = Auth();
      final userCredential =
          await auth.signInWithToken(customToken: customAuthToken);

      if (userCredential == null) {
        throw Exception('Failed to sign in with custom token');
      }
      print('✅ Firebase sign-in successful');

      // Update localStorage
      if (!Get.isRegistered<LocalStorage>()) {
        final localStorage = LocalStorage();
        await localStorage.initStorage();
        Get.put(localStorage);
      }

      final localStorage = Get.find<LocalStorage>();
      localStorage.setString(userId, 'userId');
      localStorage.setBool(true, 'isLoggedIn');
      localStorage.setString(testUsername, 'currentUsername');
      localStorage.setString(userId, 'currentUserDid');

      // Store the macaroon locally for this user
      await storeLitdAccountData(userId, testNodeId, testMacaroon);

      print('✅ Node12 debug user login complete!');
      print('📋 Logged in as:');
      print('   Username: $testUsername');
      print('   User ID: $userId');
      print('   Node: $testNodeId (mainnet)');

      return true;
    } catch (e) {
      print('❌ Lightning login failed: $e');
      print('Stack trace: ${StackTrace.current}');
      return false;
    }
  }

  /// Performs Lightning-based registration for new user
  static Future<bool> _doLightningRegistration() async {
    try {
      print('🔐 Starting Lightning registration flow...');

      // Use hardcoded recovery DID for node12 debug
      final recoveryDid = testRecoveryDid;

      // Check if node mapping already exists
      final existingMapping =
          await NodeMappingService.getUserNodeMapping(recoveryDid);
      if (existingMapping == null) {
        print('📝 Creating node mapping for test user...');

        // Create node mapping first with proper Caddy endpoint
        final nodeMapping = UserNodeMapping(
          recoveryDid: recoveryDid,
          lightningPubkey: testLightningPubkey,
          nodeId: testNodeId,
          caddyEndpoint:
              'https://api.bitnet.ai/$testNodeId',
          adminMacaroon: testMacaroon,
          createdAt: DateTime.now(),
          lastAccessed: DateTime.now(),
          status: 'active',
        );

        await NodeMappingService.storeUserNodeMapping(nodeMapping);
        // Don't store mnemonic recovery index for debug user - no real mnemonic
        print('✅ Node mapping created (debug user - no mnemonic index)');
      }

      // Wait for Lightning node to be ready before proceeding
      print('⏳ Waiting for Lightning node to be ready...');
      print('⏳ Node12 is a mainnet node, should be ready quickly...');
      await Future.delayed(
          Duration(seconds: 3)); // Shorter wait for mainnet node12

      // For debug user, use the hardcoded recovery DID as the user ID
      final userId = recoveryDid;

      // Create user data
      final userData = UserData(
        docId: userId,
        did: userId,
        displayName: testUsername,
        username: testUsername,
        bio: 'Debug test user account for node12 mainnet',
        customToken: '',
        profileImageUrl: '',
        backgroundImageUrl: '',
        isPrivate: false,
        showFollowers: true,
        setupQrCodeRecovery: false,
        setupWordRecovery: false,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        isActive: true,
        dob: 0,
        nft_profile_id: '',
        nft_background_id: '',
      );

      // Create verification code (for debug purposes)
      final verificationCode = VerificationCode(
        used: false,
        code: 'DEBUG_CODE_123',
        issuer: 'debug_system',
        receiver: userId,
      );

      // Store in verification codes collection so Auth can find it
      await FirebaseFirestore.instance
          .collection('verificationCodes')
          .doc('debug_system')
          .collection('codes')
          .doc('DEBUG_CODE_123')
          .set(verificationCode.toJson());

      print('📝 Verification code stored');

      // Store private data with recovery DID first
      final privateData = PrivateData(
        did: recoveryDid,
        mnemonic: testMnemonic,
      );
      await storePrivateData(privateData);
      print('💾 Private data stored');

      // Call Auth().createUser which handles the full Lightning auth flow
      // This will retry the Lightning node connection internally
      final auth = Auth();
      final createdUser = await auth.createUser(
        user: userData,
        code: verificationCode,
        mnemonicForRegistration: testMnemonic,
      );

      print('✅ User created with Lightning auth!');
      print('   Final DID: ${createdUser.did}');

      // Store the macaroon locally for this user
      await storeLitdAccountData(createdUser.did, testNodeId, testMacaroon);

      // Create onchain addresses
      await FirebaseFirestore.instance
          .collection('OnchainAddressesV2')
          .doc(createdUser.did)
          .set({
        'taproot_native': testTaprootAddress,
        'segwit_native': testSegwitAddress,
        'created_at': FieldValue.serverTimestamp(),
      });
      print('✅ Onchain addresses created');

      // Update localStorage
      if (!Get.isRegistered<LocalStorage>()) {
        final localStorage = LocalStorage();
        await localStorage.initStorage();
        Get.put(localStorage);
      }

      final localStorage = Get.find<LocalStorage>();
      localStorage.setString(createdUser.did, 'userId');
      localStorage.setBool(true, 'isLoggedIn');
      localStorage.setString(testUsername, 'currentUsername');
      localStorage.setString(createdUser.did, 'currentUserDid');

      print('✅ Node12 debug user setup complete!');
      print('📋 Summary:');
      print('   Username: $testUsername');
      print('   User ID / DID: ${createdUser.did}');
      print('   Node: $testNodeId (mainnet)');
      print('   Recovery DID: $recoveryDid');

      return true;
    } catch (e) {
      print('❌ Lightning registration failed: $e');
      print('Stack trace: ${StackTrace.current}');
      return false;
    }
  }

  /// Logs in with existing test user data (if already created)
  /// NOTE: This uses email/password auth which bypasses Lightning auth
  /// Use createOrLoginTestUser() for proper Lightning auth flow
  static Future<bool> quickLoginTestUser() async {
    try {
      print('⚡ Quick login for test user...');
      print('⚠️  WARNING: This bypasses Lightning auth for speed');
      print('⚠️  Use createOrLoginTestUser() for proper auth testing');

      // Check if user exists by looking for the recovery DID mapping
      final recoveryDid = testRecoveryDid;
      final nodeMapping =
          await NodeMappingService.getUserNodeMapping(recoveryDid);

      if (nodeMapping == null) {
        print('❌ No user found with test mnemonic');
        print('🔄 Falling back to full Lightning auth creation...');
        return await createOrLoginTestUser();
      }

      // Find the user document
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: testUsername)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('❌ No user document found');
        print('🔄 Falling back to full Lightning auth creation...');
        return await createOrLoginTestUser();
      }

      final userId = querySnapshot.docs.first.id;
      print('Found user ID: $userId');

      // Store private data for potential auth needs
      final privateData = PrivateData(
        did: userId,
        mnemonic: testMnemonic,
      );
      await storePrivateData(privateData);

      // Initialize LocalStorage if not already done
      if (!Get.isRegistered<LocalStorage>()) {
        final localStorage = LocalStorage();
        await localStorage.initStorage();
        Get.put(localStorage);
      }

      final localStorage = Get.find<LocalStorage>();

      // Set as logged in (simulating successful auth)
      localStorage.setString(userId, 'userId');
      localStorage.setBool(true, 'isLoggedIn');
      localStorage.setString(testUsername, 'currentUsername');
      localStorage.setString(userId, 'currentUserDid');

      // Sign in to Firebase with a service account or admin SDK
      // For now, we'll skip Firebase auth since this is debug-only
      print('⚠️  Skipping Firebase auth - debug mode only');
      print('✅ Quick login successful (bypassed auth)');

      return true;
    } catch (e) {
      print('❌ Quick login failed: $e');
      // Fall back to full creation
      return await createOrLoginTestUser();
    }
  }

  /// Checks if test user exists
  static Future<bool> testUserExists() async {
    try {
      // Check by recovery DID in node mappings
      final recoveryDid = testRecoveryDid;
      final nodeMapping =
          await NodeMappingService.getUserNodeMapping(recoveryDid);

      if (nodeMapping != null) {
        // Also verify user document exists
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: testUsername)
            .limit(1)
            .get();

        return querySnapshot.docs.isNotEmpty;
      }

      return false;
    } catch (e) {
      print('Error checking if test user exists: $e');
      return false;
    }
  }

  /// Deletes test user data (cleanup utility)
  static Future<void> deleteTestUser() async {
    try {
      print('🗑️ Deleting test user data...');

      // Use hardcoded recovery DID for node12 debug
      final recoveryDid = testRecoveryDid;

      // Delete by DID first
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(recoveryDid)
            .delete();
        print('✅ Deleted user document by DID: $recoveryDid');
      } catch (e) {
        print('⚠️  No user found with DID: $recoveryDid');
      }

      // Also find and delete any users with the test username (cleanup old data)
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: testUsername)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print('Found ${querySnapshot.docs.length} user(s) with username: $testUsername');
        
        // Delete all users with this username
        for (final doc in querySnapshot.docs) {
          final userId = doc.id;
          print('Deleting user: $userId');
          
          // Delete user document
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .delete();
          print('✅ Deleted user document: $userId');
          
          // Delete related data
          try {
            await FirebaseFirestore.instance
                .collection('OnchainAddressesV2')
                .doc(userId)
                .delete();
            print('✅ Deleted onchain addresses for: $userId');
          } catch (e) {
            print('⚠️  No onchain addresses found for: $userId');
          }
        }
      }

      // Delete node mapping
      try {
        await FirebaseFirestore.instance
            .collection('user_node_mappings')
            .doc('${recoveryDid}_${testNodeId}')
            .delete();
        print('✅ Deleted node mapping');
      } catch (e) {
        print('⚠️  No node mapping found');
      }

      // Delete verification code if exists
      try {
        await FirebaseFirestore.instance
            .collection('verificationCodes')
            .doc('debug_system')
            .collection('codes')
            .doc('DEBUG_CODE_123')
            .delete();
        print('✅ Deleted verification code');
      } catch (e) {
        print('⚠️  No verification code found');
      }

      // Clear local storage
      if (Get.isRegistered<LocalStorage>()) {
        final localStorage = Get.find<LocalStorage>();
        localStorage.remove('userId');
        localStorage.remove('isLoggedIn');
        localStorage.remove('currentUsername');
        localStorage.remove('currentUserDid');
      }

      // Sign out from Firebase if signed in
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.signOut();
      }

      print('✅ Test user deletion process completed');
    } catch (e) {
      print('❌ Error deleting test user: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }
}
