import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/getblocktimestamp.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/fetchassetmeta.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/list_assets.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/social_recovery_helper.dart';
import 'package:bitnet/components/tabs/columnviewtab.dart';
import 'package:bitnet/components/tabs/editprofile.dart';
import 'package:bitnet/components/tabs/likeviewtab.dart';
import 'package:bitnet/components/tabs/rowviewtab.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/wallet/notifications/notifications_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class ProfileController extends BaseController {
  // Add disposal flags to prevent adding listeners multiple times
  bool _listenersInitialized = false;
  late String profileId;

  late List<Widget> pages;
  RxInt currentview = 0.obs;

  RxBool isLoading = true.obs;

  Rx<bool> assetsLoading = false.obs;

  RxBool isUserLoading = true.obs;
  Rx<UserData> userData = UserData(
    docId: '',
    did: '',
    displayName: '',
    username: '',
    bio: '',
    customToken: '',
    profileImageUrl: '',
    backgroundImageUrl: '',
    isPrivate: false,
    showFollowers: true,
    setupQrCodeRecovery: false,
    setupWordRecovery: false,
    fcmToken: '',
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
    isActive: true,
    dob: 0,
    nft_profile_id: '',
    nft_background_id: '',
  ).obs;
  RxString profileLoadError = ''.obs;

  RxBool isPrivate = false.obs;
  RxBool showFollwers = true.obs;
  RxString _profileImage = ''.obs;
  RxString _backgroundImage = ''.obs;

  RxBool usernameValid = true.obs;
  RxBool displayNameValid = true.obs;
  RxBool bioValid = true.obs;

  RxBool isFollowing = false.obs;
  RxBool gotIsFollowing = false.obs;
  RxInt followerCount = 0.obs;
  RxInt followingCount = 0.obs;
  RxBool gotFollowerCount = false.obs;
  RxBool gotFollowingCount = false.obs;
  TextEditingController displayNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Rx<String> changingDisplayName = ''.obs;
  Rx<String> changingUserName = ''.obs;
  Rx<String> changingBio = ''.obs;

  late final ScrollController scrollController;

  bool isLoadingNotifs = true;
  List<Widget> organizedNotifications = [];
  Map<String, List<SingleNotificationWidget>> categorizedNotifications = {};

  RxString validDisplayName = ''.obs;
  RxString validUserName = ''.obs;
  RxString validBio = ''.obs;

  final focusNodeDisplayName = FocusNode();
  final focusNodeUsername = FocusNode();
  final focusNodeBio = FocusNode();

  RxList<dynamic> assets = <Asset>[].obs;
  RxList<dynamic> assetsLazyLoading = <Asset>[].obs;
  Map<String, AssetMetaResponse> assetMetaMap = {};
  DateTime originalBlockDate = DateTime.now();
  bool get profileReady =>
      gotIsFollowing.value == true &&
      gotFollowerCount.value == true &&
      gotFollowingCount.value == true &&
      isUserLoading.value == false;

  List<AppData> availableApps = List.empty(growable: true);
  @override
  void onInit() {
    super.onInit();
    logger.i("ProfileController onInit called");
    scrollController = ScrollController();
    pages = [
      ColumnViewTab(),
      RowViewTab(),
      NotificationsWidget(),
      LikeViewTab(),
      EditProfileTab(),
    ];
    _setupUsernameListener();

    // Clear any previous error state
    profileLoadError.value = '';
    isUserLoading.value = true;

    loadData();
    fetchTaprootAssets();
  }

  void _setupUsernameListener() {
    userNameController.addListener(() {
      final currentText = userNameController.text;

      // If empty, just set to '@'
      if (currentText.isEmpty) {
        userNameController.text = '@';
        userNameController.selection = TextSelection.collapsed(
          offset: userNameController.text.length,
        );
        return;
      }

      // If user tries removing or skipping '@', re-add it:
      if (!currentText.startsWith('@')) {
        // Remove any stray '@' in the middle of the text & enforce a single prefix
        final cleanedText = currentText.replaceAll('@', '');
        userNameController.text = '@$cleanedText';
        // Move the cursor to the end
        userNameController.selection = TextSelection.collapsed(
          offset: userNameController.text.length,
        );
      }
    });
  }

  Future<void> getUserId() async {
    final logger = Get.find<LoggerService>();
    logger.i("getUserId() called");

    // Check if user is authenticated
    if (Auth().currentUser == null) {
      logger.e("No authenticated user found");
      profileId = "";
      throw Exception("Please log in to view your profile");
    }

    final uid = Auth().currentUser!.uid;
    logger.i("Getting user id for profile page: $uid");

    // In BitNET, the document ID should be the Firebase UID
    // So we directly use the UID as the profile ID
    profileId = uid;

    // Verify the document exists
    try {
      logger.i("Checking if user document exists for UID: $uid");
      final doc = await usersCollection.doc(uid).get();
      if (!doc.exists) {
        logger.e("User document not found for UID: $uid");
        throw Exception(
            "User profile not found. Please complete your profile setup.");
      }
      logger.i("User document exists, profileId set to: $profileId");
    } catch (e) {
      logger.e("Error checking user document: $e");
      throw e;
    }
  }

  void fetchTaprootAssets() async {
    final logger = Get.find<LoggerService>();
    logger.i('Fetching taproot assets...');

    // Don't reload if already loading
    if (assetsLoading.value) return;

    isLoading.value = true;
    assetsLoading.value = true;

    try {
      List<Asset> fetchedAssets = await listTaprootAssets();

      // Only update if data has changed
      if (fetchedAssets.length != assets.length) {
        List<Asset> reversedAssets = fetchedAssets.reversed.toList();
        assets.value = reversedAssets;

        // Load initial batch of metadata
        await fetchNext20Metas(0, 10);
        assetsLazyLoading.value = assets.take(10).toList();
      }

      isLoading.value = false;
    } catch (e) {
      logger.e('Error fetching taproot assets: $e');
      isLoading.value = false;
    } finally {
      assetsLoading.value = false;
    }
  }

  fetchNext20Metas(int startIndex, int count) async {
    logger.i('izak: Fetching next 20 taproot assets...');
    Map<String, AssetMetaResponse> metas = {};
    for (int i = startIndex; i < startIndex + count && i < assets.length; i++) {
      String assetId = assets[i].assetGenesis?.assetId ?? '';
      AssetMetaResponse? meta = await fetchAssetMeta(assetId);
      if (meta != null) {
        metas[assetId] = meta;
      }
    }
    logger.i('izak: above is the asset meta data done value ');

    assetMetaMap.addAll(metas);
  }

  loadMoreAssets() async {
    isLoading.value = true;
    if (assetsLazyLoading.length < assets.length) {
      int nextIndex = assetsLazyLoading.length;
      int endIndex = nextIndex + 10;
      List<dynamic> nextAssets = assets.sublist(
          nextIndex, endIndex > assets.length ? assets.length : endIndex);
      await fetchNext20Metas(
          nextIndex, 10); // Load metadata for the next 20 assets
      assetsLazyLoading.addAll(nextAssets);
      isLoading.value = false;
    }
  }

  loadData() async {
    final logger = Get.find<LoggerService>();
    logger.i("Loading data for profile page");

    try {
      // Reset error state
      profileLoadError.value = '';
      isUserLoading.value = true;

      // First get user ID as it's required for other operations
      await getUserId();

      // Run these operations in parallel
      await Future.wait<void>([
        getUser(),
        getFollowers(),
        getFollowing(),
        checkIfFollowing(),
      ]);

      // Initialize recovery options (non-critical, don't await)
      socialRecoveryInit();
      emailRecoveryInit();
      wordRecoveryInit();

      // Add listeners only if not already initialized
      if (!_listenersInitialized) {
        addFocusNodeListenerAndUpdate(focusNodeUsername, updateUsername);
        addFocusNodeListenerAndUpdate(focusNodeDisplayName, updateDisplayName);
        addFocusNodeListenerAndUpdate(focusNodeBio, updateBio);
        _listenersInitialized = true;
      }

      logger.i("Profile data loaded successfully");
    } catch (e) {
      logger.e("Error loading profile data: $e");
      // Set a flag to show error in UI
      profileLoadError.value = e.toString();
      // IMPORTANT: Set loading to false so the error screen shows
      isUserLoading.value = false;
    }
  }

  addFocusNodeListenerAndUpdate(FocusNode focusNode, Function() func) {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        func();
      }
    });
  }

  getUser() async {
    try {
      logger.i("Getting user data for $profileId from firebase");
      isUserLoading.value = true;

      if (profileId.isEmpty) {
        throw Exception("Invalid profile ID");
      }

      DocumentSnapshot? doc = await usersCollection.doc(profileId).get();

      if (!doc.exists) {
        throw Exception("User profile not found");
      }

      userData = UserData.fromDocument(doc).obs;

      displayNameController.text = userData.value.displayName;
      changingDisplayName.value = userData.value.displayName;
      validDisplayName.value = userData.value.displayName;
      userNameController.text = userData.value.username;
      changingUserName.value = userData.value.username;
      validUserName.value = userData.value.username;
      bioController.text = userData.value.bio;
      changingBio.value = userData.value.bio;
      validBio.value = userData.value.bio;
      showFollwers.value = userData.value.showFollowers;
      _backgroundImage.value = userData.value.backgroundImageUrl;
      _profileImage.value = userData.value.profileImageUrl;

      // Only add text controller listeners once
      if (!_listenersInitialized) {
        displayNameController.addListener(() {
          changingDisplayName.value = displayNameController.text;
        });
        userNameController.addListener(() {
          changingUserName.value = userNameController.text;
        });
        bioController.addListener(() {
          changingBio.value = bioController.text;
        });
      }

      isUserLoading.value = false;
    } catch (e) {
      logger.e("Error getting user data: $e");
      isUserLoading.value = false;
      // Re-throw to be handled by the UI
      throw e;
    }
  }

  GlobalKey globalKeyQR = GlobalKey();

  void updateProfilepic() {
    logger.i("Updating profile pic");
    usersCollection.doc(profileId).update({
      'profileImageUrl': _profileImage,
    });
  }

  void updateUsername() {
    logger.i("Updating username");
    usersCollection.doc(profileId).update({
      'username': userNameController.text,
    });
  }

  void updateDisplayName() {
    logger.i("Updating display name");
    displayNameValid.value = displayNameController.text.trim().length >= 3;
    if (displayNameValid.value) {
      usersCollection.doc(profileId).update({
        'displayName': displayNameController.text,
      });
    }
  }

  void updateBackgroundpic() {
    logger.i("Updating background pic");
    usersCollection.doc(profileId).update({
      'backgroundImageUrl': _backgroundImage,
    });
  }

  void updateBio() {
    logger.i("Updating bio");
    bioValid.value = bioController.text.trim().length <= 40;
    if (bioValid.value) {
      usersCollection.doc(profileId).update({
        'bio': bioController.text,
      });
    }
  }

  void updateShowFollowers(bool showFollowers) {
    logger.i("Updating show followers");
    usersCollection.doc(profileId).update({
      'showFollowers': showFollowers,
    });
  }

  void handleFollowUser() {
    final myuser = Auth().currentUser!.uid;
    isFollowing.value = true;
    followersRef.doc(profileId).collection('userFollowers').doc(myuser).set({});
    followingRef.doc(myuser).collection('userFollowing').doc(profileId).set({});
  }

  void handleUnfollowUser() {
    final myuser = Auth().currentUser!.uid;
    isFollowing.value = false;
    followersRef
        .doc(profileId)
        .collection('userFollowers')
        .doc(myuser)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    followingRef
        .doc(myuser)
        .collection('userFollowing')
        .doc(profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    activityFeedRef
        .doc(profileId)
        .collection('feedItems')
        .doc(myuser)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  Future<void> getFollowers() async {
    try {
      if (profileId.isEmpty) {
        logger.w("getFollowers called with empty profileId");
        followerCount.value = 0;
        gotFollowerCount.value = true;
        return;
      }
      QuerySnapshot snapshot =
          await followersRef.doc(profileId).collection('userFollowers').get();
      followerCount.value = snapshot.docs.length;
      gotFollowerCount.value = true;
    } catch (e, tr) {
      logger.e("Error getting followers: $e");
      logger.e("Stack trace: $tr");
      gotFollowerCount.value =
          true; // Set to true even on error to prevent infinite loading
      rethrow; // Re-throw to be caught by loadData
    }
  }

  Future<void> getFollowing() async {
    try {
      if (profileId.isEmpty) {
        logger.w("getFollowing called with empty profileId");
        followingCount.value = 0;
        gotFollowingCount.value = true;
        return;
      }
      QuerySnapshot snapshot =
          await followingRef.doc(profileId).collection('userFollowing').get();
      followingCount.value = snapshot.docs.length;
      gotFollowingCount.value = true;
    } catch (e, tr) {
      logger.e("Error getting following: $e");
      logger.e("Stack trace: $tr");
      gotFollowingCount.value =
          true; // Set to true even on error to prevent infinite loading
      rethrow; // Re-throw to be caught by loadData
    }
  }

  Future<void> checkIfFollowing() async {
    try {
      if (profileId.isEmpty) {
        logger.w("checkIfFollowing called with empty profileId");
        isFollowing.value = false;
        gotIsFollowing.value = true;
        return;
      }
      final myuser = Auth().currentUser!.uid;
      DocumentSnapshot doc = await followersRef
          .doc(profileId)
          .collection('userFollowers')
          .doc(myuser)
          .get();
      isFollowing.value = doc.exists;
      gotIsFollowing.value = true;
    } catch (e, tr) {
      logger.e("Error checking if following: $e");
      logger.e("Stack trace: $tr");
      gotIsFollowing.value =
          true; // Set to true even on error to prevent infinite loading
      rethrow; // Re-throw to be caught by loadData
    }
  }

  Future<void> setQrCodeRecoverySeen() async {
    userData.value = userData.value.copyWith(setupQrCodeRecovery: true);
    await usersCollection
        .doc(profileId)
        .update({'setup_qr_code_recovery': true});
  }

  Future<void> setWordRecoveryConfirmed() async {
    userData.value = userData.value.copyWith(setupWordRecovery: true);
    await usersCollection.doc(profileId).update({'setup_word_recovery': true});
  }

  Future<void> fetchTaprootAssetsAsync() async {
    isLoading.value = true;
    try {
      List<Asset> fetchedAssets = await listTaprootAssets();
      List<Asset> reversedAssets = fetchedAssets.reversed.toList();
      originalBlockDate = await getBlockTimeStamp(fetchedAssets[0]);
      assets.value = reversedAssets;
      isLoading.value = false;
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
    }
  }

  Future<void> loadMoreMetaAssets(int amt) async {
    try {
      Map<String, AssetMetaResponse> metas = {};
      for (int i = assetMetaMap.length, a = 0;
          i < assets.value.length && a < amt;
          i++) {
        String assetId = assets.value[i].assetGenesis!.assetId ?? '';
        AssetMetaResponse? meta = await fetchAssetMeta(assetId);
        if (meta != null) {
          metas[assetId] = meta;
          a++;
        }
      }
      assetMetaMap.addAll(metas);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<AssetMetaResponse?> loadMetaAsset(String assetId) async {
    try {
      AssetMetaResponse? meta = await fetchAssetMeta(assetId);
      if (meta != null) {
        assetMetaMap[assetId] = meta;
        return meta;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  Future<void> handleProfileImageSelected(AssetEntity image) async {
    File? file = await image.file;
    if (file == null) return;
    TaskSnapshot task =
        await storageRef.child('users/${profileId}/profile.jpg').putFile(file);
    userData.value = userData.value.copyWith(
        profileImageUrl: await task.ref.getDownloadURL(), nft_profile_id: '');
    await usersCollection.doc(profileId).update({
      'profileImageUrl': userData.value.profileImageUrl,
      'nft_profile_id': ''
    });
  }

  Future<void> handleProfileNftSelected(MediaDatePair pair) async {
    if (pair.media == null) return;
    final base64String = pair.media!.data.split(',').last;
    Uint8List imageBytes = base64Decode(base64String);

    TaskSnapshot task = await storageRef
        .child('users/${profileId}/profile.jpg')
        .putData(imageBytes);
    userData.value = userData.value.copyWith(
        profileImageUrl: await task.ref.getDownloadURL(),
        nft_profile_id: pair.assetId);
    await usersCollection.doc(profileId).update({
      'profileImageUrl': userData.value.profileImageUrl,
      'nft_profile_id': '${pair.assetId}'
    });
  }

  Future<void> handleBackgroundImageSelected(AssetEntity image) async {
    File? file = await image.file;
    if (file == null) return;
    TaskSnapshot task = await storageRef
        .child('users/${profileId}/background.jpg')
        .putFile(file);
    userData.value = userData.value.copyWith(
        backgroundImageUrl: await task.ref.getDownloadURL(),
        nft_background_id: '');
    await usersCollection.doc(profileId).update({
      'backgroundImageUrl': userData.value.backgroundImageUrl,
      'nft_background_id': ''
    });
  }

  Future<void> handleBackgroundNftSelected(MediaDatePair pair) async {
    if (pair.media == null) return;
    final base64String = pair.media!.data.split(',').last;
    Uint8List imageBytes = base64Decode(base64String);

    TaskSnapshot task = await storageRef
        .child('users/${profileId}/profile.jpg')
        .putData(imageBytes);
    userData.value = userData.value.copyWith(
        profileImageUrl: await task.ref.getDownloadURL(),
        nft_profile_id: pair.assetId);
    await usersCollection.doc(profileId).update({
      'backgroundImageUrl': userData.value.backgroundImageUrl,
      'nft_profile_id': '${pair.assetId}'
    });
  }

  void socialRecoveryInit() {
    socialRecoveryCollection
        .doc(Get.find<ProfileController>().userData.value.username)
        .get()
        .then((doc) {
      if (doc.exists) {
        Get.find<SettingsController>().initiateSocialRecovery.value = 2;
        Get.find<SettingsController>().pageControllerSocialRecovery =
            PageController(
                initialPage: 3,
                onAttach: (pos) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.find<SettingsController>()
                        .pageControllerSocialRecovery
                        .jumpToPage(3);
                  });
                });
      } else {
        Get.find<SettingsController>().pageControllerSocialRecovery =
            PageController(initialPage: 0);
      }
    }, onError: (_) {
      Get.find<SettingsController>().pageControllerSocialRecovery =
          PageController(initialPage: 0);
    });
  }

  void emailRecoveryInit() {
    emailRecoveryCollection.doc(Auth().currentUser!.uid).get().then((doc) {
      if (doc.exists &&
          doc.data() != null &&
          doc.data()!.containsKey('verified') &&
          doc.data()!['verified']) {
        Get.find<SettingsController>().emailRecoveryState.value = 2;
        Get.find<SettingsController>().pageControllerEmailRecovery =
            PageController(
                initialPage: 2,
                onAttach: (pos) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.find<SettingsController>()
                        .pageControllerEmailRecovery
                        .jumpToPage(2);
                  });
                });
      } else if (doc.exists) {
        Get.find<SettingsController>().emailRecoveryState.value = 1;
        Get.find<SettingsController>().pageControllerEmailRecovery =
            PageController(
                initialPage: 1,
                onAttach: (pos) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.find<SettingsController>()
                        .pageControllerEmailRecovery
                        .jumpToPage(1);
                  });
                });
      } else {
        Get.find<SettingsController>().pageControllerEmailRecovery =
            PageController(initialPage: 0);
      }
    }, onError: (_) {
      Get.find<SettingsController>().pageControllerEmailRecovery =
          PageController(initialPage: 0);
    });
  }

  void wordRecoveryInit() {
    Get.find<SettingsController>().wordRecoveryState.value =
        userData.value.setupWordRecovery ? 2 : 0;
  }

  @override
  void onClose() {
    // Dispose text controllers
    displayNameController.dispose();
    userNameController.dispose();
    bioController.dispose();

    // Dispose focus nodes
    focusNodeDisplayName.dispose();
    focusNodeUsername.dispose();
    focusNodeBio.dispose();

    // Dispose scroll controller
    scrollController.dispose();

    super.onClose();
  }
}
