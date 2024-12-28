// users_list_controller.dart
import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
// Import your existing models and services
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
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
        HDWallet hdWallet = HDWallet.fromMnemonic(ionData.mnemonic);
        didToPrivateDataMap[hdWallet.pubkey] = ionData;
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
    logger.i("Login for user $did pressed");
    try {
      PrivateData? privateData = didToPrivateDataMap[did];

      if (privateData == null) {
        throw Exception("PrivateData not found for DID: $did");
      }

      HDWallet hdWallet = HDWallet.fromMnemonic(privateData.mnemonic);
      print("Login for user ${hdWallet.pubkey} pressed");
      print("Private Key: ${hdWallet.privkey}");

      final logger = Get.find<LoggerService>();

      String challengeData = "Saved User SecureStorage Challenge";

      String signatureHex = await signChallengeData(
          hdWallet.privkey, hdWallet.pubkey, challengeData);

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
