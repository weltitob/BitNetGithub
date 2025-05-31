import 'dart:typed_data';
import 'dart:ui';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/genseed.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/init_wallet.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_info.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/key_services/bip39_did_generator.dart';
import 'package:bitnet/backbone/helper/lightning_identity.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:bip39/bip39.dart' as bip39;
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
import 'package:bip39/bip39.dart' as bip39;
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
    super.initState();
    generateMnemonic();
  }

  void processParameters(BuildContext context) {
    LoggerService logger = Get.find();
    logger.i("Process parameters for mnemonicgen called");
    final Map<String, String> parameters =
        GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;

    if (parameters.containsKey('code')) {
      code = parameters['code']!;
    }
    if (parameters.containsKey('issuer')) {
      issuer = parameters['issuer']!;
    }
  }

  // Constructs Mnemonic from random secure 256bits entropy with optional passphrase
  void generateMnemonic() async {
    LoggerService logger = Get.find<LoggerService>();
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

      // Gene rate 256-bit entropy and create a mnemonic via api

      dynamic mnemonicString = await generateSeed();
      logger.i("Resp from gen Seed: $mnemonicString");

      setState(() {
        mnemonicTextController.text = mnemonicString;
      });

      // OLD: Multiple users one node approach - HDWallet-based DID generation
      // HDWallet hdWallet = await createUserWallet(mnemonicString);
      // String? masterPublicKey = await hdWallet.pubkey;
      // logger.i('Master Public Key: $masterPublicKey\n');
      // did = masterPublicKey;
      // logger.i("DID updated to: $did");
      
      // NEW: Lightning-native DID generation using actual Lightning node
      // Generate BIP39 mnemonic and validate
      if (!bip39.validateMnemonic(mnemonicString)) {
        throw Exception("Invalid BIP39 mnemonic generated");
      }

      logger.i("=== INITIALIZING LIGHTNING NODE ===");
      
      // Step 1: Initialize Lightning wallet with the generated mnemonic
      List<String> mnemonicWords = mnemonicString.split(' ');
      RestResponse initResponse = await initWallet(mnemonicWords);
      
      if (initResponse.statusCode != "200") {
        throw Exception("Failed to initialize Lightning wallet: ${initResponse.message}");
      }
      
      String adminMacaroon = initResponse.data['admin_macaroon'] ?? '';
      if (adminMacaroon.isEmpty) {
        throw Exception("No admin macaroon received from Lightning wallet initialization");
      }
      
      logger.i("✅ Lightning wallet initialized successfully");
      logger.i("Admin macaroon received: ${adminMacaroon.substring(0, 20)}...");
      
      // Step 2: Get Lightning node identity
      RestResponse nodeInfo = await getNodeInfo(adminMacaroon: adminMacaroon);
      
      if (nodeInfo.statusCode != "200") {
        throw Exception("Failed to get Lightning node info: ${nodeInfo.message}");
      }
      
      String lightningPubkey = nodeInfo.data['identity_pubkey'] ?? '';
      if (lightningPubkey.isEmpty) {
        throw Exception("No identity pubkey received from Lightning node");
      }
      
      logger.i("✅ Lightning node identity retrieved: ${lightningPubkey.substring(0, 20)}...");
      
      // Step 3: Generate recovery DID (used consistently for user identity)
      logger.i("=== GENERATING RECOVERY DID ===");
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonicString);
      logger.i("Recovery DID: $recoveryDid");
      
      // Use recovery DID as the primary user DID (for consistency and recovery)
      did = recoveryDid;
      logger.i("✅ Using recovery DID as primary DID: $did");
      
      // Step 4: Create user-node mapping
      logger.i("=== CREATING USER-NODE MAPPING ===");
      UserNodeMapping nodeMapping = UserNodeMapping(
        recoveryDid: recoveryDid,
        lightningPubkey: lightningPubkey, // Store Lightning identity for verification
        nodeId: LightningConfig.getDefaultNodeId(),
        caddyEndpoint: LightningConfig.caddyBaseUrl + '/' + LightningConfig.getDefaultNodeId(),
        adminMacaroon: adminMacaroon,
        createdAt: DateTime.now(),
        lastAccessed: DateTime.now(),
        status: 'active',
      );
      
      // Store the mapping for both recovery and authentication
      await NodeMappingService.storeUserNodeMapping(nodeMapping);
      logger.i("✅ User-node mapping stored successfully");

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
    setState(() {
      isLoadingSignUp = true;
    });
    final overlayController = Get.find<OverlayController>();
    LoggerService logger = Get.find();
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
    LoggerService logger = Get.find();
    setState(() {
      isLoadingSignUp = true;
    });

    try {
      await (hasFinishedGenWallet == true);

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
      // Use the did for the verification codes
      VerificationCode verificationCode = VerificationCode(
        used: false,
        code: code,
        issuer: issuer,
        receiver: userdata.did,
      );

      final UserData? currentuserwallet =
          await firebaseAuthentication(userdata, verificationCode);
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
      logger.e("Firebase Exception calling signUp in mnemonicgen.dart: $e");
      setState(() {
        isLoadingSignUp = false;
      });

      throw Exception(
        "We currently have troubles reaching our servers which connect you with the blockchain. Please try again later.",
      );
    } catch (e) {
      logger.e("Error trying to call signUp in mnemonicgen.dart: $e");

      setState(() {
        isLoadingSignUp = false;
      });
    }

    return false;
  }

  Future<UserData?> firebaseAuthentication(
      UserData userData, VerificationCode code) async {
    LoggerService logger = Get.find();
    try {
      logger.i("Creating firebase user now...");

      final UserData currentuserwallet = await Auth().createUser(
        user: userData,
        code: code,
      );

      return currentuserwallet;
    } on FirebaseException catch (e) {
      logger.e("Firebase Exception: $e");
      setState(() {
        throw Exception("Error: $e");
      });
    } catch (e) {
      throw Exception("Error: $e");
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
