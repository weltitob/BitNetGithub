import 'dart:typed_data';
import 'dart:ui';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/genseed.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/init_wallet.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_info.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
// BIP39 import removed - we use aezeed format from LND instead
import 'package:bitnet/backbone/helper/location.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_confirm.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// BIP39 import removed - we use aezeed format from LND instead
import 'package:timezone/timezone.dart' as tz;

// Removed unnecessary empty import

class MnemonicGen extends StatefulWidget {
  const MnemonicGen({super.key});

  @override
  State<MnemonicGen> createState() => MnemonicController();
}

class MnemonicController extends State<MnemonicGen> {
  late String code;
  late String issuer;
  late String did;

  bool hasWrittenDown = false;
  bool isLoadingSignUp = false;
  bool hasFinishedGenWallet = false;

  late String mnemonicString;
  TextEditingController mnemonicTextController = TextEditingController();

  @override
  void initState() {
    print("🔵 INIT STATE CALLED - VERY FIRST ENTRY POINT");
    super.initState();
    generateMnemonic();
  }

  void processParameters(BuildContext context) {
    print("🟠 PROCESS PARAMETERS CALLED - ENTRY POINT");
    LoggerService logger = Get.find();
    logger.i("🟠 PROCESS PARAMETERS CALLED - ENTRY POINT");
    logger.i("Process parameters for mnemonicgen called");
    final Map<String, String> parameters =
        GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;

    logger.i("🔍 URL Query Parameters: $parameters");

    if (parameters.containsKey('code')) {
      code = parameters['code']!;
      logger.i("✅ Code found in URL: $code");
    } else {
      // Provide default verification code for registration
      code = 'DEFAULT_REG_CODE';
      logger.w("⚠️ No 'code' parameter in URL, using default: $code");
    }

    if (parameters.containsKey('issuer')) {
      issuer = parameters['issuer']!;
      logger.i("✅ Issuer found in URL: $issuer");
    } else {
      // Provide default issuer for registration
      issuer = 'registration_flow';
      logger.w("⚠️ No 'issuer' parameter in URL, using default: $issuer");
    }
  }

