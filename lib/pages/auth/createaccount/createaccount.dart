import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/genseed.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/init_wallet.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/unlock_wallet.dart';
import 'package:bitnet/backbone/cloudfunctions/litd/gen_litd_account.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/key_services/bip39_did_generator.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/country_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
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

  /// Store node data with macaroon for the user
  Future<void> storeNodeData(String did, String nodeId, String adminMacaroon, String nodeHost) async {
    LoggerService logger = Get.find<LoggerService>();
    
    try {
      // Store node information in the user's document
      Map<String, dynamic> nodeData = {
        'node_id': nodeId,
        'admin_macaroon': adminMacaroon,
        'node_host': nodeHost,
        'caddy_endpoint': 'http://$nodeHost/$nodeId',
        'created_at': DateTime.now().toIso8601String(),
        'status': 'initialized'
      };
      
      await usersCollection
          .doc(did)
          .collection('node_data')
          .doc(nodeId)
          .set(nodeData);
          
      logger.i("Node data stored successfully for user $did on node $nodeId");
    } catch (e) {
      logger.e("Error storing node data: $e");
      throw e;
    }
  }

  /// Retrieve node data for a user
  Future<Map<String, dynamic>?> getNodeData(String did, String nodeId) async {
    LoggerService logger = Get.find<LoggerService>();
    
    try {
      DocumentSnapshot doc = await usersCollection
          .doc(did)
          .collection('node_data')
          .doc(nodeId)
          .get();
          
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      logger.e("Error retrieving node data: $e");
      return null;
    }
  }

  Future generateAccount() async {
    LoggerService logger = Get.find<LoggerService>();
    logger.i("Generating BIP39 mnemonic for one user one node approach...");

    try {
      // NEW APPROACH: Use Lightning node's native genseed endpoint
      logger.i("=== STEP 1: GENERATING SEED VIA LIGHTNING NODE ===");
      RestResponse seedResponse = await generateSeed(nodeId: 'node4');
      
      if (seedResponse.statusCode != "200") {
        throw Exception("Failed to generate seed: ${seedResponse.message}");
      }
      
      // Extract seed data from Lightning node response
      Map<String, dynamic> seedData = seedResponse.data;
      List<dynamic> cipherSeedMnemonic = seedData['cipher_seed_mnemonic'] ?? [];
      String encipheredSeed = seedData['enciphered_seed'] ?? '';
      
      logger.i("Lightning node generated seed successfully:");
      logger.i("- Cipher seed mnemonic: ${cipherSeedMnemonic.length} words");
      logger.i("- Enciphered seed: ${encipheredSeed.substring(0, 20)}... (truncated)");
      
      // Convert to string list for our internal use
      List<String> mnemonicWords = cipherSeedMnemonic.cast<String>();
      String mnemonicString = mnemonicWords.join(' ');
      
      logger.i("=== STEP 2: CREATING DID FROM LIGHTNING SEED ===");
      // Create deterministic DID from Lightning's mnemonic
      // This must be derivable from mnemonic alone for recovery/login
      String did = Bip39DidGenerator.generateDidFromLightningMnemonic(mnemonicString);
      logger.i("Generated deterministic DID from Lightning seed: $did");

      // Save the Lightning-generated mnemonic securely
      logger.i("Storing Lightning seed data securely...");
      final privateData = PrivateData(did: did, mnemonic: mnemonicString);
      await storePrivateData(privateData);
      logger.i("Private data stored successfully.");

      // Initialize individual Lightning node via Caddy routing (MVP)
      logger.i("=== STEP 3: INITIALIZING WALLET WITH LIGHTNING SEED ===");
      
      // Use the enciphered_seed for macaroon root key instead of trying to convert aezeed to BIP39
      // Take first 32 bytes of the base64 decoded enciphered_seed
      Uint8List encipheredBytes = base64Decode(encipheredSeed);
      Uint8List macaroonRootKeyBytes = encipheredBytes.length >= 32 
          ? encipheredBytes.sublist(0, 32) 
          : Uint8List.fromList([...encipheredBytes, ...List.filled(32 - encipheredBytes.length, 0)]);
      String macaroonRootKeyHex = hex.encode(macaroonRootKeyBytes);
      
      logger.i("Using enciphered_seed for macaroon root key derivation");
      logger.i("Macaroon root key hex: $macaroonRootKeyHex");
      
      logger.i("Using Lightning node's native cipher seed mnemonic for init_wallet");
      
      try {
        RestResponse initResponse = await initWallet(mnemonicWords, macaroonRootKeyHex, nodeId: 'node4');
        
        if (initResponse.statusCode == "200") {
          logger.i("Lightning node initialized successfully");
          
          // Extract admin macaroon from response
          String adminMacaroon = initResponse.data['admin_macaroon'] ?? '';
          if (adminMacaroon.isNotEmpty) {
            logger.i("Successfully retrieved admin macaroon");
            
            // Store node data with macaroon for user
            await storeNodeData(did, 'node4', adminMacaroon, '[2a02:8070:880:1e60:da3a:ddff:fee8:5b94]');
            logger.i("Stored node data with admin macaroon");
          }
        } else {
          logger.e("Failed to initialize Lightning node: ${initResponse.message}");
        }
      } catch (e) {
        logger.e("Error initializing Lightning node: $e");
      }

      logger.i("User registration and setup completed with individual Lightning node.");
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
