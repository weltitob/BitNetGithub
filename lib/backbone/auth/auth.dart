import 'dart:async';
import 'dart:math';

import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/auth/uniqueloginmessage.dart';
import 'package:bitnet/backbone/auth/updateuserscount.dart';
import 'package:bitnet/backbone/auth/verificationcodes.dart';
import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/cloudfunctions/auth/register_individual_node.dart';
import 'package:bitnet/backbone/cloudfunctions/loginion.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/verify_message.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/sign_lightning_message.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_info.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/sign_message.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/firebase/restresponse.dart';

import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:bitnet/models/keys/userchallenge.dart';
import 'package:bitnet/backbone/helper/key_services/wif_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;

/*
The class Auth manages user authentication and user wallet management using Firebase
Authentication and Cloud Firestore.
 */

class Auth {
  // Initialize FirebaseAuth instance with web safety
  final fbAuth.FirebaseAuth _firebaseAuth;
  
  // Safe constructor for web
  Auth() : _firebaseAuth = fbAuth.FirebaseAuth.instance {
    // No additional initialization needed
  }

  // currentUser getter returns the current authentical user with error handling
  fbAuth.User? get currentUser {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      print('Error accessing currentUser (safe to ignore in web preview): $e');
      return null;
    }
  }

  // authSateChanges getter returns a stream of authentication state changes
  Stream<fbAuth.User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /*
  The userWalletStreamForAuthChanges getter returns a stream of the authenticated user's wallet data.
  The authStateChanges stream is used as the source stream, and the asyncMap operator is used to map the stream of User objects to UserWallet objects.
   */
  Stream<UserData?> get userWalletStreamForAuthChanges =>
      authStateChanges.asyncMap<UserData?>((firebaseUser) async {
        if (firebaseUser == null) {
          return null;
        }
        final snapshot = await usersCollection.doc(firebaseUser.uid).get();
        if (!snapshot.exists) {
          return null;
        }
        final data = snapshot.data()!;
        final UserData user = UserData.fromMap(data);
        return user;
      });

  /*
  The userWalletStream getter returns a stream of the current user's wallet data.
  The snapshots() method is used to listen to changes in the document, and the map
  operator is used to transform the DocumentSnapshot to a UserWallet object.
   */
  Stream<UserData?> get userWalletStream => usersCollection
          .doc(_firebaseAuth.currentUser?.uid)
          .snapshots()
          .map<UserData?>((snapshot) {
        if (_firebaseAuth.currentUser?.uid == null) {
          return null;
        }
        if (!snapshot.exists) {
          print("Hier ist ein error aufgetreten (auth.dart)!");
          return null;
        }
        final data = snapshot.data()!;
        final UserData user = UserData.fromMap(data);
        return user;
      });

  /*
  The _createUserDocument method is used to update the user's wallet data in the Firestore database.
   */
  Future<void> updateUserData(UserData userData) async {
    await usersCollection.doc(userData.did).update(userData.toMap());
  }

  /*
  The signInWithEmailAndPassword method signs in the user with the given email address and password.
  The method returns a UserWallet object for the signed-in user.
   */
  Future<fbAuth.UserCredential?> signInWithToken({
    required String customToken,
  }) async {
    fbAuth.UserCredential user =
        await _firebaseAuth.signInWithCustomToken(customToken);
    final remoteConfigController =
        Get.put(RemoteConfigController(), permanent: true);
    await remoteConfigController.fetchRemoteConfigData();
    LocalStorage.instance
        .setString(Auth().currentUser!.uid, "most_recent_user");
    return user;
  }

  Future<fbAuth.UserCredential?> reAuthenticate({
    required String customToken,
  }) async {
    fbAuth.UserCredential user =
        await _firebaseAuth.signInWithCustomToken(customToken);

    return user;
  }

  Future<UserData> createUser({
    required UserData user,
    required VerificationCode code,
    String? mnemonicForRegistration, // Optional mnemonic for registration flow
  }) async {
    print("🟣 AUTH.CREATEUSER CALLED - ENTRY POINT");
    LoggerService logger = Get.find();
    logger.i("🟣 AUTH.CREATEUSER CALLED - ENTRY POINT");
    logger.i("🔥 ✅ AUTH.CREATEUSER FUNCTION CALLED");

    logger.i("🔥 === STARTING CREATE USER PROCESS ===");
    logger.i("🔥 User DID: ${user.did}");
    logger.i("🔥 User data: ${user.toMap()}");

    try {
      logger.i("🔥 Step 1: Creating user document in Firestore...");
      await usersCollection.doc(user.did).set(user.toMap());
      logger.i('✅ Successfully created wallet/user in database');
    } catch (e) {
      logger.e("❌ Failed to create user document: $e");
      throw Exception("Failed to create user document: $e");
    }

    // Declare variables outside try-catch blocks
    UserChallengeResponse? userChallengeResponse;
    String challengeId = '';
    String challengeData = '';
    PrivateData? privateData;

    try {
      logger.i("🔥 Step 2: Generating challenge...");
      logger.i("🔥 📤 === CALLING CREATE_CHALLENGE CLOUD FUNCTION ===");
      logger.i("🔥 📤 Request DID: '${user.did}'");
      logger.i("🔥 📤 Request Challenge Type: ${ChallengeType.default_registration}");
      logger.i("🔥 📤 About to call create_challenge()...");
      
      userChallengeResponse = await create_challenge(user.did, ChallengeType.default_registration);
      
      logger.i("🔥 📥 === CREATE_CHALLENGE CLOUD FUNCTION RESPONSE ===");
      logger.i("🔥 📥 Response received: ${userChallengeResponse != null ? 'NOT NULL' : 'NULL'}");

      if (userChallengeResponse == null) {
        logger.e("❌ Challenge creation returned null");
        throw Exception("Challenge creation failed: null response");
      }

      logger.i('🔥 📥 Challenge response type: ${userChallengeResponse.runtimeType}');
      logger.i('🔥 📥 Challenge response toString: $userChallengeResponse');
      logger.i('✅ Created challenge for user ${user.did}');

      challengeId = userChallengeResponse.challenge.challengeId;
      logger.i('🔥 📥 Challenge ID: $challengeId');

      challengeData = userChallengeResponse.challenge.title;
      logger.i('🔥 📥 Challenge Data: $challengeData');
    } catch (e, stackTrace) {
      logger.e("❌ Failed to create challenge: $e");
      logger.e("❌ Stack trace: $stackTrace");
      logger.e("❌ Error type: ${e.runtimeType}");
      if (e is StateError) {
        logger.e("❌ 🚨 THIS IS A STATE ERROR - likely the 'Bad state: No element' from create_challenge!");
      }
      throw Exception("Failed to create challenge: $e");
    }

    // Step 3: Get private data (skip retrieval during registration)
    if (mnemonicForRegistration != null) {
      logger.i("🔥 Step 3: Using provided mnemonic for registration...");
      logger.i("🔥 Registration mnemonic length: ${mnemonicForRegistration.split(' ').length} words");
      logger.i("🔥 ✅ Skipping getPrivateData() call during registration - using direct mnemonic");
      
      // Create temporary PrivateData object for registration
      privateData = PrivateData(did: user.did, mnemonic: mnemonicForRegistration);
    } else {
      logger.i("🔥 Step 3: Retrieving stored private data for login...");
      try {
        logger.i("🔥 Looking for DID: ${user.did}");
        privateData = await getPrivateData(user.did);
        logger.i('✅ Retrieved private data for user ${user.did}');
        logger.i('Private data mnemonic length: ${privateData.mnemonic.split(' ').length} words');
      } catch (e, stackTrace) {
        logger.e("❌ Failed to retrieve private data: $e");
        logger.e("❌ This is likely where the 'Bad state: No element' error occurs!");
        throw Exception("Failed to retrieve private data: $e");
      }
    }

    
    // Determine the working node ID from user's specific node mapping
    String workingNodeId;
    try {
      logger.i('🔥 Looking up user\'s specific node mapping...');
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(privateData.mnemonic);
      UserNodeMapping? nodeMapping = await NodeMappingService.getUserNodeMapping(recoveryDid);
      
      if (nodeMapping != null) {
        workingNodeId = nodeMapping.nodeId;
        logger.i('🔥 ✅ Found user\'s assigned node: $workingNodeId');
      } else {
        logger.e('🔥 ❌ No node mapping found for user - this violates one-user-one-node architecture');
        throw Exception("No exclusive Lightning node found for user. Each user must have their own dedicated node.");
      }
    } catch (e) {
      logger.e('🔥 ❌ Error retrieving node mapping: $e');
      throw Exception("Failed to find user's exclusive Lightning node: $e");
    }
    logger.i('🔥 Using working node ID: $workingNodeId');
    
    // Lightning-native authentication using user's specific node
    logger.i("🔥 === LIGHTNING-NATIVE AUTHENTICATION ===");
    
    String? lightningSignature;
    try {
      // Step 4: Sign the challenge with Lightning node using user's specific macaroon
      logger.i("🔥 Step 4: Signing challenge with Lightning node...");
      logger.i("🔥 📤 === CALLING SIGN_LIGHTNING_MESSAGE CLOUD FUNCTION ===");
      logger.i("🔥 📤 Challenge text to sign: '$challengeData'");
      logger.i("🔥 📤 Using node ID: $workingNodeId");
      logger.i("🔥 📤 User DID: ${user.did}");
      logger.i("🔥 📤 About to call signLightningMessage()...");
      
      lightningSignature = await signLightningMessage(
        challengeData,
        nodeId: workingNodeId,
        userDid: user.did, // Pass user DID to use their specific macaroon
      );
      
      logger.i("🔥 📥 === SIGN_LIGHTNING_MESSAGE CLOUD FUNCTION RESPONSE ===");
      logger.i("🔥 📥 Response received: ${lightningSignature != null ? 'NOT NULL' : 'NULL'}");
      
      if (lightningSignature == null) {
        logger.e("❌ Lightning signing returned null signature");
        throw Exception("Lightning signing failed: null signature returned");
      }
      
      logger.i("🔥 📥 Signature type: ${lightningSignature.runtimeType}");
      logger.i("🔥 📥 Signature length: ${lightningSignature.length}");
      logger.i("✅ Lightning signature created: ${lightningSignature.substring(0, 20)}...");
    } catch (e, stackTrace) {
      logger.e("❌ Lightning signing failed: $e");
      logger.e("❌ Stack trace: $stackTrace");
      logger.e("❌ Error type: ${e.runtimeType}");
      throw Exception("Lightning signing failed: $e");
    }
    
    dynamic customAuthToken;
    try {
      // Step 5: Verify with Lightning verification
      logger.i("🔥 Step 5: Verifying Lightning signature...");
      logger.i("🔥 📤 === CALLING VERIFY_MESSAGE CLOUD FUNCTION ===");
      logger.i("🔥 📤 Request DID: ${user.did}");
      logger.i("🔥 📤 Request Challenge ID: $challengeId");
      logger.i("🔥 📤 Request Signature: ${lightningSignature.substring(0, 20)}...");
      logger.i("🔥 📤 Request Node ID: $workingNodeId");
      logger.i("🔥 📤 About to call verifyMessage()...");
      
      customAuthToken = await verifyMessage(
        user.did, // Use DID for Lightning verification
        challengeId.toString(),
        lightningSignature,
        nodeId: workingNodeId, // Send node_id to backend
      );
      
      logger.i("🔥 📥 === VERIFY_MESSAGE CLOUD FUNCTION RESPONSE ===");
      logger.i("🔥 📥 Response received: ${customAuthToken != null ? 'NOT NULL' : 'NULL'}");
      logger.i("🔥 📥 Response type: ${customAuthToken.runtimeType}");
      logger.i("✅ Verify message response: ${customAuthToken.toString()}");
      
      if (customAuthToken == null) {
        logger.e("❌ Lightning verification returned null token");
        throw Exception("Lightning verification failed: null token returned");
      }
    } catch (e, stackTrace) {
      logger.e("❌ Lightning verification failed: $e");
      logger.e("❌ Stack trace: $stackTrace");
      logger.e("❌ Error type: ${e.runtimeType}");
      if (e is StateError) {
        logger.e("❌ 🚨 THIS IS A STATE ERROR - likely the 'Bad state: No element' from verifyMessage!");
      }
      throw Exception("Lightning verification failed: $e");
    }

    try {
      // Step 6: Register individual Lightning node (replaces genLitdAccount)
      logger.i("🔥 Step 6: Registering individual Lightning node...");
      
      // Get Lightning node info for registration
      String caddyEndpoint = LightningConfig.getCaddyEndpoint(workingNodeId);
      
      // Get the node mapping to access the admin macaroon
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(privateData.mnemonic);
      UserNodeMapping? nodeMapping = await NodeMappingService.getUserNodeMapping(recoveryDid);
      
      if (nodeMapping != null) {
        // Call getNodeInfo to get the Lightning pubkey
        RestResponse nodeInfoResponse = await getNodeInfo(
          nodeId: workingNodeId,
          adminMacaroon: nodeMapping.adminMacaroon,
        );
        
        if (nodeInfoResponse.statusCode == "200" && nodeInfoResponse.data != null) {
          String lightningPubkey = nodeInfoResponse.data['identity_pubkey'] ?? '';
          
          if (lightningPubkey.isNotEmpty) {
            // Register the individual Lightning node
            bool registrationSuccess = await registerIndividualLightningNode(
              did: user.did,
              nodeId: workingNodeId,
              adminMacaroon: nodeMapping.adminMacaroon,
              lightningPubkey: lightningPubkey,
              caddyEndpoint: caddyEndpoint,
            );
            
            if (registrationSuccess) {
              logger.i("✅ Individual Lightning node registered successfully");
            } else {
              logger.e("❌ Failed to register individual Lightning node");
              // Continue with authentication even if registration fails
            }
          } else {
            logger.e("❌ No Lightning pubkey found in node info");
          }
        } else {
          logger.e("❌ Failed to get node info for registration");
        }
      } else {
        logger.e("❌ No node mapping found for registration");
      }
    } catch (e) {
      logger.e("❌ Node registration failed: $e");
      // Don't throw here as this step is not critical for authentication
    }

    fbAuth.UserCredential? currentuser;
    try {
      logger.i("🔥 Step 7: Signing in with Firebase custom token...");
      logger.i("🔥 📤 === CALLING FIREBASE SIGN_IN_WITH_TOKEN ===");
      logger.i("🔥 📤 Custom token: ${customAuthToken.toString().substring(0, 50)}...");
      logger.i("🔥 📤 About to call signInWithToken()...");
      
      currentuser = await signInWithToken(customToken: customAuthToken);
      
      logger.i("🔥 📥 === FIREBASE SIGN_IN_WITH_TOKEN RESPONSE ===");
      logger.i("🔥 📥 Response received: ${currentuser != null ? 'NOT NULL' : 'NULL'}");
      
      if (currentuser == null) {
        logger.e("❌ Firebase sign-in returned null user");
        throw Exception("Firebase sign-in failed: null user returned");
      }
      
      logger.i("🔥 📥 User credential type: ${currentuser.runtimeType}");
      logger.i("🔥 📥 User UID: ${currentuser.user?.uid}");
      logger.i("✅ Firebase sign-in successful: ${currentuser.user?.uid}");
    } catch (e, stackTrace) {
      logger.e("❌ Firebase sign-in failed: $e");
      logger.e("❌ Stack trace: $stackTrace");
      logger.e("❌ Error type: ${e.runtimeType}");
      if (e is StateError) {
        logger.e("❌ 🚨 THIS IS A STATE ERROR - likely the 'Bad state: No element' from Firebase sign-in!");
      }
      throw Exception("Firebase sign-in failed: $e");
    }

    try {
      logger.i("🔥 Step 8: Fetching remote config...");
      final remoteConfigController = Get.put(RemoteConfigController(), permanent: true);
      await remoteConfigController.fetchRemoteConfigData();
      logger.i("✅ Remote config fetched successfully");
    } catch (e) {
      logger.e("❌ Failed to fetch remote config: $e");
      throw Exception("Failed to fetch remote config: $e");
    }

    try {
      logger.i("🔥 Step 9: Initializing user settings...");
      await settingsCollection.doc(currentuser?.user!.uid).set({
        "theme_mode": "system",
        "lang": "en",
        "primary_color": Colors.white.value,
        "selected_currency": "USD",
        "selected_card": "lightning",
        "hide_balance": false,
        "country": "US"
      });
      logger.i("✅ User settings initialized successfully");
    } catch (e) {
      logger.e("❌ Failed to initialize user settings: $e");
      throw Exception("Failed to initialize user settings: $e");
    }

    try {
      logger.i("🔥 Step 10: Generating verification codes...");
      await generateAndStoreVerificationCodes(
        numCodes: 4,
        codeLength: 5,
        issuer: user.did,
        codesCollection: codesCollection,
      );
      logger.i("✅ Verification codes generated successfully");
    } catch (e) {
      logger.e("❌ Failed to generate verification codes: $e");
      throw Exception("Failed to generate verification codes: $e");
    }

    try {
      logger.i("🔥 Step 11: Marking verification code as used...");
      await markVerificationCodeAsUsed(
        code: code,
        receiver: user.did,
        codesCollection: codesCollection,
      );
      logger.i("✅ Verification code marked as used");
    } catch (e) {
      logger.e("❌ Failed to mark verification code as used: $e");
      throw Exception("Failed to mark verification code as used: $e");
    }

    try {
      logger.i("🔥 Step 12: Adding user to users count...");
      addUserCount();
      logger.i("✅ User count updated");
    } catch (e) {
      logger.e("❌ Failed to update user count: $e");
      // Don't throw here as this is not critical
    }

    logger.i("🔥 === USER CREATION COMPLETED SUCCESSFULLY ===");
    logger.i("🔥 Returning user: ${user.did}");
    return user;
  }

  // signMessageWithMnemonicAuth(String mnemonic, String challenge) async {
  //   try {
  //     LoggerService logger = Get.find();
  //
  //     logger.i("Signing Message in auth.dart ...");
  //
  //     // Validate the mnemonic
  //     bool isValid = bip39.validateMnemonic(mnemonic);
  //     print('Mnemonic is valid: $isValid\n');
  //
  //     // Convert mnemonic to seed
  //     String seed = bip39.mnemonicToSeedHex(mnemonic);
  //     print('Seed derived from mnemonic:\n$seed\n');
  //
  //     Uint8List seedUnit = bip39.mnemonicToSeed(mnemonic);
  //
  //     HDWallet hdWallet = HDWallet.fromSeed(seedUnit,);
  //     // Master private key (WIF)
  //     String? masterPrivateKeyWIF = hdWallet.wif;
  //     print('Master Private Key (WIF): $masterPrivateKeyWIF\n');
  //
  //     // Master public key (compressed)
  //     String? masterPublicKey = hdWallet.pubKey;
  //     print('Master Public Key: $masterPublicKey\n');
  //
  //     String? masterPrivateKey = hdWallet.privKey;
  //     print('Master Private Key: $masterPrivateKey\n');
  //
  //     // Set the DID (Decentralized Identifier) as the public key hex
  //     String did = masterPublicKey!;
  //
  //     final message = generateChallenge(did);
  //
  //     logger.i("Message: $message");
  //
  //     logger.i("signMessage function called now...");
  //
  //     //sign the message locally
  //
  //     // final signedMessage = await signMessageFunction(
  //     //     did,
  //     //     privateIONKey, // Convert the private key object to a JSON string
  //     //     message);
  //
  //
  //
  //
  //     print("Message signed... $signedMessage");
  //     return signedMessage;
  //   } catch (e) {
  //     throw Exception("Error signing message: $e");
  //   }
  // }

  // DEPRECATED: genLitdAccount is no longer used in one-user-one-node architecture
  // Use registerIndividualLightningNode() instead

  String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }

  Future<void> signIn(ChallengeType challengeType, PrivateData privateData,
      String signatureHex, BuildContext context) async {
    // Sign a message using the user's private key (you can use the signMessage function provided earlier)
    // You may need to create a Dart version of the signMessage function

    final logger = Get.find<LoggerService>();
    logger.i("Signing in user...");

    // SIMPLIFIED: Use mnemonic-based DID generation consistently
    final String did = RecoveryIdentity.generateRecoveryDid(privateData.mnemonic);
    logger.i("Generated DID from mnemonic: $did");

    try {
      //showLoadingScreen
      //context.go('/ionloading');

      // final String customToken = await fakeLoginION(
      //   randomstring,
      // );

      // final String customToken = await loginION(
      //   did.toString(),
      //   signedAuthMessage.toString(),
      // );

      //create challenge for

      logger.i("Generating challenge...");
      UserChallengeResponse? userChallengeResponse =
          await create_challenge(did, challengeType);

      String challengeId = userChallengeResponse!.challenge.challengeId;

      // Verify the signature with the server
      dynamic customAuthToken = await verifyMessage(
        did.toString(),
        challengeId.toString(),
        signatureHex.toString(),
      );

      //now check if user has an individual node or uses the old LITD account system
      try {
        final userId = did.toString();
        
        // Generate recovery DID from the mnemonic for individual node users
        final recoveryDid = RecoveryIdentity.generateRecoveryDid(privateData.mnemonic);
        
        // First check if user has an individual node mapping using recovery DID
        final userNodeMapping = await NodeMappingService.getUserNodeMapping(recoveryDid);
            
        if (userNodeMapping != null) {
          // User has an individual node - skip LITD account retrieval
          logger.i("User has individual node mapping - skipping LITD account retrieval");
          logger.i("Node ID: ${userNodeMapping.nodeId}");
          logger.i("Lightning Pubkey: ${userNodeMapping.shortLightningPubkey}");
        } else {
          // Fall back to old LITD account system for legacy users
          logger.i("Checking for legacy LITD account...");
          final docSnapshot = await FirebaseFirestore.instance
              .collection("users_lnd_node")
              .doc(userId)
              .get();

          if (docSnapshot.exists) {
            final data = docSnapshot.data();
            if (data == null) {
              logger.e("User document is empty");
              throw Exception("User document is empty");
            }

            // Extract the lnd_account information
            final lndAccount = data['lnd_account'];
            if (lndAccount == null) {
              logger.e("LITD account data not found in user document");
              throw Exception("LITD account data not found");
            }

            final accountId = lndAccount['accountid'];
            final macaroon = lndAccount['macaroon'];

            if (accountId == null || macaroon == null) {
              logger.e("Missing accountId or macaroon in LITD account data");
              throw Exception("Incomplete LITD account data");
            }

            // Now that we have the data, call storeLitdAccountData
            await storeLitdAccountData(userId, accountId, macaroon);
            logger.i("Successfully retrieved and stored LITD account data.");
          } else {
            logger.i("No LITD account found - user likely has individual node");
          }
        }
      } catch (e) {
        logger.e("Error handling node/LITD account data: $e");
        // Don't throw here - allow sign in to continue for users with individual nodes
        logger.i("Continuing with sign in despite node data error...");
      }

      logger.i("Verify message response: ${customAuthToken.toString()}");
      final currentuser = await signInWithToken(customToken: customAuthToken);

      final remoteConfigController =
          Get.put(RemoteConfigController(), permanent: true);
      await remoteConfigController.fetchRemoteConfigData();

      if (currentuser == null) {
        // Remove the loading screen
        context.pop();
        throw Exception("User couldnt be signed in with custom Token!");
      } else {
        await storePrivateData(privateData);

        // Begin user registration process
        // final registrationController = Get.find<RegistrationController>();
        // logger.i("AWS ECS: Registering and setting up user...");

        // registrationController.isLoading.value = true;
        //
        // final String shortDid = did.substring(0, 12);
        // final registrationResponse = await registrationController.loginAndStartEcs(shortDid);
        //
        // registrationController.isLoading.value = false;

        WidgetsBinding.instance
            .addPostFrameCallback(ThemeController.of(context).loadData);
        //if successfull push back to homescreen
        context.go("/");
      }
    } catch (e) {
      // Also pop the loading screen when an error occurs
      Navigator.pop(context);
      throw Exception("signIn user failed $e");
    }
  }

  //-----------------------------FIREBASE HELPERS---------------------------

  Future<String> getUserDID(String username) async {
    QuerySnapshot snapshot =
        await usersCollection.where('username', isEqualTo: username).get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No user found with the provided username');
    } else {
      // assuming that 'did' is the field name that holds the DID in the document
      return snapshot.docs.first.get('did');
    }
  }

  Future<String> getUserUsername(String did) async {
    QuerySnapshot snapshot =
        await usersCollection.where('did', isEqualTo: did).get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No user found with the provided username');
    } else {
      // assuming that 'username' is the field name that holds the DID in the document
      return snapshot.docs.first.get('username');
    }
  }

  Future<bool> doesUsernameExist(String username) async {
    final QuerySnapshot snapshot =
        await usersCollection.where('username', isEqualTo: username).get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> signOut() async {
    LocalStorage.instance.setString("", "most_recent_user");
    await _firebaseAuth.signOut();
  }

  //-----------------------------FIREBASE HELPERS---------------------------
}

extension on String {
  static final RegExp _phoneRegex =
      RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  static final RegExp _emailRegex = RegExp(r'(.+)@(.+)\.(.+)');
  bool get isEmail => _emailRegex.hasMatch(this);
  bool get isPhoneNumber => _phoneRegex.hasMatch(this);
}
