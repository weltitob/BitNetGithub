import 'dart:typed_data';
import 'dart:ui';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
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

  late Mnemonic mnemonic;
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

      var mnemonic = await Mnemonic.generate(
        Language.english,
        passphrase: "test",
        entropyLength: 256,
      );

      print("Mnemonic: $mnemonic");
      print("Mnemonic sentence: ${mnemonic.sentence}");

      mnemonicString = mnemonic.sentence;

      // Gene rate 256-bit entropy and create a mnemonic via api

      // dynamic mnemonicString = await generateSeed();
      logger.i("Resp from gen Seed: $mnemonicString");

      setState(() {
        mnemonicTextController.text = mnemonicString;
      });

      HDWallet hdWallet = await createUserWallet(mnemonicString);

      // Master public key (compressed)
      String? masterPublicKey = await hdWallet.pubkey;
      logger.i('Master Public Key: $masterPublicKey\n');
      did = masterPublicKey;
      logger.i("DID updated to: $did");
      // Set the DID (Decentralized Identifier) as the public key hex

      setState(() {
        logger.i("HD Wallet created successfully.");
        hasFinishedGenWallet = true;
      });

      //Master private key
      String? masterPrivateKey = await hdWallet.privkey;
      logger.i('Master Private Key: $masterPrivateKey\n');

      // Save the mnemonic and keys securely
      logger.i("Storing private data securely...");
      final privateData =
          PrivateData(did: masterPublicKey, mnemonic: mnemonicString);

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
