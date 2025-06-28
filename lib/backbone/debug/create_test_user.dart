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
  // Predefined test data
  static const String testUsername = 'testuser_2';
  static const String testEmail = 'testuser2@debug.bitnet';
  static const String testPassword = 'TestPassword123!';
  static const String testNodeId = 'node2';

  // Your provided macaroon (base64)
  static const String testMacaroon =
      'AgEDbG5kAvgBAwoQ/weJX+5bBfAK0yfk7aSzMRIBMBoWCgdhZGRyZXNzEgRyZWFkEgV3cml0ZRoTCgRpbmZvEgRyZWFkEgV3cml0ZRoXCghpbnZvaWNlcxIEcmVhZBIFd3JpdGUaIQoIbWFjYXJvb24SCGdlbmVyYXRlEgRyZWFkEgV3cml0ZRoWCgdtZXNzYWdlEgRyZWFkEgV3cml0ZRoXCghvZmZjaGFpbhIEcmVhZBIFd3JpdGUaFgoHb25jaGFpbhIEcmVhZBIFd3JpdGUaFAoFcGVlcnMSBHJlYWQSBXdyaXRlGhgKBnNpZ25lchIIZ2VuZXJhdGUSBHJlYWQAAAYgYCj995/9RFj9Zfx4adNyKCnAHMfFeEaYxyo5i9bwYuA=';

  // Admin macaroon for testnode1 (provided by user)
  // AgEDbG5kAvgBAwoQTukszzJeveaIZc4ATy8a5BIBMBoWCgdhZGRyZXNzEgRyZWFkEgV3cml0ZRoTCgRpbmZvEgRyZWFkEgV3cml0ZRoXCghpb
  // nZvaWNlcxIEcmVhZBIFd3JpdGUaIQoIbWFjYXJvb24SCGdlbmVyYXRlEgRyZWFkEgV3cml0ZRoWCgdtZXNzYWdlEgRyZWFkEgV3cml0ZRoXCg
  // hvZmZjaGFpbhIEcmVhZBIFd3JpdGUaFgoHb25jaGFpbhIEcmVhZBIFd3JpdGUaFAoFcGVlcnMSBHJlYWQSBXdyaXRlGhgKBnNpZ25lchIIZ2V
  // uZXJhdGUSBHJlYWQAAAYgKJMiiClRYWuZxocBWnRme5SXkYiGC/4HCGgEclNdxrE=

  // Test mnemonic (24 words - you can replace with your own)
  static const String testMnemonic =
      'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon art';

  // Test addresses
  static const String testTaprootAddress =
      'bc1p_debug_taproot_address_testuser2';
  static const String testSegwitAddress = 'bc1q_debug_segwit_address_testuser2';

  // Test Lightning pubkey (this will be fetched from the actual node during registration)
  static const String testLightningPubkey =
      '03debug_lightning_pubkey_testuser2_node2';

  /// Creates or logs in the test user using BitNET's Lightning auth flow
  static Future<bool> createOrLoginTestUser() async {
    try {
      print(
          '🔧 DEBUG: Starting test user creation/login with BitNET auth flow...');

      // First, ensure we have the private data stored locally
      print('📝 Storing private data for Lightning auth...');

      // Generate recovery DID from mnemonic
      final recoveryDid = RecoveryIdentity.generateRecoveryDid(testMnemonic);
      print('🔑 Recovery DID: $recoveryDid');

      // Check if user already exists
      bool userExists = false;
      String? existingUserId;

      try {
        // Check if we already have a user with this recovery DID
        final userNodeMapping =
            await NodeMappingService.getUserNodeMapping(recoveryDid);
        if (userNodeMapping != null) {
          print('✅ User already exists with this mnemonic');
          userExists = true;
          // Try to get the user ID from existing documents
          final querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: testUsername)
              .limit(1)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            existingUserId = querySnapshot.docs.first.id;
            print('Found existing user ID: $existingUserId');
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
      await Future.delayed(Duration(seconds: 10));

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

      print('✅ Test user login complete!');
      print('📋 Logged in as:');
      print('   Username: $testUsername');
      print('   User ID: $userId');
      print('   Node: $testNodeId');

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

      // First, ensure node mapping exists for the test user
      final recoveryDid = RecoveryIdentity.generateRecoveryDid(testMnemonic);

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
              'http://[2a02:8070:880:1e60:da3a:ddff:fee8:5b94]/$testNodeId',
          adminMacaroon: testMacaroon,
          createdAt: DateTime.now(),
          lastAccessed: DateTime.now(),
          status: 'active',
        );

        await NodeMappingService.storeUserNodeMapping(nodeMapping);
        await NodeMappingService.storeMnemonicRecoveryIndex(
            testMnemonic, recoveryDid);
        print('✅ Node mapping created');
      }

      // Wait for Lightning node to be ready before proceeding
      print('⏳ Waiting for Lightning node to be ready...');
      print('⏳ Node2 may take up to 40 seconds to fully initialize...');
      await Future.delayed(
          Duration(seconds: 10)); // Give node more time to start

      // Generate a temporary DID for initial user creation
      // The actual DID will be assigned by Firebase after auth
      final tempDid = recoveryDid; // Use recovery DID as temp DID

      // Create user data
      final userData = UserData(
        docId: tempDid,
        did: tempDid,
        displayName: testUsername,
        username: testUsername,
        bio: 'Debug test user account',
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
        receiver: tempDid,
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

      print('✅ Test user setup complete!');
      print('📋 Summary:');
      print('   Username: $testUsername');
      print('   User ID / DID: ${createdUser.did}');
      print('   Node: $testNodeId');
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
      final recoveryDid = RecoveryIdentity.generateRecoveryDid(testMnemonic);
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
      final recoveryDid = RecoveryIdentity.generateRecoveryDid(testMnemonic);
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

      // Generate recovery DID
      final recoveryDid = RecoveryIdentity.generateRecoveryDid(testMnemonic);

      // Find user by username
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: testUsername)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userId = querySnapshot.docs.first.id;
        print('Found user to delete: $userId');

        // Delete Firestore documents
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .delete();
        print('✅ Deleted user document');

        await FirebaseFirestore.instance
            .collection('user_node_mappings')
            .doc('${recoveryDid}_${testNodeId}')
            .delete();
        print('✅ Deleted node mapping');

        // Delete mnemonic recovery index
        await FirebaseFirestore.instance
            .collection('mnemonic_recovery_index')
            .doc(recoveryDid)
            .delete();
        print('✅ Deleted recovery index');

        await FirebaseFirestore.instance
            .collection('OnchainAddressesV2')
            .doc(userId)
            .delete();
        print('✅ Deleted onchain addresses');

        // Delete verification code if exists
        await FirebaseFirestore.instance
            .collection('verificationCodes')
            .doc('debug_system')
            .collection('codes')
            .doc('DEBUG_CODE_123')
            .delete();
        print('✅ Deleted verification code');

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

        print('✅ Test user deleted successfully');
      } else {
        print('❌ No test user found to delete');
      }
    } catch (e) {
      print('❌ Error deleting test user: $e');
      print('Stack trace: ${StackTrace.current}');
    }
  }
}
