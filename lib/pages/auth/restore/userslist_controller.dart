// users_list_controller.dart
import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/protocol_controller.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
// Import your existing models and services
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/key_services/bip39_did_generator.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:lottie/lottie.dart';

class UsersListController extends GetxController {
  // Reactive variables
  var isLoading = true.obs;
  var userDataList = <UserData>[].obs;
  var selectedIndex = 0.obs;
  var isVisible = false.obs;

  // Animation Composition
  late Future<LottieComposition> searchForFilesComposition;

  // Mapping from DID to PrivateData for easy access
  final Map<String, PrivateData> didToPrivateDataMap = {};

  // Page Controller
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(viewportFraction: 0.8);
    searchForFilesComposition =
        loadComposition('assets/lottiefiles/search_for_files.json');
    // onScreenForward();
    //call to detch users
    onScreenForward();
  }

  void onScreenForward() {
    updateVisibility();
    fetchUsers();
  }

  @override
  void onClose() {
    pageController.dispose();
    selectedIndex = 0.obs;
    super.onClose();
  }

  /// Updates the visibility state after loading the animation composition
  void updateVisibility() async {
    await searchForFilesComposition;
    // Delay to ensure the animation is loaded
    Timer(const Duration(milliseconds: 50), () {
      isVisible.value = true;
    });
  }

  /// Fetches users by retrieving PrivateData from local storage and UserData from Firebase
  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      // Retrieve all PrivateData from local storage
      userDataList = <UserData>[].obs;

      List<PrivateData> ionDataList = await getIONDatafromLocalStorage();

      if (ionDataList.isEmpty) {
        // No users found locally
        userDataList.clear();
        return;
      }

      // Map DID to PrivateData for quick lookup
      for (var ionData in ionDataList) {
        // OLD: Multiple users one node approach - HDWallet-based DID generation
        // HDWallet hdWallet = HDWallet.fromMnemonic(ionData.mnemonic);
        // didToPrivateDataMap[hdWallet.pubkey] = ionData;
        
        // NEW: One user one node approach - Lightning aezeed format
        String did = Bip39DidGenerator.generateDidFromLightningMnemonic(ionData.mnemonic);
        didToPrivateDataMap[did] = ionData;
      }

      // Extract all DIDs
      List<String> dids = didToPrivateDataMap.keys.toList();

      // Fetch UserData from Firebase
      List<UserData> fetchedUserData = await getUserDatafromFirebase(dids);
      userDataList.assignAll(fetchedUserData);
    } catch (e) {
      // Handle error globally or notify the view
      Get.snackbar('Error', 'Failed to fetch users: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  /// Function that fetches all users again and adds to the list if not already present
  /// Only sets `isLoading` to true if we actually find new DIDs that aren't in `userDataList` yet.
  // Future<void> updateUsers() async {
  //   try {
  //     // Re-fetch local PrivateData
  //     List<PrivateData> ionDataList = await getIONDatafromLocalStorage();
  //     if (ionDataList.isEmpty) return;
  //
  //     // First check if there is at least one new DID that doesn't exist in `userDataList`
  //     // Build a temporary map to detect new DIDs
  //     final Map<String, PrivateData> localDidMap = {};
  //     for (var ionData in ionDataList) {
  //       HDWallet hdWallet = HDWallet.fromMnemonic(ionData.mnemonic);
  //       localDidMap[hdWallet.pubkey] = ionData;
  //     }
  //
  //     // Convert local DID map to list
  //     List<String> localDids = localDidMap.keys.toList();
  //
  //     // Check if there's any DID in `localDids` not in the existing `userDataList`
  //     bool hasNewDids = localDids.any(
  //           (did) => userDataList.every((existingUser) => existingUser.did != did),
  //     );
  //
  //     // If no new DIDs, just return; no need to toggle `isLoading`.
  //     if (!hasNewDids) return;
  //
  //     // There are indeed new users, so set loading to true
  //     isLoading.value = true;
  //
  //     // Refresh our main didToPrivateDataMap with the new local map
  //     didToPrivateDataMap.clear();
  //     didToPrivateDataMap.addAll(localDidMap);
  //
  //     // Fetch from Firebase
  //     List<UserData> fetchedUserData = await getUserDatafromFirebase(localDids);
  //
  //     // Only add those fetched users not already in the list
  //     for (var user in fetchedUserData) {
  //       bool existsAlready =
  //       userDataList.any((existingUser) => existingUser.did == user.did);
  //       if (!existsAlready) {
  //         userDataList.add(user);
  //       }
  //     }
  //   } catch (e) {
  //     // Handle error globally or notify the view
  //     throw Exception('Failed to update users: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void showError(BuildContext context) {
    final overlayController = Get.find<OverlayController>();
    overlayController.showOverlay(
      L10n.of(context)!.overlayErrorOccured,
      color: AppTheme.errorColor,
    );
  }

  /// Retrieves all PrivateData from local storage
  dynamic getIONDatafromLocalStorage() async {
    try {
      print("Retrieving Private Data from secure storage...");
      //here we read from secure storage this causes the init to fail initalizing before somehow
      dynamic storedData = await getAllStoredIonData();
      print("Stored Data: $storedData");
      // Ensure the data is a List<PrivateData>
      return List<PrivateData>.from(storedData);
    } catch (e) {
      print("Error retrieving PrivateData: $e");
      return [];
    }
  }

  /// Fetches UserData from Firebase based on the list of DIDs
  Future<List<UserData>> getUserDatafromFirebase(List<String> dids) async {
    print("Fetching Firebase data for users...");
    List<Future<UserData?>> futures = dids.map((did) async {
      try {
        print("Fetching user with DID $did from Firebase...");
        DocumentSnapshot doc = await usersCollection.doc(did).get();

        if (doc.exists) {
          return UserData.fromDocument(doc);
        } else {
          // If user does not exist in Firestore, remove from local storage
          await deleteUserFromStoredIONData(did);
          print("User with DID $did removed from local storage.");
          return null;
        }
      } catch (e) {
        print("Error fetching user with DID $did: $e");
        await deleteUserFromStoredIONData(did);
        print("User with DID $did removed from local storage due to error.");
        return null;
      }
    }).toList();

    List<UserData?> results = await Future.wait(futures);
    return results.whereType<UserData>().toList();
  }

  /// Handles the login process for a user
  Future<void> loginButtonPressed(String did, BuildContext context) async {
    final logger = Get.find<LoggerService>();
    Get.delete<ProtocolController>(force: true);
    logger.i("Localfunction Login for user $did pressed");
    try {
      PrivateData? privateData = didToPrivateDataMap[did];

      if (privateData == null) {
        throw Exception("PrivateData not found for DID: $did");
      }

      // OLD: Multiple users one node approach - HDWallet-based key derivation
      // HDWallet hdWallet = HDWallet.fromMnemonic(privateData.mnemonic);
      // print("Login for user ${hdWallet.pubkey} pressed");
      // print("Private Key: ${hdWallet.privkey}");
      
      // NEW: One user one node approach - BIP39-based key derivation
      Map<String, String> keys = Bip39DidGenerator.generateKeysFromMnemonic(privateData.mnemonic);
      String publicKey = keys['publicKey']!;
      String privateKey = keys['privateKey']!;
      print("Login for user $did pressed");
      print("Public Key: $publicKey");
      print("Private Key: $privateKey");

      final logger = Get.find<LoggerService>();

      String challengeData = "Saved User SecureStorage Challenge";

      // OLD: Multiple users one node approach - HDWallet key signing
      // String signatureHex = await signChallengeData(
      //     hdWallet.privkey, hdWallet.pubkey, challengeData);
      
      // NEW: One user one node approach - BIP39 key signing
      String signatureHex = await signChallengeData(
          privateKey, publicKey, challengeData);

      logger.d('Generated signature hex: $signatureHex');
      await Auth().signIn(ChallengeType.securestorage_login, privateData,
          signatureHex, context);

      logger.i('User signed in successfully!');
    } catch (e, stackTrace) {
      final overlayController = Get.find<OverlayController>();
      logger.e("Error trying to sign in: $e, $stackTrace");
      overlayController.showOverlay('An error occurred during login.',
          color: AppTheme.errorColor);
      // Optionally, you can rethrow or handle the exception as needed
    }
  }

  /// Deletes a user based on their DID
  Future<void> deleteUser(String did) async {
    final overlayController = Get.find<OverlayController>();
    final logger = Get.find<LoggerService>();
    try {
      await deleteUserFromStoredIONData(did);
      userDataList.removeWhere((user) => user.did == did);
      didToPrivateDataMap.remove(did);
      Get.snackbar('Success', 'User deleted successfully.',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      logger.e("Error deleting user with DID $did: $e");
      overlayController.showOverlay('Failed to delete user.',
          color: AppTheme.errorColor);
    }
  }
}
