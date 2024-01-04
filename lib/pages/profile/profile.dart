//move the controller and all the functions here
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/components/tabs/editprofile.dart';
import 'package:bitnet/components/tabs/wallettab.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/profile/profile_view.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<Profile> {

  //String profileId = Auth().currentUser!.uid;
  //String? get profileId => VRouter.of(context).pathParameters['profileId'];
  String profileId = "GUsuvr19SPrGELGZtrAq";

  late List<Widget> pages;
  int currentview = 0;
  bool isUserLoading = true;
  late UserData userData;

  late bool isPrivate;
  late bool showFollwers;
  late String _profileImage;
  late String _backgroundImage;

  //for validation when profile edited
  bool usernameValid = true;
  bool displayNameValid = true;
  bool bioValid = true;

  //check if currentuser follows the displayed person
  late bool isFollowing;

  //followers
  late int followerCount;
  late int followingCount;

  TextEditingController displayNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  late String validDisplayName;
  late String validUserName;
  late String validBio;

  final focusNodeDisplayName = FocusNode();
  final focusNodeUsername = FocusNode();
  final focusNodeBio = FocusNode();

  @override
  void initState() {
    super.initState();
    getUser();
    getFollowers();
    getFollowing();
    checkIfFollowing();
    addFocusNodeListenerAndUpdate(focusNodeUsername, updateUsername);
    addFocusNodeListenerAndUpdate(focusNodeDisplayName, updateDisplayName);
    addFocusNodeListenerAndUpdate(focusNodeBio, updateBio);

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
    setState(() {
      isUserLoading = true;
    });

    DocumentSnapshot? doc = await usersCollection.doc(profileId).get();
    userData = UserData.fromDocument(doc);

    //displayName
    displayNameController.text = userData.displayName;
    validDisplayName = userData.displayName;

    //username
    userNameController.text = userData.username;
    validUserName = userData.username;

    //lol später zu bio ändern
    bioController.text = userData.bio;
    validBio = userData.bio;

    //should show followers
    showFollwers = userData.showFollowers;

    //isprivateprofile?

    //should always be valid otherweise will throw error before and not get uploaded
    _backgroundImage = userData.backgroundImageUrl;
    _profileImage = userData.profileImageUrl;

    setState(() {
      isUserLoading = false;
    });
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

  void pickAvatarMatrix() async {
    final source = !PlatformInfos.isMobile
        ? ImageSource.gallery
        : await showModalActionSheet<ImageSource>(
      context: context,
      title: L10n.of(context)!.changeYourAvatar,
      actions: [
        SheetAction(
          key: ImageSource.camera,
          label: L10n.of(context)!.openCamera,
          isDefaultAction: true,
          icon: Icons.camera_alt_outlined,
        ),
        SheetAction(
          key: ImageSource.gallery,
          label: L10n.of(context)!.openGallery,
          icon: Icons.photo_outlined,
        ),
      ],
    );
    if (source == null) return;
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 512,
      maxHeight: 512,
    );
    setState(() {
      Matrix.of(context).loginAvatar = picked;
    });
  }

  void updateUsername() {
    usersCollection.doc(profileId).update({
      'username': userNameController.text,
    });
    print('username updated successfully');
  }

  void updateDisplayName() {
    setState(() {
      displayNameController.text.trim().length < 3 ||
          displayNameController.text.isEmpty
          ? displayNameValid = false
          : displayNameValid = true;
    });
    if (displayNameValid) {
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
    setState(() {
      bioController.text.trim().length > 40
          ? bioValid = false
          : bioValid = true;
    });
    if (bioValid) {
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
    setState(() {});
  }

  void handleFollowUser() {
    final myuser = Auth().currentUser!.uid;
    //hier die daten des aktuell users kriegen....

    //UNSICHER OB RICHTIG SO
    setState(() {
      isFollowing = true;
    });
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
    setState(() {
      isFollowing = false;
    });
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
    QuerySnapshot snapshot =
    await followersRef.doc(profileId).collection('userFollowers').get();
    setState(() {
      followerCount = snapshot.docs.length;
    });
  }

  void getFollowing() async {
    QuerySnapshot snapshot =
    await followingRef.doc(profileId).collection('userFollowing').get();
    setState(() {
      followingCount = snapshot.docs.length;
    });
  }

  void checkIfFollowing() async {
    final myuser = Auth().currentUser!.uid;

    DocumentSnapshot doc = await followersRef
        .doc(profileId)
        .collection('userFollowers')
        .doc(myuser)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileView(this);
  }
}