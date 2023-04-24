import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/buttons/roundedbutton.dart';
import 'package:BitNet/components/container/coinlogo.dart';
import 'package:BitNet/components/dialogsandsheets/bottomsheet.dart';
import 'package:BitNet/components/dialogsandsheets/dialogs.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:BitNet/models/userwallet.dart';
import 'package:BitNet/pages/settings/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final String profileId;
  Profile({required this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late List<Widget> pages;
  int currentview = 0;
  bool isUserLoading = true;
  late UserData userData;

  late bool _isPrivate;
  late bool _showFollwers;
  late String _profileImage;
  late String _backgroundImage;

  //for validation when profile edited
  bool _usernameValid = true;
  bool _displayNameValid = true;
  bool _bioValid = true;

  //check if currentuser follows the displayed person
  late bool isFollowing;

  //followers
  late int followerCount;
  late int followingCount;

  TextEditingController displayNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  late String _validDisplayName;
  late String _validUserName;
  late String _validBio;

  final _focusNodeDisplayName = FocusNode();
  final _focusNodeUsername = FocusNode();
  final _focusNodeBio = FocusNode();

  @override
  void initState() {
    super.initState();
    getUser();
    getFollowers();
    getFollowing();
    checkIfFollowing();
    addFocusNodeListenerAndUpdate(_focusNodeUsername, updateUsername);
    addFocusNodeListenerAndUpdate(_focusNodeDisplayName, updateDisplayName);
    addFocusNodeListenerAndUpdate(_focusNodeBio, updateBio);

    pages = [
      //PostsProfileTab(
        //profileId: widget.profileId,
      //),
      //WalletTab(),
      //den nur wenn eigenes profil also abfrage ob eignes profil anonszten was anders zeigen
      //EditProfileTab(),
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

    DocumentSnapshot? doc = await usersCollection.doc(widget.profileId).get();
    UserData user = UserData.fromDocument(doc);

    //displayName
    displayNameController.text = user.displayName;
    _validDisplayName = user.displayName;

    //username
    userNameController.text = user.username;
    _validUserName = user.username;

    //lol später zu bio ändern
    bioController.text = user.profileImageUrl;
    _validBio = user.profileImageUrl;

    //should show followers
    _showFollwers = user.showFollowers;

    //isprivateprofile?

    //should always be valid otherweise will throw error before and not get uploaded
    _backgroundImage = user.backgroundImageUrl;
    _profileImage = user.profileImageUrl;

    setState(() {
      isUserLoading = false;
    });
  }

  void updateProfilepic() {
    if (true == true) {
      usersCollection.doc(widget.profileId).update({
        'profileImageUrl': _profileImage,
      });
      print('Profilepic updated successfully');
    }
  }

  void updateUsername() {
    usersCollection.doc(widget.profileId).update({
      'username': userNameController.text,
    });
    print('username updated successfully');
  }

  void updateDisplayName() {
    setState(() {
      displayNameController.text.trim().length < 3 ||
              displayNameController.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;
    });
    if (_displayNameValid) {
      usersCollection.doc(widget.profileId).update({
        'displayName': displayNameController.text,
      });
      print('displayName updated successfully');
    }
  }

  void updateBackgroundpic() {
    if (true == true) {
      usersCollection.doc(widget.profileId).update({
        'backgroundImageUrl': _backgroundImage,
      });
      print('Background updated successfully');
    }
  }

  void updateBio() {
    //on unselectbio
    setState(() {
      bioController.text.trim().length > 40
          ? _bioValid = false
          : _bioValid = true;
    });
    if (_bioValid) {
      usersCollection.doc(widget.profileId).update({
        'bio': bioController.text,
      });
      print('Bio updated successfully');
    }
  }

  void updateShowFollowers(bool showFollowers) {
    if (true == true) {
      usersCollection.doc(widget.profileId).update({
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
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(myuser)
        .set({});
    //PUT THAT USER ON YOUR FOLLOWING COLLECTION (update your followung collection)
    followingRef
        .doc(myuser)
        .collection('userFollowing')
        .doc(widget.profileId)
        .set({});
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
        .doc(widget.profileId)
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
        .doc(widget.profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //delete activityfeed ITEM for that user to notify about new user
    activityFeedRef
        .doc(widget.profileId)
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
    QuerySnapshot snapshot = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .get();
    setState(() {
      followerCount = snapshot.docs.length;
    });
  }

  void getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .doc(widget.profileId)
        .collection('userFollowing')
        .get();
    setState(() {
      followingCount = snapshot.docs.length;
    });
  }

  void checkIfFollowing() async {
    final myuser = Auth().currentUser!.uid;

    DocumentSnapshot doc = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(myuser)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  GlobalKey globalKeyQR = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final myuser = Auth().currentUser!.uid;
    final String currentUserId = widget.profileId;

    bool isProfileOwner = currentUserId == myuser;

    // final testuser = UserPreferences.myUser;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: [
          buildProfileHeader(context),
          pages[currentview],
          // ProfilePosts(userId: currentUserId),
        ],
      ),
    );
  }

  Widget buildProfileButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Material(
        color: Colors.transparent,
        child: currentview != 2
            ? CoinLogoWidgetSmall(coinid: 1)
            : Container(
                width: 30.0,
                height: 30.0,
                color: Theme.of(context).colorScheme.primary,
                child: Center(
                  child: Icon(
                    Icons.edit,
                    size: 20.0,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildProfileHeader(context) {
    return isUserLoading
        ? dotProgress(context)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: Alignment.center, children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          boxShadow: [AppTheme.boxShadowProfile],
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://crops.giga.de/ed/5d/94/f19c187e579eefbff80498fcc1_YyAzMTU4eDE3NzcrMjErODMCcmUgMTYwMCAxMjAwA2VkZmM3N2VmMDhj.jpg'),
                            fit: BoxFit.fitHeight,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.dstATop),
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: AppTheme.cornerRadiusBig,
                              bottomRight: AppTheme.cornerRadiusBig),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: AppTheme.cardPadding * 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                currentview == 2
                                    ? buildCountColumn(
                                        context, followingCount, 'Following')
                                    : userData.showFollowers
                                        ? buildCountColumn(context,
                                            followingCount, 'Following')
                                        : Container(
                                            width: 100,
                                          ),
                                SizedBox(
                                  width: AppTheme.elementSpacing,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: currentview != 2
                                        ? () {
                                            print('follow dagelassen lol');
                                          }
                                        : () {
                                            print('wtf');
                                            showDialogueMultipleOptions(
                                              image1: '',
                                              image2: '',
                                              image3: '',
                                              image4: '',
                                              text1: 'Profilepic',
                                              text2: 'Background',
                                              text3: 'Porfile NFT',
                                              text4: 'Backgr. NFT',
                                              context: context,
                                            );
                                          },
                                    child: Stack(
                                      children: [
                                        buildImage(userData.profileImageUrl),
                                        Positioned(
                                          bottom: 0,
                                          right: 4,
                                          child: buildProfileButton(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: AppTheme.elementSpacing,
                                ),
                                currentview == 2
                                    ? buildCountColumn(
                                        context, followerCount, 'Followers')
                                    : userData.showFollowers
                                        ? buildCountColumn(
                                            context, followerCount, 'Followers')
                                        : Container(
                                            width: 100,
                                          ),
                              ],
                            ),
                            const SizedBox(height: AppTheme.elementSpacing),
                            buildUserInformation(
                              userData.username,
                              userData.displayName,
                            ),
                            const SizedBox(height: AppTheme.cardPadding * 2),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ]),
                buildSettingsButton(),
                buildQRButton(),
                buildEditEyeLeft(),
                buildEditEyeRight(),
                buildCenterWidget(),
              ]),
            ],
          );
  }

  Widget buildEditEyeRight() {
    return Positioned(
      top: 165,
      right: 57,
      child: currentview == 2
          ? Align(
              child: IconButton(
                  color: AppTheme.white90,
                  onPressed: () {
                    setState(() {
                      _showFollwers = !_showFollwers;
                      updateShowFollowers(_showFollwers);
                    });
                  },
                  icon: Icon(
                    _showFollwers ? Icons.remove_red_eye_rounded : Icons.cancel,
                  )),
            )
          : Container(),
    );
  }

  Widget buildEditEyeLeft() {
    return Positioned(
      top: 165,
      left: 57,
      child: currentview == 2
          ? Align(
              child: IconButton(
                  color: AppTheme.white90,
                  onPressed: () {
                    setState(() {
                      _showFollwers = !_showFollwers;
                      updateShowFollowers(_showFollwers);
                    });
                  },
                  icon: Icon(
                    _showFollwers ? Icons.remove_red_eye_rounded : Icons.cancel,
                  )),
            )
          : Container(),
    );
  }

  Widget buildSettingsButton() {
    return Positioned(
      top: AppTheme.elementSpacing,
      right: AppTheme.elementSpacing,
      child: Align(
        child: Padding(
            padding: const EdgeInsets.only(
              right: AppTheme.cardPadding,
              top: AppTheme.cardPadding,
            ),
            child: RoundedButtonWidget(
              isGlassmorph: false,
              iconData: Icons.brightness_low_rounded,
              onTap: () {
                showSettingsBottomSheet(context: context);
              },
            )),
      ),
    );
  }

  Widget buildQRButton() {
    return Positioned(
      top: AppTheme.elementSpacing,
      left: AppTheme.elementSpacing,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppTheme.cardPadding, top: AppTheme.cardPadding),
          child: RoundedButtonWidget(
            iconData: Icons.qr_code_rounded,
            onTap: () {
              onQRButtonPressed();
              // print("Hello world");
              // Navigator.push(context, MaterialPageRoute<void>(
              //   builder: (BuildContext context) {
              //     return Scaffold(
              //       body: QR_codepage(),
              //     );
              //   },
              // ));
            },
            isGlassmorph: false,
          ),
        ),
      ),
    );
  }

  void onQRButtonPressed() {
    showModalBottomSheetWidget(
        goBack: false,
        context: context,
        height: 450.0,
        title: "Share Profile",
        iconData: Icons.qr_code_rounded,
        child: Center(
          child: RepaintBoundary(
            key: globalKeyQR,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(AppTheme.cardPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppTheme.cardRadiusSmall),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PrettyQr(
                      image: AssetImage('assets/images/ion_baw.png'),
                      typeNumber: 3,
                      size: 240,
                      data: 'test',
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  buildCenterWidgetIcon({
    required IconData iconData,
    required int index,
    required Function() onTap,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.greenAccent[700],
            borderRadius: AppTheme.cardRadiusBig,
          ),
          child: Icon(
            iconData,
            size: AppTheme.iconSize,
            color: currentview == index
                ? Theme.of(context).colorScheme.onSecondaryContainer
                : Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.3),
          ),
        ));
  }

  Widget buildCenterWidget() {
    final userData = Provider.of<UserData>(context, listen: false);
    final String currentUserId = widget.profileId;

    bool isProfileOwner = currentUserId == userData.did;

    return Positioned(
      bottom: 20,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: 40,
        width: 220,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 2.5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCenterWidgetIcon(
              iconData: Icons.table_rows_rounded,
              index: 0,
              onTap: () => setState(() {
                currentview = 0;
              }),
            ),
            buildCenterWidgetIcon(
              iconData: Icons.wallet,
              index: 1,
              onTap: () => setState(() {
                currentview = 1;
              }),
            ),
            GestureDetector(
                onTap: () => setState(() {
                      currentview = 2;
                    }),
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.greenAccent[700],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Icon(
                    isProfileOwner ? Icons.edit : Icons.person_add_rounded,
                    size: AppTheme.iconSize,
                    color: currentview == 2
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer
                            .withOpacity(0.3),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String imagePath) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: currentview != 2
            ? LinearGradient(colors: [
                Color.fromRGBO(199, 77, 77, 1.0),
                Color.fromRGBO(242, 169, 0, 1.0),
              ])
            : LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary
              ]),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(45.0),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                  image: DecorationImage(
                    image: NetworkImage(imagePath == ''
                        ? 'http://ev-evgym.at/wp-content/uploads/2018/12/240_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg'
                        : imagePath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCountColumn(BuildContext context, int count, String label) =>
      isUserLoading
          ? Container()
          : MaterialButton(
              shape:
                  RoundedRectangleBorder(borderRadius: AppTheme.cardRadiusMid),
              onPressed: () {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: AppTheme.elementSpacing / 4,
                  ),
                  Text(
                    count.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: AppTheme.white90),
                  ),
                  SizedBox(
                    height: AppTheme.elementSpacing / 4,
                  ),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppTheme.white70, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: AppTheme.elementSpacing / 4,
                  ),
                ],
              ),
            );

  Widget buildUserInformation(String username, String displayName) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
        child: Column(
          children: [
            TextField(
              focusNode: _focusNodeDisplayName,
              readOnly: currentview == 2 ? false : true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  //changeup!!
                  errorText: _displayNameValid ? null : 'Bad characters'),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppTheme.white70,
                  ),
              controller: displayNameController,
            ),
            const SizedBox(height: AppTheme.elementSpacing),
            TextField(
              focusNode: _focusNodeUsername,
              readOnly: currentview == 2 ? false : true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  errorText:
                      _displayNameValid ? null : "Couldn't change username"),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppTheme.white90),
              controller: userNameController,
            ),
            TextField(
              focusNode: _focusNodeBio,
              readOnly: currentview == 2 ? false : true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppTheme.white70),
              controller: bioController,
            ),
            const SizedBox(height: AppTheme.elementSpacing / 2),
          ],
        ),
      );
}
