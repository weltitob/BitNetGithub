import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/fetchassetmeta.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/list_assets.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/components/tabs/columnviewtab.dart';
import 'package:bitnet/components/tabs/editprofile.dart';
import 'package:bitnet/components/tabs/rowviewtab.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  String profileId = "GUsuvr19SPrGELGZtrAq";

  late List<Widget> pages;
  RxInt currentview = 0.obs;
  RxBool isUserLoading = true.obs;
  RxBool isLoading = true.obs;

  bool assetsLoading = false;

  late UserData userData;

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

  RxString? validDisplayName;
  RxString? validUserName;
  RxString? validBio;

  final focusNodeDisplayName = FocusNode();
  final focusNodeUsername = FocusNode();
  final focusNodeBio = FocusNode();

  RxList<dynamic> assets = <Asset>[].obs;
  RxList<dynamic> assetsLazyLoading = <Asset>[].obs;
  Map<String, AssetMetaResponse> assetMetaMap = {};

  bool get profileReady =>
      gotIsFollowing.value == true &&
          gotFollowerCount.value == true &&
          gotFollowingCount.value == true &&
          isUserLoading.value == false;

  @override
  void onInit() {
    super.onInit();
    loadData();
    pages = [
      ColumnViewTab(),
      RowViewTab(),
      EditProfileTab(),
    ];
    fetchTaprootAssets();
  }

  void fetchTaprootAssets() async {
    isLoading.value = true;
    try {
      List<Asset> fetchedAssets = await listTaprootAssets();
      List<Asset> reversedAssets = fetchedAssets.reversed.toList();
      assets.value = reversedAssets;
      assetsLazyLoading.value = assets.take(10).toList();
      fetchNext20Metas(0, 10); // Load metadata for the first 20 assets
    } catch (e) {
      print('Error: $e');
    }

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
    assetMetaMap.addAll(metas);
    isLoading.value = false;
  }

  loadMoreAssets() async {
    isLoading.value = true;
    if (assetsLazyLoading.length < assets.length) {
      int nextIndex = assetsLazyLoading.length;
      int endIndex = nextIndex + 10;
      List<dynamic> nextAssets = assets.sublist(nextIndex, endIndex > assets.length ? assets.length : endIndex);
      assetsLazyLoading.addAll(nextAssets);
      await fetchNext20Metas(nextIndex, 10); // Load metadata for the next 20 assets
    }
  }

  loadData() async {
    await getUser();
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
      isUserLoading.value = true;
      DocumentSnapshot? doc = await usersCollection.doc(profileId).get();
      userData = UserData.fromDocument(doc);

      displayNameController.text = userData.displayName;
      validDisplayName?.value = userData.displayName;
      userNameController.text = userData.username;
      validUserName?.value = userData.username;
      bioController.text = userData.bio;
      validBio?.value = userData.bio;
      showFollwers?.value = userData.showFollowers;
      _backgroundImage?.value = userData.backgroundImageUrl;
      _profileImage?.value = userData.profileImageUrl;

      isUserLoading.value = false;
    } catch (e, tr) {
      print(e);
      print(tr);
    }
  }

  GlobalKey globalKeyQR = GlobalKey();

  void updateProfilepic() {
    usersCollection.doc(profileId).update({
      'profileImageUrl': _profileImage,
    });
  }

  void updateUsername() {
    usersCollection.doc(profileId).update({
      'username': userNameController.text,
    });
  }

  void updateDisplayName() {
    displayNameValid.value = displayNameController.text.trim().length >= 3;
    if (displayNameValid.value) {
      usersCollection.doc(profileId).update({
        'displayName': displayNameController.text,
      });
    }
  }

  void updateBackgroundpic() {
    usersCollection.doc(profileId).update({
      'backgroundImageUrl': _backgroundImage,
    });
  }

  void updateBio() {
    bioValid.value = bioController.text.trim().length <= 40;
    if (bioValid.value) {
      usersCollection.doc(profileId).update({
        'bio': bioController.text,
      });
    }
  }

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
}
