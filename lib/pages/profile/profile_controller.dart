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
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/wallet/notifications/notifications_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class ProfileController extends BaseController {
  late String profileId;

  late List<Widget> pages;
  RxInt currentview = 0.obs;

  RxBool isLoading = true.obs;

  Rx<bool> assetsLoading = false.obs;

  RxBool isUserLoading = true.obs;
  late Rx<UserData> userData;

  RxBool? isPrivate;
  RxBool? showFollwers;
  RxString? _profileImage;
  RxString? _backgroundImage;

  RxBool usernameValid = true.obs;
  RxBool displayNameValid = true.obs;
  RxBool bioValid = true.obs;

  RxBool? isFollowing;
  RxBool gotIsFollowing = false.obs;
  RxInt? followerCount;
  RxInt? followingCount;
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

  RxString? validDisplayName;
  RxString? validUserName;
  RxString? validBio;

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

  @override
  void onInit() {
    super.onInit();
    loadData();
    _setupUsernameListener();
    fetchTaprootAssets();
    scrollController = ScrollController();
    pages = [
      ColumnViewTab(),
      RowViewTab(),
      NotificationsWidget(),
      LikeViewTab(),
      EditProfileTab(),
    ];
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
    logger.i("Getting user id for profile page: ${Auth().currentUser!.uid}");
    QuerySnapshot<Map<String, dynamic>> query = await usersCollection
        .where('did', isEqualTo: Auth().currentUser!.uid)
        .get();
    if (query.docs.isEmpty) {
      profileId = "";
    } else {
      profileId = query.docs.first.id;
    }
  }

  void fetchTaprootAssets() async {
    final logger = Get.find<LoggerService>();
    logger.i('izak: Fetching taproot started...');
    isLoading.value = true;
    assetsLoading.value = true;
    try {
      List<Asset> fetchedAssets = await listTaprootAssets();
      List<Asset> reversedAssets = fetchedAssets.reversed.toList();
      assets.value = reversedAssets;
      logger.i('izak: Above is the asset value');

      await fetchNext20Metas(0, 10); // Load metadata for the first 20 assets
      assetsLazyLoading.value = assets.take(10).toList();
      isLoading.value = false;
    } catch (e) {
      logger.e('izak: Error fetching taproot assets: $e');
    }
    assetsLoading.value = false;
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
    await getUserId();
    await getUser();
    socialRecoveryInit();
    emailRecoveryInit();
    wordRecoveryInit();
    getFollowers();
    getFollowing();
    checkIfFollowing();
    addFocusNodeListenerAndUpdate(focusNodeUsername, updateUsername);
    addFocusNodeListenerAndUpdate(focusNodeDisplayName, updateDisplayName);
    addFocusNodeListenerAndUpdate(focusNodeBio, updateBio);
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
      DocumentSnapshot? doc = await usersCollection.doc(profileId).get();
      userData = UserData.fromDocument(doc).obs;

      displayNameController.text = userData.value.displayName;
      changingDisplayName.value = userData.value.displayName;
      validDisplayName?.value = userData.value.displayName;
      userNameController.text = userData.value.username;
      changingUserName.value = userData.value.username;
      validUserName?.value = userData.value.username;
      bioController.text = userData.value.bio;
      changingBio.value = userData.value.bio;
      validBio?.value = userData.value.bio;
      showFollwers?.value = userData.value.showFollowers;
      _backgroundImage?.value = userData.value.backgroundImageUrl;
      _profileImage?.value = userData.value.profileImageUrl;
      displayNameController.addListener(() {
        changingDisplayName.value = displayNameController.text;
      });
      userNameController.addListener(() {
        changingUserName.value = userNameController.text;
      });
      bioController.addListener(() {
        changingBio.value = bioController.text;
      });
      isUserLoading.value = false;
    } catch (e) {
      logger.e("Error getting user data: $e");
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
    isFollowing!.value = true;
    followersRef.doc(profileId).collection('userFollowers').doc(myuser).set({});
    followingRef.doc(myuser).collection('userFollowing').doc(profileId).set({});
  }

  void handleUnfollowUser() {
    final myuser = Auth().currentUser!.uid;
    isFollowing!.value = false;
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

  void getFollowers() async {
    try {
      QuerySnapshot snapshot =
          await followersRef.doc(profileId).collection('userFollowers').get();
      followerCount?.value = snapshot.docs.length;
      gotFollowerCount.value = true;
    } catch (e, tr) {
      print(e);
      print(tr);
    }
  }

  void getFollowing() async {
    try {
      QuerySnapshot snapshot =
          await followingRef.doc(profileId).collection('userFollowing').get();
      followingCount?.value = snapshot.docs.length;
      gotFollowingCount.value = true;
    } catch (e, tr) {
      print(e);
      print(tr);
    }
  }

  void checkIfFollowing() async {
    try {
      final myuser = Auth().currentUser!.uid;
      DocumentSnapshot doc = await followersRef
          .doc(profileId)
          .collection('userFollowers')
          .doc(myuser)
          .get();
      isFollowing?.value = doc.exists;
      gotIsFollowing.value = true;
    } catch (e, tr) {
      print(e);
      print(tr);
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
}
