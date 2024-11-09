import 'dart:ui';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_confirm.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MnemonicGen extends StatefulWidget {
  const MnemonicGen({super.key});

  @override
  State<MnemonicGen> createState() => MnemonicController();
}

class MnemonicController extends State<MnemonicGen> {
  String profileimageurl =
      "https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?size=338&ext=jpg&ga=GA1.1.735520172.1711238400&semt=ais";

  late String code;
  late String issuer;
  late String username;

  bool hasWrittenDown = false;

  bool isLoadingSignUp = false;

  late Mnemonic mnemonic;
  late String mnemonicString;
  TextEditingController mnemonicTextController = TextEditingController();

  void initState() {
    super.initState();
    generateMnemonic();
  }

  void processParameters(BuildContext context) {
    LoggerService logger = Get.find();
    logger.i("Process parameters for mnemonicgen called");
    final Map<String, String> parameters = GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;

    if (parameters.containsKey('code')) {
      code = parameters['code']!;
    }
    if (parameters.containsKey('issuer')) {
      issuer = parameters['issuer']!;
    }
    if (parameters.containsKey('username')) {
      username = parameters['username']!;
    }
  }

  // Constructs Mnemonic from random secure 256bits entropy with optional passphrase
  void generateMnemonic() {
    setState(() {
      mnemonic = Mnemonic.generate(
        Language.english,
        entropyLength: 256, // this will be a 24-word-long mnemonic
      );
      mnemonicString = mnemonic.sentence;
      mnemonicTextController.text = mnemonicString;
    });
  }

  void confirmMnemonic(String typedMnemonic) {
    LoggerService logger = Get.find();
    if (mnemonicString == typedMnemonic) {
      showOverlay(context, L10n.of(context)!.mnemonicCorrect, color: AppTheme.successColor);
      signUp();
    } else {
      //implement error throw
      showOverlay(context, L10n.of(context)!.mnemonicInCorrect, color: AppTheme.errorColor);
      logger.e("Mnemonic does not match");
      changeWrittenDown();
    }
  }

  void signUp() async {
    LoggerService logger = Get.find();
    setState(() {
      isLoadingSignUp = true;
    });
    try {
      //Auth().loginMatrix(context, "weltitob@proton.me", "Bear123Fliederbaum");
      logger.i("Making firebase auth now...");

      final userdata = UserData(
        backgroundImageUrl: profileimageurl,
        isPrivate: false,
        showFollowers: false,
        did: "did:example:Z9Y8X7W6V5U4T3S2R1PqPoNmLkJiHgF",
        displayName: username,
        bio: L10n.of(context)!.joinedRevolution,
        customToken: "customToken",
        username: username,
        profileImageUrl: profileimageurl,
        createdAt: timestamp,
        updatedAt: timestamp,
        isActive: true,
        dob: 0,
        nft_profile_id: '',
        nft_background_id: '',
      );

      VerificationCode verificationCode = VerificationCode(used: false, code: code, issuer: issuer, receiver: username);
      final UserData? currentuserwallet = await firebaseAuthentication(userdata, verificationCode);
      //izak: temporary bypass to the fact that we have no way of accessing user did due to temporary auth system.
      LocalStorage.instance.setString(userdata.did, Auth().currentUser!.uid);

      LocalProvider localeProvider = Provider.of<LocalProvider>(
        context,
        listen: false,
      );

      Locale deviceLocale = PlatformDispatcher.instance.locale; // or html.window.locale
      String langCode = deviceLocale.languageCode;
      localeProvider.setLocaleInDatabase(localeProvider.locale.languageCode ?? langCode, localeProvider.locale ?? deviceLocale);

      CountryProvider countryProvider = Provider.of<CountryProvider>(context, listen: false);
      countryProvider.setCountryInDatabase(countryProvider.getCountry() ?? "US");


      WidgetsBinding.instance.addPostFrameCallback(ThemeController.of(context).loadData);

      //Loading...


      logger.i("Navigating to homescreen now...");
      context.go(
        Uri(path: '/authhome/pinverification/reg_loading').toString(),
      );

    } on FirebaseException catch (e) {
      logger.e("Firebase Exception calling signUp in mnemonicgen.dart: $e");
      throw Exception("We currently have troubles reaching our servers which connect you with the blockchain. Please try again later.");
    } catch (e) {
      //implement error throw
      logger.e("Error trying to call signUp in mnemonicgen.dart: $e");
    }
    setState(() {
      isLoadingSignUp = false;
    });
  }

  Future<UserData?> firebaseAuthentication(UserData userData, VerificationCode code) async {
    LoggerService logger = Get.find();
    try {
      //blablabla
      logger.i("Creating firebase user now...");

      final UserData currentuserwallet = await Auth().createUserFake(
        mnemonic: mnemonicString,
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
