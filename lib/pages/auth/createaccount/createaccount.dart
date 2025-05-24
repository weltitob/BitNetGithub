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
import 'package:bitnet/backbone/helper/lightning_identity.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_info.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_status.dart';
import 'package:bitnet/backbone/services/lightning_node_finder.dart';
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
        
        try {
          await generateAccount();
          logger.i("✅ Account generation completed successfully");
        } catch (e) {
          logger.e("❌ Account generation failed: $e");
          setState(() {
            isLoading = false;
            errorMessage = "Account creation failed. Please try again.";
          });
          return; // Exit early, don't proceed with ProfileController
        }
        
        // Verify authentication completed successfully before proceeding
        if (Auth().currentUser == null) {
          logger.e("❌ Authentication verification failed - currentUser is null");
          setState(() {
            isLoading = false;
            errorMessage = "Authentication failed. Please try again.";
          });
          return; // Exit early, don't proceed with ProfileController
        }
        
        logger.i("✅ Authentication verified, proceeding with profile setup");
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
      // NEW APPROACH: Find working Lightning node and use its native genseed endpoint
      logger.i("=== STEP 1: FINDING WORKING LIGHTNING NODE ===");
      
      String? workingNodeId = await LightningNodeFinder.findWorkingNode(
        timeoutSeconds: 5,
        includeDefaultNode: true,
      );
      
      if (workingNodeId == null) {
        throw Exception("No Lightning nodes are available. Please check server status.");
      }
      
      logger.i("✅ Using working node: $workingNodeId");
      
      logger.i("=== STEP 2: GENERATING SEED VIA LIGHTNING NODE ===");
      RestResponse seedResponse = await generateSeed(nodeId: workingNodeId);
      
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
      
      logger.i("=== STEP 3: INITIALIZING WALLET WITH LIGHTNING SEED ===");
      
      logger.i("Using Lightning node's native cipher seed mnemonic for init_wallet");
      
      String adminMacaroon = '';
      try {
        RestResponse initResponse = await initWallet(mnemonicWords, nodeId: workingNodeId);
        
        if (initResponse.statusCode == "200") {
          logger.i("Lightning node initialized successfully");
          
          // Extract admin macaroon from response
          adminMacaroon = initResponse.data['admin_macaroon'] ?? '';
          if (adminMacaroon.isNotEmpty) {
            logger.i("Successfully retrieved admin macaroon");
          }
        } else {
          logger.e("Failed to initialize Lightning node: ${initResponse.message}");
          throw Exception("Failed to initialize Lightning node: ${initResponse.message}");
        }
      } catch (e) {
        logger.e("Error initializing Lightning node: $e");
        throw Exception("Error initializing Lightning node: $e");
      }

      logger.i("=== STEP 4: WAITING FOR LIGHTNING SERVICES TO BE READY ===");
      
      // Wait a moment for initialization to settle
      logger.i("Waiting ${LightningConfig.postInitializationWaitSeconds} seconds for Lightning node to fully initialize after wallet creation...");
      await Future.delayed(Duration(seconds: LightningConfig.postInitializationWaitSeconds));
      
      // Check if wallet unlock is needed (should already be unlocked from initwallet)
      try {
        logger.i("Attempting wallet unlock (expecting 'already unlocked' message)...");
        dynamic unlockResponse = await unlockWallet(nodeId: workingNodeId);
        logger.i("Wallet unlock response: $unlockResponse");
      } catch (unlockError) {
        logger.i("Wallet unlock result: $unlockError");
        // This is expected - wallet should already be unlocked from initwallet
      }
      
      // Use intelligent status checking instead of blind waiting
      logger.i("Checking Lightning services readiness with status endpoint...");
      bool isReady = await waitForLightningReady(
        nodeId: workingNodeId,
        adminMacaroon: adminMacaroon,
        // Uses config defaults: maxWaitSeconds and checkIntervalSeconds
      );
      
      if (!isReady) {
        logger.e("❌ Lightning services did not become ready within ${LightningConfig.lightningReadyMaxWaitSeconds} seconds");
        throw Exception("Lightning services did not become ready within ${LightningConfig.lightningReadyMaxWaitSeconds} seconds. Check node status.");
      }
      
      // TODO: STEP 4: GETTING LIGHTNING NODE IDENTITY - TO BE ADDED LATER
      // Currently commenting out Lightning node identity retrieval to avoid getinfo blocking issues
      // We'll use mnemonic-based DIDs only for now
      /*
      logger.i("=== STEP 4: GETTING LIGHTNING NODE IDENTITY ===");
      
      // Now that services are confirmed ready, get the node info
      RestResponse nodeInfoResponse = await getNodeInfo(
        nodeId: LightningConfig.getDefaultNodeId(),
        adminMacaroon: adminMacaroon, // Use the NEW macaroon from initwallet
      );
      
      if (nodeInfoResponse.statusCode != "200") {
        logger.e("Failed to get Lightning node info: ${nodeInfoResponse.message}");
        throw Exception("Failed to get Lightning node info: ${nodeInfoResponse.message}");
      }
      
      String lightningPubkey = nodeInfoResponse.data['identity_pubkey'] ?? '';
      if (lightningPubkey.isEmpty) {
        logger.e("No Lightning identity pubkey found in node info");
        throw Exception("No Lightning identity pubkey found in node info");
      }
      
      logger.i("✅ Lightning node identity: $lightningPubkey");
      */
      
      logger.i("=== STEP 5: GENERATING MNEMONIC-BASED DID (SIMPLIFIED) ===");
      
      // SIMPLIFIED: Generate DID from mnemonic only (always derivable)
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonicString);
      logger.i("Generated recovery DID from mnemonic: $recoveryDid");
      
      // Check if user already exists with this mnemonic
      bool userAlreadyExists = await NodeMappingService.userExists(recoveryDid);
      if (userAlreadyExists) {
        logger.e("User already exists with this mnemonic!");
        throw Exception("Account already exists for this mnemonic. Use recovery instead.");
      }
      
      // For now, we'll use a placeholder Lightning pubkey
      String lightningPubkey = 'placeholder_pubkey_${recoveryDid.substring(0, 8)}';
      logger.i("Using placeholder Lightning pubkey: $lightningPubkey");

      // Use recovery DID as the primary identifier
      String did = recoveryDid;

      logger.i("=== STEP 6: CREATING NODE MAPPING (SIMPLIFIED) ===");
      
      // Create the critical recovery mapping with simplified structure
      UserNodeMapping nodeMapping = UserNodeMapping(
        recoveryDid: recoveryDid,
        lightningPubkey: lightningPubkey, // Using placeholder for now
        nodeId: workingNodeId, // Use the actual working node we found
        caddyEndpoint: LightningConfig.getCaddyEndpoint(workingNodeId),
        adminMacaroon: adminMacaroon,
        createdAt: DateTime.now(),
        lastAccessed: DateTime.now(),
        status: 'active',
        metadata: {
          'creation_method': 'mnemonic_based_account',
          'app_version': '1.0.0',
          'note': 'Lightning pubkey is placeholder until getinfo works',
          'working_node_found': workingNodeId,
        },
      );
      
      // Store the node mapping BEFORE storing private data
      await NodeMappingService.storeUserNodeMapping(nodeMapping);
      await NodeMappingService.storeMnemonicRecoveryIndex(mnemonicString, recoveryDid);
      logger.i("✅ Node mapping stored successfully");

      // Save the Lightning-generated mnemonic securely with RECOVERY DID
      logger.i("=== STEP 7: STORING PRIVATE DATA ===");
      logger.i("Recovery DID: $did");
      logger.i("Mnemonic length: ${mnemonicString.split(' ').length} words");
      logger.i("Mnemonic (first 3 words): ${mnemonicString.split(' ').take(3).join(' ')}...");
      final privateData = PrivateData(did: did, mnemonic: mnemonicString);
      await storePrivateData(privateData);
      logger.i("Private data stored successfully.");
      
      // Verify that we can immediately retrieve the stored data
      logger.i("=== VERIFYING STORED DATA ===");
      // Add a small delay to ensure secure storage write completes
      await Future.delayed(Duration(milliseconds: 100));
      try {
        final retrievedData = await getPrivateData(did);
        logger.i("✅ Successfully retrieved stored data for DID: ${retrievedData.did}");
        logger.i("✅ Retrieved mnemonic matches: ${retrievedData.mnemonic == mnemonicString}");
      } catch (e) {
        logger.e("❌ Failed to retrieve just-stored data: $e");
      }

      // OPTIONAL: Store additional node data in legacy format (if needed for compatibility)
      logger.i("=== STEP 8: STORING LEGACY NODE DATA (Optional) ===");
      
      try {
        if (adminMacaroon.isNotEmpty) {
          logger.i("Storing legacy node data for compatibility");
          
          // Store node data with macaroon for user (legacy format)
          await storeNodeData(did, workingNodeId, adminMacaroon, LightningConfig.caddyBaseUrl.replaceAll('http://', '').replaceAll('[', '').replaceAll(']', ''));
          logger.i("Legacy node data stored");
        } else {
          logger.w("No admin macaroon available for legacy storage");
        }
      } catch (e) {
        logger.e("Error storing legacy node data: $e");
        // Don't fail the entire process for legacy data
      }

      logger.i("User registration and setup completed with mnemonic-based DID architecture.");
      
      logger.i("=== STEP 9: STARTING FIREBASE AUTHENTICATION ===");
      logger.i("DID: $did");
      logger.i("Code: '${code.isEmpty ? '(EMPTY)' : code}'");
      logger.i("Issuer: '${issuer.isEmpty ? '(EMPTY)' : issuer}'");
      
      if (code.isEmpty) {
        logger.w("⚠️ Code is empty - this might cause issues in authentication");
      }
      
      try {
        await signUp(did, code);
        logger.i("✅ Firebase authentication completed successfully");
      } catch (signUpError) {
        logger.e("❌ Error in signUp: $signUpError");
        throw signUpError;
      }

    } catch (e) {
      logger.e("Error in generateAccount: $e");
      logger.e("Error type: ${e.runtimeType}");
      if (e is StateError) {
        logger.e("StateError details: This usually means firstWhere() found no matching elements");
      }
      // Handle errors (e.g., show user-friendly error message)
      rethrow; // Important: rethrow so the calling code knows it failed
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