  // Constructs Mnemonic from random secure 256bits entropy with optional passphrase
  void generateMnemonic() async {
    print("🔴 GENERATE MNEMONIC CALLED - ENTRY POINT");
    LoggerService logger = Get.find<LoggerService>();
    logger.i("🔴 GENERATE MNEMONIC CALLED - ENTRY POINT");
    logger.i("Generating mnemonic...");

    try {
      // Use the fixed mnemonic to mirror the Python code
      // Generate a 24-word mnemonic
      // String mnemonic = "runway promote stool mystery quiz birth blue domain layer enter discover open decade material clown step cloud destroy endless neck firm floor wisdom spell";
      // String mnemonic = bip39.generateMnemonic(strength: 256);

      // print("Mnemonic: $mnemonic");
      // print("Mnemonic sentence: ${mnemonic.sentence}");
      //
      // mnemonicString = mnemonic.sentence;

      // Generate 256-bit entropy and create a mnemonic via api

      RestResponse seedResponse = await generateSeed();
      logger.i("Resp from gen Seed: $seedResponse");

      if (seedResponse.statusCode != "200") {
        throw Exception("Failed to generate seed: ${seedResponse.message}");
      }

      // Extract cipher_seed_mnemonic from response data
      List<dynamic> mnemonicWordsList =
          seedResponse.data['cipher_seed_mnemonic'];
      mnemonicString = mnemonicWordsList.join(' ');
      logger.i("Extracted mnemonic: $mnemonicString");

      setState(() {
        mnemonicTextController.text = mnemonicString;
      });

      // OLD: Multiple users one node approach - HDWallet-based DID generation
      // HDWallet hdWallet = await createUserWallet(mnemonicString);
      // String? masterPublicKey = await hdWallet.pubkey;
      // logger.i('Master Public Key: $masterPublicKey\n');
      // did = masterPublicKey;
      // logger.i("DID updated to: $did");

      logger.i("=== STRICT ONE-USER-ONE-NODE ASSIGNMENT ===");

      // Step 1: Generate recovery DID from aezeed mnemonic (no BIP39 validation needed)
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonicString);
      logger.i("Recovery DID: $recoveryDid");

      // Step 2: Assign a completely unused Lightning node (strict one-to-one)
      String assignedNodeId =
          await NodeMappingService.assignUnusedNode(recoveryDid);
      if (assignedNodeId.isEmpty) {
        throw Exception(
            "No available Lightning nodes for assignment - all nodes are occupied");
      }
      logger.i("✅ Assigned unused node: $assignedNodeId");

      // Step 3: Initialize Lightning wallet with aezeed mnemonic on assigned node
      List<String> mnemonicWords = mnemonicString.split(' ');
      RestResponse initResponse =
          await initWallet(mnemonicWords, nodeId: assignedNodeId);

      if (initResponse.statusCode != "200") {
        throw Exception(
            "Failed to initialize Lightning wallet: ${initResponse.message}");
      }

      String adminMacaroon = initResponse.data['admin_macaroon'] ?? '';
      if (adminMacaroon.isEmpty) {
        throw Exception(
            "No admin macaroon received from Lightning wallet initialization");
      }

      logger.i("✅ Lightning wallet initialized on node $assignedNodeId");

      // Step 4: Get Lightning node identity from assigned node
      RestResponse nodeInfo = await getNodeInfo(
          adminMacaroon: adminMacaroon, nodeId: assignedNodeId);

      if (nodeInfo.statusCode != "200") {
        throw Exception(
            "Failed to get Lightning node info: ${nodeInfo.message}");
      }

      String lightningPubkey = nodeInfo.data['identity_pubkey'] ?? '';
      if (lightningPubkey.isEmpty) {
        throw Exception("No identity pubkey received from Lightning node");
      }

      logger.i(
          "✅ Lightning node identity retrieved: ${lightningPubkey.substring(0, 20)}...");

      // Step 5: Lock the node exclusively for this user (ONE USER ONLY)
      UserNodeMapping nodeMapping = UserNodeMapping(
        recoveryDid: recoveryDid,
        lightningPubkey: lightningPubkey,
        nodeId: assignedNodeId,
        caddyEndpoint: LightningConfig.caddyBaseUrl + '/' + assignedNodeId,
        adminMacaroon: adminMacaroon,
        createdAt: DateTime.now(),
        lastAccessed: DateTime.now(),
        status:
            'occupied', // Mark as occupied - cannot be assigned to anyone else
      );

      // Store the exclusive mapping - this node is now LOCKED to this user
      await NodeMappingService.storeUserNodeMapping(nodeMapping);
      logger.i(
          "✅ Node $assignedNodeId is now exclusively locked to user $recoveryDid");

      // Use recovery DID as the primary user DID
      did = recoveryDid;

      setState(() {
        logger.i("Lightning wallet and identity created successfully.");
        hasFinishedGenWallet = true;
      });

      // Step 5: Save the mnemonic and Lightning identity securely
      logger.i("Storing private data securely...");
      final privateData = PrivateData(did: did, mnemonic: mnemonicString);

      await storePrivateData(privateData);
      logger.i("Private data stored successfully.");
      logger.i("User registration and setup completed.");
    } catch (e) {
      logger.e("Error in generateMnemonic: $e");
      // Handle errors (e.g., show user-friendly error message)
    }
  }

  void confirmMnemonic(String typedMnemonic) async {
    print("🟠 CONFIRM MNEMONIC CALLED - ENTRY POINT");
    setState(() {
      isLoadingSignUp = true;
    });
    final overlayController = Get.find<OverlayController>();
    LoggerService logger = Get.find();
    logger.i("🟠 CONFIRM MNEMONIC CALLED - ENTRY POINT");
    logger.i("Confirming mnemonic...");
    logger.i("Typed Mnemonic: $typedMnemonic Mnemonic: $mnemonicString");
    if (mnemonicString == typedMnemonic) {
      overlayController.showOverlay(L10n.of(context)!.mnemonicCorrect,
          color: AppTheme.successColor);
      bool signUpBool = await signUp();
    } else {
      // Implement error throw
      overlayController.showOverlay(L10n.of(context)!.mnemonicInCorrect,
          color: AppTheme.errorColor);
      logger.e("Mnemonic does not match");
      changeWrittenDown();
    }
    setState(() {
      isLoadingSignUp = false;
    });
  }

  Future<bool> signUp() async {
    print("🟢 SIGNUP METHOD CALLED - ENTRY POINT");
    LoggerService logger = Get.find();
    logger.i("🟢 SIGNUP METHOD CALLED - ENTRY POINT");

    setState(() {
      isLoadingSignUp = true;
    });

    try {
      // Wait for wallet generation to complete (if not already done)
      logger.i("🔥 Checking wallet generation status...");
      logger.i("🔥 hasFinishedGenWallet: $hasFinishedGenWallet");

      if (!hasFinishedGenWallet) {
        logger.i("🔥 Waiting for wallet generation to complete...");
        while (!hasFinishedGenWallet) {
          await Future.delayed(Duration(milliseconds: 100));
        }
      }

      logger.i("🔥 Wallet generation confirmed complete");
      logger.i("🔥 Creating UserData object...");
      logger.i("🔥 DID: $did");
      logger.i("🔥 Code: $code");
      logger.i("🔥 Issuer: $issuer");

      final userdata = UserData(
          backgroundImageUrl: '',
          isPrivate: false,
          showFollowers: false,
          did: did,
          displayName: did,
          bio: L10n.of(context)!.joinedRevolution,
          customToken: "customToken",
          username: did,
          profileImageUrl: '',
          createdAt: timestamp,
          updatedAt: timestamp,
          isActive: true,
          dob: 0,
          nft_profile_id: '',
          nft_background_id: '',
          setupQrCodeRecovery: false,
          setupWordRecovery: false);

      logger.i("🔥 UserData created successfully");
      logger.i("🔥 UserData DID: ${userdata.did}");

      // Use the did for the verification codes
      logger.i("🔥 Creating VerificationCode object...");
      VerificationCode verificationCode = VerificationCode(
        used: false,
        code: code,
        issuer: issuer,
        receiver: userdata.did,
      );

      logger.i("🔥 VerificationCode created successfully");
      logger.i("🔥 Verification Code: ${verificationCode.code}");

      logger.i("🔥 === CALLING FIREBASE AUTHENTICATION ===");
      logger.i("🔥 UserData DID: ${userdata.did}");
      logger.i("🔥 Verification Code: ${verificationCode.code}");
      logger.i("🔥 Verification Code Receiver: ${verificationCode.receiver}");
      logger.i("🔥 About to call firebaseAuthentication()...");

      UserData? currentuserwallet;
      try {
        currentuserwallet =
            await firebaseAuthentication(userdata, verificationCode);
        logger.i("🔥 ✅ Firebase authentication completed successfully");
        logger.i("🔥 Returned user: ${currentuserwallet?.did}");
      } catch (e, stackTrace) {
        logger.e("🔥 ❌ Firebase authentication failed with error: $e");
        logger.e("🔥 ❌ Error type: ${e.runtimeType}");
        logger.e("🔥 ❌ Stack trace: $stackTrace");
        if (e.toString().contains("Bad state: No element")) {
          logger.e("🔥 ❌ This is the 'Bad state: No element' error!");
          logger.e(
              "🔥 ❌ Error likely in Auth().createUser() -> getPrivateData()");
        }
        rethrow;
      }
      LocalStorage.instance.setString(userdata.did, "most_recent_user");
      // // Temporary bypass due to temporary auth system
      // LocalStorage.instance.setString(userdata.did, Auth().currentUser!.uid);

      LocalProvider localeProvider = Provider.of<LocalProvider>(
        context,
        listen: false,
      );

      Locale deviceLocale = PlatformDispatcher.instance.locale;
      String langCode = deviceLocale.languageCode;
      localeProvider.setLocaleInDatabase(
        localeProvider.locale.languageCode ?? langCode,
        localeProvider.locale ?? deviceLocale,
      );

      CountryProvider countryProvider =
          Provider.of<CountryProvider>(context, listen: false);
      countryProvider
          .setCountryInDatabase(countryProvider.getCountry() ?? "US");
      try {
        final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
        tz.Location loc = tz.getLocation(currentTimeZone);
        TimezoneProvider timezoneProvider =
            Provider.of<TimezoneProvider>(context, listen: false);
        timezoneProvider.setTimezoneInDatabase(loc);
      } catch (e) {
        logger.e("could not determine position: ${e}");
      }
      WidgetsBinding.instance
          .addPostFrameCallback(ThemeController.of(context).loadData);

      logger.i("Navigating to homescreen now...");

      context
          .go(Uri(path: '/authhome/pinverification/createaccount').toString());
      return true;
    } on FirebaseException catch (e) {
      logger.e("🔥 ❌ Firebase Exception in signUp method: $e");
      logger.e("🔥 ❌ Firebase Exception code: ${e.code}");
      logger.e("🔥 ❌ Firebase Exception message: ${e.message}");
      setState(() {
        isLoadingSignUp = false;
      });

      throw Exception(
        "We currently have troubles reaching our servers which connect you with the blockchain. Please try again later.",
      );
    } catch (e, stackTrace) {
      logger.e("🔥 ❌ CRITICAL ERROR in signUp method: $e");
      logger.e("🔥 ❌ Error type: ${e.runtimeType}");
      logger.e("🔥 ❌ Error toString: ${e.toString()}");
      logger.e("🔥 ❌ Stack trace: $stackTrace");
      if (e is StateError) {
        logger.e(
            "🔥 ❌ This is a StateError - likely the 'Bad state: No element' issue!");
        logger.e("🔥 ❌ StateError message: ${e.message}");
      }

      setState(() {
        isLoadingSignUp = false;
      });
    }

    return false;
  }

  Future<UserData?> firebaseAuthentication(
      UserData userData, VerificationCode code) async {
    print("🟡 FIREBASE_AUTHENTICATION CALLED - ENTRY POINT");
    LoggerService logger = Get.find();
    logger.i("🟡 FIREBASE_AUTHENTICATION CALLED - ENTRY POINT");
    logger.i("🔥 ✅ FIREBASE_AUTHENTICATION FUNCTION CALLED");

    try {
      logger.i("🔥 === INSIDE FIREBASE AUTHENTICATION METHOD ===");
      logger.i("🔥 Received UserData DID: ${userData.did}");
      logger.i("🔥 Received Verification Code: ${code.code}");
      logger.i("🔥 Code Receiver: ${code.receiver}");
      logger.i("🔥 Code Issuer: ${code.issuer}");
      logger.i("🔥 About to call Auth().createUser()...");

      final UserData currentuserwallet = await Auth().createUser(
        user: userData,
        code: code,
        mnemonicForRegistration:
            mnemonicString, // Pass mnemonic to skip getPrivateData()
      );

      logger.i("🔥 Auth().createUser() completed successfully");
      logger.i("🔥 Returning user: ${currentuserwallet.did}");
      return currentuserwallet;
    } on FirebaseException catch (e) {
      logger.e("🔥 ❌ Firebase Exception in firebaseAuthentication: $e");
      logger.e("🔥 ❌ Firebase Exception code: ${e.code}");
      logger.e("🔥 ❌ Firebase Exception message: ${e.message}");
      setState(() {
        throw Exception("Firebase Error: $e");
      });
    } catch (e) {
      logger.e("🔥 ❌ General Exception in firebaseAuthentication: $e");
      logger.e("🔥 ❌ Exception type: ${e.runtimeType}");
      logger.e("🔥 ❌ Exception toString: ${e.toString()}");
      throw Exception("Authentication Error: $e");
    }
    return null;
  }

  void changeWrittenDown() {
    setState(() {
      hasWrittenDown = !hasWrittenDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    processParameters(context);

    if (hasWrittenDown) {
      return MnemonicGenConfirm(
        mnemonicController: this,
      );
    } else {
      return MnemonicGenScreen(mnemonicController: this);
    }
  }
}
