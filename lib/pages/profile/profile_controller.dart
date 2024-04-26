import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/components/tabs/editprofile.dart';
import 'package:bitnet/components/tabs/wallettab.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  String profileId = "GUsuvr19SPrGELGZtrAq";

  late List<Widget> pages;
  RxInt currentview = 0.obs;
  RxBool isUserLoading = true.obs;
  late UserData userData;

  RxBool? isPrivate;
  RxBool? showFollwers;
  RxString? _profileImage;
  RxString? _backgroundImage;

  //for validation when profile edited
  RxBool usernameValid = true.obs;
  RxBool displayNameValid = true.obs;
  RxBool bioValid = true.obs;

  //check if currentuser follows the displayed person

  RxBool? isFollowing;
  RxBool gotIsFollowing = false.obs;
  //followers
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
  
  bool get profileReady =>
      gotIsFollowing.value == true &&
      gotFollowerCount.value == true &&
      gotFollowingCount.value == true &&
      isUserLoading.value == false;

  @override
  void onInit() {
    print('oninit profile controller');
    super.onInit();
    loadData();
     pages = [
      //PostsProfileTab(
      //profileId: widget.profileId,
      //),
      Container(),
      WalletTab(),
      //den nur wenn eigenes profil also abfrage ob eignes profil anonszten was anders zeigen
      EditProfileTab(),
    ];
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

  addFocusNodeListenerAndUpdate(
    FocusNode focusNode,
    Function() func,
  ) {
    focusNode.addListener(() {
      print("$focusNode has focus: ${focusNode.hasFocus}");
      if (focusNode.hasFocus == false) {
        print("lost focus");
        //final String currentusername = userNameController.text;
        //print(currentusername);
        func();
      }
    });
  }

  //editprofile related stuff

  getUser() async {
    try {
      print('get user ');

      isUserLoading.value = true;

      DocumentSnapshot? doc = await usersCollection.doc(profileId).get();
      userData = UserData.fromDocument(doc);

      //displayName
      displayNameController.text = userData.displayName;
      validDisplayName?.value = userData.displayName;

      //username
      userNameController.text = userData.username;
      validUserName?.value = userData.username;

      //lol später zu bio ändern
      bioController.text = userData.bio;
      validBio?.value = userData.bio;

      //should show followers
      showFollwers?.value = userData.showFollowers;

      //isprivateprofile?

      //should always be valid otherweise will throw error before and not get uploaded
      _backgroundImage?.value = userData.backgroundImageUrl;
      _profileImage?.value = userData.profileImageUrl;

      isUserLoading.value = false;
      print('get user ended');
    } catch (e, tr) {
      print(e);
      print(tr);
    }
  }

  GlobalKey globalKeyQR = new GlobalKey();

  void updateProfilepic() {
    if (true == true) {
      usersCollection.doc(profileId).update({
        'profileImageUrl': _profileImage,
      });
      print('Profilepic updated successfully');
    }
  }

  

  void updateUsername() {
    usersCollection.doc(profileId).update({
      'username': userNameController.text,
    });
    print('username updated successfully');
  }

  void updateDisplayName() {
    displayNameController.text.trim().length < 3 ||
            displayNameController.text.isEmpty
        ? displayNameValid.value = false
        : displayNameValid.value = true;
    if (displayNameValid.value) {
      usersCollection.doc(profileId).update({
        'displayName': displayNameController.text,
      });
      print('displayName updated successfully');
    }
  }

  void updateBackgroundpic() {
    if (true == true) {
      usersCollection.doc(profileId).update({
        'backgroundImageUrl': _backgroundImage,
      });
      print('Background updated successfully');
    }
  }

  void updateBio() {
    //on unselectbio
    bioController.text.trim().length > 40
        ? bioValid.value = false
        : bioValid.value = true;
    if (bioValid.value) {
      usersCollection.doc(profileId).update({
        'bio': bioController.text,
      });
      print('Bio updated successfully');
    }
  }

  void updateShowFollowers(bool showFollowers) {
    if (true == true) {
      usersCollection.doc(profileId).update({
        'showFollowers': showFollowers,
      });
      print('showFollowers updated successfully');
    }
  }

  void handleFollowUser() {
    final myuser = Auth().currentUser!.uid;
    //hier die daten des aktuell users kriegen....

    //UNSICHER OB RICHTIG SO
    isFollowing!.value = true;
    //Make auth user follower ofg another user and update their followers collection
    followersRef.doc(profileId).collection('userFollowers').doc(myuser).set({});
    //PUT THAT USER ON YOUR FOLLOWING COLLECTION (update your followung collection)
    followingRef.doc(myuser).collection('userFollowing').doc(profileId).set({});
    //add activityfeed ITEM for that user to notify about new user

    // activityFeedRef.doc(widget.profileId).collection('feedItems').doc(myuser).set({
    //   'type': 'follow',
    //   'ownerId': widget.profileId,
    //   'username': myuser.did,
    //   'userId': myuser.did,
    //   'userProfileImg': myuser.profileImageUrl,
    //   'timestamp': timestamp,
    // });
  }

  void handleUnfollowUser() {
    final myuser = Auth().currentUser!.uid;
    //UNSICHER OB RICHTIG SO
    isFollowing!.value = false;
    //remove
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
    //PUT THAT USER ON YOUR FOLLOWING COLLECTION (update your followung collection)
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
    //delete activityfeed ITEM for that user to notify about new user
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
      print(gotFollowerCount.value);
      print('getfollowers ended');
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
      print(gotFollowingCount.value);
      print('get following');
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
      print(gotIsFollowing.value);
      print('check if following ');
    } catch (e, tr) {
      print(e);
      print(tr);
    }
  }
}
