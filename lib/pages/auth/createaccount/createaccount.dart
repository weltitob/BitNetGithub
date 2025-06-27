import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/genseed.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/init_wallet.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletunlocker/unlock_wallet.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_info.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_status.dart';
import 'package:bitnet/backbone/services/lightning_node_finder.dart';
import 'package:bitnet/backbone/services/node_assignment_service.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
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
import 'package:bitnet/intl/generated/l10n.dart';
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

  // Store subscription for proper disposal
  StreamSubscription? _profileLoadingSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _profileLoadingSubscription?.cancel();
    controllerUsername.dispose();
    super.dispose();
  }

  void createAccountPressed() async {
    print("🔴 CREATE_ACCOUNT_PRESSED CALLED - ACTUAL ENTRY POINT");
    LoggerService logger = Get.find();
    logger.i("🔴 CREATE_ACCOUNT_PRESSED CALLED - ACTUAL ENTRY POINT");
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
          await generateAccount(username: localpart);
          logger.i("✅ Account generation completed successfully");
        } catch (e) {
          logger.e("❌ Account generation failed: $e");

          // Handle specific error for existing user on node
          String friendlyErrorMessage =
              "Account creation failed. Please try again.";
          if (e.toString().contains("already has a registered user")) {
            friendlyErrorMessage =
                "A user is already registered on this Lightning node. Please use 'Login' or 'Recover Account' instead.";
          } else if (e
              .toString()
              .contains("Account already exists for this mnemonic")) {
            friendlyErrorMessage =
                "An account already exists. Please use 'Recover Account' to restore your wallet.";
          }

          setState(() {
            isLoading = false;
            errorMessage = friendlyErrorMessage;
          });
          return; // Exit early, don't proceed with ProfileController
        }

        // Verify authentication completed successfully before proceeding
        if (Auth().currentUser == null) {
          logger
              .e("❌ Authentication verification failed - currentUser is null");
          setState(() {
            isLoading = false;
            errorMessage = "Authentication failed. Please try again.";
          });
          return; // Exit early, don't proceed with ProfileController
        }

        logger.i("✅ Authentication verified, proceeding with profile setup");

        // Sichere ProfileController-Initialisierung
        ProfileController profileController;
        try {
          profileController = Get.find<ProfileController>();
          logger.i("ProfileController already exists, reusing instance");
        } catch (e) {
          logger.i("Creating new ProfileController instance");
          profileController = Get.put(ProfileController());
        }

        profileController.userNameController.text = localpart;
        _profileLoadingSubscription =
            profileController.isUserLoading.listen((val) {
          if (!val) {
            profileController.updateUsername();
            if (image != null) {
              profileController.handleProfileImageSelected(image!);
            }
            if (pair != null) {
              profileController.handleProfileNftSelected(pair!);
            }
            _profileLoadingSubscription?.cancel();
            _profileLoadingSubscription = null;
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
  Future<void> storeNodeData(
      String did, String nodeId, String adminMacaroon, String nodeHost) async {
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

  Future generateAccount({String? preferredNodeId, String? username}) async {
    print("🔵 GENERATE_ACCOUNT CALLED - SECOND ENTRY POINT");
    LoggerService logger = Get.find<LoggerService>();
    logger.i("🔵 GENERATE_ACCOUNT CALLED - SECOND ENTRY POINT");
    logger.i("Generating BIP39 mnemonic for one user one node approach...");

    try {
      // NEW APPROACH: Find an unused Lightning node (one user per node)
      logger.i("=== STEP 1: FINDING UNUSED LIGHTNING NODE FOR NEW USER ===");

      // Find available nodes that aren't occupied
      List<String> occupiedNodes = await NodeMappingService.getOccupiedNodes();
      logger.i("Currently occupied nodes: $occupiedNodes");

      // Get available Lightning nodes from LightningConfig
      List<String> availableNodes = LightningConfig.getAllNodeIds();
      logger.i("Available nodes from config: $availableNodes");

      // Check if preferred node is specified and available
      String? workingNodeId;
      if (preferredNodeId != null) {
        logger.i("Checking preferred node: $preferredNodeId");

        // Validate the preferred node ID format
        if (LightningConfig.isValidNodeId(preferredNodeId)) {
          if (!occupiedNodes.contains(preferredNodeId)) {
            workingNodeId = preferredNodeId;
            logger.i("✅ Using preferred node: $preferredNodeId");
          } else {
            logger.w("❌ Preferred node $preferredNodeId is already occupied");
          }
        } else {
          logger.w("❌ Invalid preferred node ID format: $preferredNodeId");
        }
      }

      // If no preferred node or preferred node not available, find first available
      if (workingNodeId == null) {
        for (String nodeId in availableNodes) {
          if (!occupiedNodes.contains(nodeId)) {
            workingNodeId = nodeId;
            logger.i("Found unused node: $nodeId");
            break;
          }
        }
      }

      if (workingNodeId == null) {
        throw Exception(
            "All Lightning nodes are currently occupied. Please try again later or contact support.");
      }

      logger.i(
          "✅ Selected unused node: $workingNodeId (strict one-user-one-node)");

      // Verify the node is actually working by testing basic connectivity
      logger.i("Verifying node $workingNodeId is responsive...");

      // Test the assigned node specifically
      Map<String, bool> nodeStatus =
          await LightningNodeFinder.getAllNodeStatus(timeoutSeconds: 5);
      bool isAssignedNodeWorking = nodeStatus[workingNodeId] ?? false;

      if (!isAssignedNodeWorking) {
        logger.w(
            "⚠️ Selected node $workingNodeId is not responding, need to find alternative...");

        // Find available working nodes that aren't occupied
        String? alternativeNode;
        for (String nodeId in nodeStatus.keys) {
          if (nodeStatus[nodeId] == true && !occupiedNodes.contains(nodeId)) {
            alternativeNode = nodeId;
            logger.i("Found available working node: $nodeId");
            break;
          }
        }

        if (alternativeNode != null) {
          workingNodeId = alternativeNode;
          logger.i("✅ Using alternative available node: $workingNodeId");
        } else {
          throw Exception(
              "No working Lightning nodes are available for assignment. All nodes are either down or occupied.");
        }
      } else {
        logger.i("✅ Selected node $workingNodeId is responsive and ready");
      }

      logger.i("=== STEP 2: GENERATING SEED VIA LIGHTNING NODE ===");
      RestResponse seedResponse = await generateSeed(nodeId: workingNodeId);

      List<String> mnemonicWords;
      String mnemonicString;
      String adminMacaroon = '';

      // Check if wallet is already unlocked (expected in one-user-one-node approach)
      if (seedResponse.statusCode != "200" &&
          seedResponse.data['raw_response'] != null) {
        String responseBody = seedResponse.data['raw_response'];
        Map<String, dynamic> errorData = jsonDecode(responseBody);

        if (errorData['message']?.contains('wallet already unlocked') == true) {
          logger.i(
              "🔍 WALLET ALREADY UNLOCKED - User should already exist for this node");
          logger.i(
              "=== STEP 2B: CHECKING FOR EXISTING USER ON NODE $workingNodeId ===");

          // In one-user-one-node approach, an unlocked wallet means a user already exists
          List<UserNodeMapping> existingMappings =
              await NodeMappingService.getUsersForNode(workingNodeId);

          if (existingMappings.isNotEmpty) {
            logger.i("Found existing user(s) for node $workingNodeId:");
            for (var mapping in existingMappings) {
              logger.i("- User: ${mapping.recoveryDid}");
              logger.i("- Status: ${mapping.status}");
              logger.i("- Created: ${mapping.createdAt}");
            }

            // For account creation with existing user, this should not happen
            // User should be using the login/recovery flow instead
            logger.e(
                "❌ Cannot create new account: Node $workingNodeId already has registered user(s)");
            logger.e(
                "User should use login or account recovery instead of account creation");

            throw Exception(
                "This Lightning node already has a registered user. "
                "Please use 'Login' or 'Recover Account' instead of creating a new account.");
          } else {
            // This is unexpected: wallet is unlocked but no user mappings found
            logger.w(
                "⚠️ UNEXPECTED STATE: Wallet unlocked but no user mappings found for node $workingNodeId");
            logger.e(
                "This indicates a serious data inconsistency or improper node configuration");

            throw Exception("Lightning node is in an inconsistent state. "
                "Please contact support or try again later.");
          }
        } else {
          throw Exception("Failed to generate seed: ${seedResponse.message}");
        }
      } else if (seedResponse.statusCode == "200") {
        // Normal path: Extract seed data from Lightning node response
        Map<String, dynamic> seedData = seedResponse.data;
        List<dynamic> cipherSeedMnemonic =
            seedData['cipher_seed_mnemonic'] ?? [];
        String encipheredSeed = seedData['enciphered_seed'] ?? '';

        logger.i("Lightning node generated seed successfully:");
        logger.i("- Cipher seed mnemonic: ${cipherSeedMnemonic.length} words");
        logger.i(
            "- Enciphered seed: ${encipheredSeed.substring(0, 20)}... (truncated)");

        // Convert to string list for our internal use
        mnemonicWords = cipherSeedMnemonic.cast<String>();
        mnemonicString = mnemonicWords.join(' ');

        logger.i("=== STEP 3: INITIALIZING WALLET WITH LIGHTNING SEED ===");

        logger.i(
            "Using Lightning node's native cipher seed mnemonic for init_wallet");

        try {
          RestResponse initResponse =
              await initWallet(mnemonicWords, nodeId: workingNodeId);

          if (initResponse.statusCode == "200") {
            logger.i("Lightning node initialized successfully");

            // Extract admin macaroon from response
            adminMacaroon = initResponse.data['admin_macaroon'] ?? '';
            if (adminMacaroon.isNotEmpty) {
              logger.i("Successfully retrieved admin macaroon");
            }
          } else {
            logger.e(
                "Failed to initialize Lightning node: ${initResponse.message}");
            throw Exception(
                "Failed to initialize Lightning node: ${initResponse.message}");
          }
        } catch (e) {
          logger.e("Error initializing Lightning node: $e");
          throw Exception("Error initializing Lightning node: $e");
        }
      } else {
        throw Exception("Failed to generate seed: ${seedResponse.message}");
      }

      logger.i("=== STEP 4: LIGHTNING WALLET INITIALIZATION COMPLETE ===");
      logger.i(
          "✅ Lightning wallet created successfully - continuing with mnemonic-based authentication");
      logger.i(
          "Note: Lightning services will initialize in background, but authentication doesn't depend on them");

      logger.i("=== STEP 4: GENERATING RECOVERY DID ===");

      // Generate recovery DID from mnemonic (always derivable for recovery)
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonicString);
      logger.i("Generated recovery DID from mnemonic: $recoveryDid");

      // Check if user already exists with this mnemonic
      bool userAlreadyExists = await NodeMappingService.userExists(recoveryDid);
      if (userAlreadyExists) {
        logger.e("User already exists with this mnemonic!");
        throw Exception(
            "Account already exists for this mnemonic. Use recovery instead.");
      }

      // For now, we'll use a placeholder Lightning pubkey
      String lightningPubkey =
          'placeholder_pubkey_${recoveryDid.substring(0, 8)}';
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
        status: 'occupied',
        metadata: {
          'creation_method': 'mnemonic_based_account',
          'app_version': '1.0.0',
          'note': 'Lightning pubkey is placeholder until getinfo works',
          'working_node_found': workingNodeId,
        },
      );

      // Store the node mapping BEFORE storing private data
      await NodeMappingService.storeUserNodeMapping(nodeMapping);
      await NodeMappingService.storeMnemonicRecoveryIndex(
          mnemonicString, recoveryDid);
      logger.i("✅ Node mapping stored successfully");

      // Store the admin macaroon locally in secure storage
      if (adminMacaroon.isNotEmpty) {
        logger.i("=== STORING ADMIN MACAROON LOCALLY ===");
        try {
          // Use recovery DID as userId and node ID as accountId for individual nodes
          await storeLitdAccountData(recoveryDid, workingNodeId, adminMacaroon);
          logger.i("✅ Admin macaroon stored locally in secure storage");
        } catch (e) {
          logger.e("❌ Failed to store admin macaroon locally: $e");
          // Don't fail the entire registration, but log the error
        }

        // TODO: Bake limited invoice tracking macaroon
        // This macaroon will only have permissions to:
        // - List invoices (invoices:read)
        // - Track payment status (offchain:read)
        // It will be stored in Firebase for backend payment tracking
        logger.i("=== TODO: BAKE INVOICE TRACKING MACAROON ===");
        // String invoiceTrackingMacaroon = await bakeLimitedMacaroon(
        //   nodeId: workingNodeId,
        //   adminMacaroon: adminMacaroon,
        //   permissions: ['invoices:read', 'offchain:read'],
        // );
        //
        // if (invoiceTrackingMacaroon.isNotEmpty) {
        //   // Update node mapping with tracking macaroon
        //   await FirebaseFirestore.instance
        //     .collection('node_mappings')
        //     .doc(recoveryDid)
        //     .update({
        //       'invoiceTrackingMacaroon': invoiceTrackingMacaroon,
        //     });
        //   logger.i("✅ Invoice tracking macaroon stored in Firebase");
        // }
      }

      // Save the Lightning-generated mnemonic securely with RECOVERY DID
      logger.i("=== STEP 7: STORING PRIVATE DATA ===");
      logger.i("Recovery DID: $did");
      logger.i("Mnemonic length: ${mnemonicString.split(' ').length} words");
      logger.i(
          "Mnemonic (first 3 words): ${mnemonicString.split(' ').take(3).join(' ')}...");
      final privateData = PrivateData(did: did, mnemonic: mnemonicString);
      await storePrivateData(privateData);
      logger.i("Private data stored successfully.");

      // Verify that we can immediately retrieve the stored data
      logger.i("=== VERIFYING STORED DATA ===");
      // Add a small delay to ensure secure storage write completes
      await Future.delayed(Duration(milliseconds: 100));
      try {
        final retrievedData = await getPrivateData(did);
        logger.i(
            "✅ Successfully retrieved stored data for DID: ${retrievedData.did}");
        logger.i(
            "✅ Retrieved mnemonic matches: ${retrievedData.mnemonic == mnemonicString}");
      } catch (e) {
        logger.e("❌ Failed to retrieve just-stored data: $e");
      }

      // OPTIONAL: Store additional node data in legacy format (if needed for compatibility)
      logger.i("=== STEP 8: STORING LEGACY NODE DATA (Optional) ===");

      try {
        if (adminMacaroon.isNotEmpty) {
          logger.i("Storing legacy node data for compatibility");

          // Store node data with macaroon for user (legacy format)
          await storeNodeData(
              did,
              workingNodeId,
              adminMacaroon,
              LightningConfig.caddyBaseUrl
                  .replaceAll('http://', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
          logger.i("Legacy node data stored");
        } else {
          logger.w("No admin macaroon available for legacy storage");
        }
      } catch (e) {
        logger.e("Error storing legacy node data: $e");
        // Don't fail the entire process for legacy data
      }

      logger.i(
          "User registration and setup completed with mnemonic-based DID architecture.");

      logger.i("=== STEP 9: STARTING FIREBASE AUTHENTICATION ===");
      logger.i("DID: $did");
      logger.i("Code: '${code.isEmpty ? '(EMPTY)' : code}'");
      logger.i("Issuer: '${issuer.isEmpty ? '(EMPTY)' : issuer}'");

      if (code.isEmpty) {
        logger
            .w("⚠️ Code is empty - this might cause issues in authentication");
      }

      try {
        await signUp(did, code, username);
        logger.i("✅ Firebase authentication completed successfully");
      } catch (signUpError) {
        logger.e("❌ Error in signUp: $signUpError");
        throw signUpError;
      }
    } catch (e) {
      logger.e("Error in generateAccount: $e");
      logger.e("Error type: ${e.runtimeType}");
      if (e is StateError) {
        logger.e(
            "StateError details: This usually means firstWhere() found no matching elements");
      }
      // Handle errors (e.g., show user-friendly error message)
      rethrow; // Important: rethrow so the calling code knows it failed
    }
  }

  Future<bool> signUp(String did, String code, String? username) async {
    print("🟢 SIGNUP IN CREATEACCOUNT CALLED - THIRD ENTRY POINT");
    LoggerService logger = Get.find();
    logger.i("🟢 SIGNUP IN CREATEACCOUNT CALLED - THIRD ENTRY POINT");

    try {
      // Check if we have a litd account with macaroon for this user
      final litdAccountData = await getLitdAccountData(did);
      String? macaroonStr = litdAccountData?['macaroon'];
      String? accountId = litdAccountData?['accountId'];

      if (macaroonStr != null && accountId != null) {
        logger.i("Found stored litd account: $accountId with macaroon");
      } else {
        logger.w(
            "No litd account found for user, will continue without lightning functionality");
      }

      final userdata = UserData(
          backgroundImageUrl: '',
          isPrivate: false,
          showFollowers: false,
          did: did,
          displayName: username ??
              did, // Use username if provided, otherwise fall back to DID
          bio: L10n.of(context)!.joinedRevolution,
          customToken: "customToken",
          username: username ??
              did, // Use username if provided, otherwise fall back to DID
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

      // Pass the mnemonic to firebaseAuthentication for registration flow
      final PrivateData privateData = await getPrivateData(did);
      final UserData? currentuserwallet = await firebaseAuthentication(
          userdata, verificationCode, privateData.mnemonic);
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
        logger.i(
            "Lightning functionality is ready to use with account $accountId");
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

  Future<UserData?> firebaseAuthentication(UserData userData,
      VerificationCode code, String? mnemonicForRegistration) async {
    print("🟡 FIREBASE_AUTH IN CREATEACCOUNT CALLED - FOURTH ENTRY POINT");
    LoggerService logger = Get.find();
    logger.i("🟡 FIREBASE_AUTH IN CREATEACCOUNT CALLED - FOURTH ENTRY POINT");
    try {
      logger.i("Creating firebase user now...");

      final UserData currentuserwallet = await Auth().createUser(
        user: userData,
        code: code,
        mnemonicForRegistration: mnemonicForRegistration,
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
