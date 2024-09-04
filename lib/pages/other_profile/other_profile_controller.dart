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
import 'package:bitnet/components/tabs/columnviewtab.dart';
import 'package:bitnet/components/tabs/rowviewtab.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class OtherProfileController extends BaseController {
  final String profileId;
  OtherProfileController({required this.profileId});
  late List<Widget> pages;
  RxInt currentview = 0.obs;
  RxBool isUserLoading = true.obs;
  RxBool isLoading = true.obs;

  Rx<bool> assetsLoading = false.obs;

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

  RxString? validDisplayName;
  RxString? validUserName;
  RxString? validBio;

  RxList<dynamic> assets = <Asset>[].obs;
  RxList<dynamic> assetsLazyLoading = <Asset>[].obs;
  Map<String, AssetMetaResponse> assetMetaMap = {};
  DateTime originalBlockDate = DateTime.now();
  bool get profileReady =>
      gotIsFollowing.value == true && gotFollowerCount.value == true && gotFollowingCount.value == true && isUserLoading.value == false;

  @override
  void onInit() {
    super.onInit();
    fetchTaprootAssets();
    scrollController = ScrollController();
    loadData();
    pages = [
      const ColumnViewTab(other: true),
      RowViewTab(other: true),
    ];
  }

  void fetchTaprootAssets() async {
    print('fetch taproot started ');
    isLoading.value = true;
    assetsLoading.value = true;
    try {
      List<Asset> fetchedAssets = await listTaprootAssets();
      List<Asset> reversedAssets = fetchedAssets.reversed.toList();
      assets.value = reversedAssets;
      print('above is the asset value ');

      await fetchNext20Metas(0, 10); // Load metadata for the first 20 assets
      assetsLazyLoading.value = assets.take(10).toList();
      isLoading.value = false;
    } catch (e) {
      print('Error: $e');
    }
    assetsLoading.value = false;
  }

  fetchNext20Metas(int startIndex, int count) async {
    Map<String, AssetMetaResponse> metas = {};
    for (int i = startIndex; i < startIndex + count && i < assets.length; i++) {
      String assetId = assets[i].assetGenesis?.assetId ?? '';
      AssetMetaResponse? meta = await fetchAssetMeta(assetId);
      if (meta != null) {
        metas[assetId] = meta;
      }
    }
    print('above is the asset meta data done value ');

    assetMetaMap.addAll(metas);
  }

  loadMoreAssets() async {
    isLoading.value = true;
    if (assetsLazyLoading.length < assets.length) {
      int nextIndex = assetsLazyLoading.length;
      int endIndex = nextIndex + 10;
      List<dynamic> nextAssets = assets.sublist(nextIndex, endIndex > assets.length ? assets.length : endIndex);
      await fetchNext20Metas(nextIndex, 10); // Load metadata for the next 20 assets
      assetsLazyLoading.addAll(nextAssets);
      isLoading.value = false;
    }
  }

  loadData() async {
    await getUser();
    getFollowers();
    getFollowing();
    checkIfFollowing();
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
    } catch (e, tr) {
      print(e);
      print(tr);
    }
  }

  GlobalKey globalKeyQR = GlobalKey();

  void updateShowFollowers(bool showFollowers) {
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
    followersRef.doc(profileId).collection('userFollowers').doc(myuser).get().then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    followingRef.doc(myuser).collection('userFollowing').doc(profileId).get().then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    activityFeedRef.doc(profileId).collection('feedItems').doc(myuser).get().then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  void getFollowers() async {
    try {
      QuerySnapshot snapshot = await followersRef.doc(profileId).collection('userFollowers').get();
      followerCount?.value = snapshot.docs.length;
      gotFollowerCount.value = true;
    } catch (e, tr) {
      print(e);
      print(tr);
    }
  }

  void getFollowing() async {
    try {
      QuerySnapshot snapshot = await followingRef.doc(profileId).collection('userFollowing').get();
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
      DocumentSnapshot doc = await followersRef.doc(profileId).collection('userFollowers').doc(myuser).get();
      isFollowing?.value = doc.exists;
      gotIsFollowing.value = true;
    } catch (e, tr) {
      print(e);
      print(tr);
    }
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
      for (int i = assetMetaMap.length, a = 0; i < assets.value.length && a < amt; i++) {
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
    TaskSnapshot task = await storageRef.child('users/${profileId}/profile.jpg').putFile(file);
    userData.value = userData.value.copyWith(profileImageUrl: await task.ref.getDownloadURL(), nft_profile_id: '');
    await usersCollection.doc(profileId).update({'profileImageUrl': userData.value.profileImageUrl, 'nft_profile_id': ''});
  }

  Future<void> handleProfileNftSelected(MediaDatePair pair) async {
    if (pair.media == null) return;
    final base64String = pair.media!.data.split(',').last;
    Uint8List imageBytes = base64Decode(base64String);

    TaskSnapshot task = await storageRef.child('users/${profileId}/profile.jpg').putData(imageBytes);
    userData.value = userData.value.copyWith(profileImageUrl: await task.ref.getDownloadURL(), nft_profile_id: pair.assetId);
    await usersCollection.doc(profileId).update({'profileImageUrl': userData.value.profileImageUrl, 'nft_profile_id': '${pair.assetId}'});
  }

  Future<void> handleBackgroundImageSelected(AssetEntity image) async {
    File? file = await image.file;
    if (file == null) return;
    TaskSnapshot task = await storageRef.child('users/${profileId}/background.jpg').putFile(file);
    userData.value = userData.value.copyWith(backgroundImageUrl: await task.ref.getDownloadURL(), nft_background_id: '');
    await usersCollection.doc(profileId).update({'backgroundImageUrl': userData.value.backgroundImageUrl, 'nft_background_id': ''});
  }

  Future<void> handleBackgroundNftSelected(MediaDatePair pair) async {
    if (pair.media == null) return;
    final base64String = pair.media!.data.split(',').last;
    Uint8List imageBytes = base64Decode(base64String);

    TaskSnapshot task = await storageRef.child('users/${profileId}/profile.jpg').putData(imageBytes);
    userData.value = userData.value.copyWith(profileImageUrl: await task.ref.getDownloadURL(), nft_profile_id: pair.assetId);
    await usersCollection
        .doc(profileId)
        .update({'backgroundImageUrl': userData.value.backgroundImageUrl, 'nft_profile_id': '${pair.assetId}'});
  }
}
