import 'dart:async';
import 'dart:ui';

import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/genseed.dart';
import 'package:bitnet/backbone/cloudfunctions/litd/gen_litd_account.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/litd/accounts.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/auth/createaccount/createaccount_view.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAccount> createState() => CreateAccountController();
}

class CreateAccountController extends State<CreateAccount> {
  AssetEntity? image;
  MediaDatePair? pair;
  var bytes;

  late String code;
  late String issuer;
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  String? errorMessage = null;
  String? username = '';
  late String localpart;
  final TextEditingController controllerUsername = TextEditingController();
  bool isLoading = false;
  bool isDefaultPlatform =
      (PlatformInfos.isMobile || PlatformInfos.isWeb || PlatformInfos.isMacOS);
  void login() => context.go('/authhome/login');

  @override
  void initState() {
    super.initState();
  }

  void createAccountPressed() async {
    LoggerService logger = Get.find();
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    Get.put(SettingsController());

    localpart =
        controllerUsername.text.trim().toLowerCase().replaceAll(' ', '_');
    if (localpart.isEmpty) {
      setState(() {
        errorMessage = L10n.of(context)!.pleaseChooseAUsername;
      });
      throw Exception(L10n.of(context)!.pleaseChooseAUsername);
    }

    try {
      bool usernameExists = await Auth().doesUsernameExist(localpart);
      if (!usernameExists) {
        logger.i("Username is still available");
        // logger.i("Queryparameters that will be passed: $code, $issuer, $localpart");
        // // context.go("/persona)")



        //Update the username in our database for the user
        print('create account called');
        await generateAccount();
        ProfileController profileController = Get.put(ProfileController());
        profileController.userNameController.text = localpart;
        late StreamSubscription sub;
        sub = profileController.isUserLoading.listen((val) {
          if (val) {
            profileController.updateUsername();
            if (image != null) {
              profileController.handleProfileImageSelected(image!);
            }
            if (pair != null) {
              profileController.handleProfileNftSelected(pair!);
            }
            sub.cancel();
          }
        });

        context.go(
          Uri(path: '/').toString(),
        );

        //
        // context.go(
        //   Uri(path: '/authhome/pinverification/persona').toString(),
        // );

        // context.go(
        //   Uri(path: '/authhome/pinverification/persona', queryParameters: {
        //     'code': code,
        //     'issuer': issuer,
        //     'username': localpart,
        //   }).toString(),
        // );
      } else {
        logger.e("Username already exists.");
        errorMessage = L10n.of(context)!.usernameTaken;
      }
    } catch (e) {
      print("Error: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    GoRouterState state = GoRouterState.of(context);
    code = state.uri.queryParameters['code'] ?? '';
    issuer = state.uri.queryParameters['issuer'] ?? '';
    return CreateAccountView(
      controller: this,
    );
  }

  Future generateAccount() async {
    LoggerService logger = Get.find<LoggerService>();
    logger.i("Generating mnemonic using remote API...");

    try {
      // Generate 256-bit entropy and create a mnemonic via API
      dynamic seedResponse = await generateSeed();
      logger.i("Response from generateSeed API: $seedResponse");
      
      // Extract mnemonic from response
      List<String> mnemonicWords = [];
      if (seedResponse is Map<String, dynamic> && seedResponse.containsKey('cipher_seed_mnemonic')) {
        mnemonicWords = List<String>.from(seedResponse['cipher_seed_mnemonic']);
      } else {
        // Fallback to local generation if API fails
        logger.w("API seed generation failed, falling back to local generation");
        var mnemonic = await Mnemonic.generate(
          Language.english,
          passphrase: "test",
          entropyLength: 256,
        );
        mnemonicWords = mnemonic.sentence.split(' ');
      }
      
      String mnemonicString = mnemonicWords.join(' ');
      logger.i("Mnemonic generated: $mnemonicString");

      // Create wallet from mnemonic
      HDWallet hdWallet = await createUserWallet(mnemonicString);

      // Master public key (compressed)
      String? masterPublicKey = await hdWallet.pubkey;
      logger.i('Master Public Key: $masterPublicKey\n');
      String did = masterPublicKey;
      logger.i("DID updated to: $did");

      // Master private key
      String? masterPrivateKey = hdWallet.privkey;
      logger.i('Master Private Key: $masterPrivateKey\n');

      // Save the mnemonic and keys securely
      logger.i("Storing private data securely...");

      final privateData = PrivateData(did: masterPublicKey, mnemonic: mnemonicString);
      await storePrivateData(privateData);
      logger.i("Private data stored successfully.");
      
      // Generate litd account and get macaroon
      logger.i("Generating litd account and retrieving macaroon...");
      LitdAccountResponse? litdAccount = await callGenLitdAccount(did);
      
      if (litdAccount != null && litdAccount.macaroon != null) {
        logger.i("Successfully retrieved macaroon");
        
        // Store macaroon with account info
        await storeLitdAccountData(
          did, 
          litdAccount.account?.id ?? 'unknown', 
          litdAccount.macaroon!
        );
        logger.i("Stored litd account data with macaroon");
      } else {
        logger.w("Failed to retrieve macaroon, continuing without it");
      }
      
      logger.i("User registration and setup completed.");
      await signUp(did, code);
    } catch (e) {
      logger.e("Error in generateAccount: $e");
      // Handle errors (e.g., show user-friendly error message)
    }
  }

  Future<bool> signUp(String did, String code) async {
    LoggerService logger = Get.find();

    try {
      // Check if we have a litd account with macaroon for this user
      final litdAccountData = await getLitdAccountData(did);
      String? macaroonStr = litdAccountData?['macaroon'];
      String? accountId = litdAccountData?['accountId'];
      
      if (macaroonStr != null && accountId != null) {
        logger.i("Found stored litd account: $accountId with macaroon");
      } else {
        logger.w("No litd account found for user, will continue without lightning functionality");
      }

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
          createdAt: Timestamp.fromDate(DateTime.now()),
          updatedAt: Timestamp.fromDate(DateTime.now()),
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

      // If we have macaroon data, add it to the user authentication process
      if (macaroonStr != null && accountId != null) {
        // Here you could modify the authentication process to include macaroon verification
        // or store additional data in a separate collection
        logger.i("Including litd account data in user authentication");
        
        // Add code here to handle the macaroon during authentication if needed
        // For example, you might want to validate it with the lightning node
        // or store a reference to it in the user's document
      }

      final UserData? currentuserwallet =
          await firebaseAuthentication(userdata, verificationCode);
      LocalStorage.instance.setString(userdata.did, "most_recent_user");
      // // Temporary bypass due to temporary auth system
      // LocalStorage.instance.setString(userdata.did, Auth().currentUser!.uid);

      LocalProvider localeProvider = Provider.of<LocalProvider>(
        AppRouter.navigatorKey.currentContext!,
        listen: false,
      );

      Locale deviceLocale = PlatformDispatcher.instance.locale;
      String langCode = deviceLocale.languageCode;
      localeProvider.setLocaleInDatabase(
        localeProvider.locale.languageCode ?? langCode,
        localeProvider.locale ?? deviceLocale,
      );

      CountryProvider countryProvider = Provider.of<CountryProvider>(
          AppRouter.navigatorKey.currentContext!,
          listen: false);
      countryProvider
          .setCountryInDatabase(countryProvider.getCountry() ?? "US");
      try {
        final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
        tz.Location loc = tz.getLocation(currentTimeZone);
        TimezoneProvider timezoneProvider = Provider.of<TimezoneProvider>(
            AppRouter.navigatorKey.currentContext!,
            listen: false);
        timezoneProvider.setTimezoneInDatabase(loc);
      } catch (e) {
        logger.e("could not determine position: ${e}");
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ThemeController.of(AppRouter.navigatorKey.currentContext!).loadData(_);
      });

      logger.i("Navigating to homescreen now...");
      
      // After successful signup, we could also initialize the Lightning wallet if needed
      // This would involve using the macaroon to authenticate with the Lightning node
      if (macaroonStr != null && accountId != null) {
        logger.i("Lightning functionality is ready to use with account $accountId");
      }

      // context
      //     .go(Uri(path: '/authhome/pinverification/createaccount').toString());
      return true;
    } on FirebaseException catch (e) {
      logger.e("Firebase Exception calling signUp in mnemonicgen.dart: $e");

      throw Exception(
        "We currently have troubles reaching our servers which connect you with the blockchain. Please try again later.",
      );
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

  Future generateAccountFake(bool build) async {
    print('generate account called: $build');
    await Future.delayed(Duration(seconds: 5));
  }
}
