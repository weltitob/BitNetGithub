import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/components/container/imagewithtext.dart';
import 'package:BitNet/components/dialogsandsheets/bottom_sheets/settings_bottom_sheet/settings_bottom_sheet.dart';
import 'package:BitNet/components/loaders/loaders.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/buttons/roundedbutton.dart';
import 'package:BitNet/components/container/coinlogo.dart';
import 'package:BitNet/components/dialogsandsheets/bottom_sheets/bottomsheet.dart';
import 'package:BitNet/components/dialogsandsheets/dialogs/dialogs.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:BitNet/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

// Padding(
//   padding: const EdgeInsets.all(32.0),
//   child: Stack(
//     children: [
//       Material(
//         elevation: Theme.of(context)
//                 .appBarTheme
//                 .scrolledUnderElevation ??
//             4,
//         shadowColor:
//             Theme.of(context).appBarTheme.shadowColor,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(
//             color: Theme.of(context).dividerColor,
//           ),
//           borderRadius: BorderRadius.circular(
//             Avatar.defaultSize * 1,
//           ),
//         ),
//         child: Avatar(
//           mxContent: profile?.avatarUrl,
//           name: displayname,
//           size: Avatar.defaultSize * 2.5,
//           fontSize: 18 * 2.5,
//         ),
//       ),
//       // if (profile != null)
//       //   Positioned(
//       //     bottom: 0,
//       //     right: 0,
//       //     child: FloatingActionButton.small(
//       //       onPressed: controller.setAvatarAction,
//       //       heroTag: null,
//       //       child: const Icon(Icons.camera_alt_outlined),
//       //     ),
//       //   ),
//     ],
//   ),
// ),

class ProfileView extends StatefulWidget {

  final ProfileController controller;

  const ProfileView({
    Key? key, required this.controller,
  }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    final myuser = Auth().currentUser!.uid;
    final String currentUserId = widget.controller.profileId!;
    bool isProfileOwner = currentUserId == myuser;
    // final testuser = UserPreferences.myUser;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: widget.controller.isUserLoading
          ? Center(child: dotProgress(context))
          : ListView(
              children: [
                buildProfileHeader(context),
                widget.controller.pages[widget.controller.currentview],
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
        child: widget.controller.currentview != 2
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
    return Column(
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
                      image: NetworkImage(widget.controller.userData.backgroundImageUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.25), BlendMode.dstATop),
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
                          widget.controller.currentview == 2
                              ? buildCountColumn(
                                  context, widget.controller.followingCount, 'Following')
                              : widget.controller.userData.showFollowers
                                  ? buildCountColumn(
                                      context, widget.controller.followingCount, 'Following')
                                  : Container(
                                      width: 100,
                                    ),
                          SizedBox(
                            width: AppTheme.elementSpacing,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: widget.controller.currentview != 2
                                  ? () {
                                      print('follow dagelassen lol');
                                    }
                                  : () {
                                      showDialogueMultipleOptions(
                                        image1: 'assets/images/bitcoin.png',
                                        image2: 'assets/images/bitcoin.png',
                                        image3: 'assets/images/bitcoin.png',
                                        image4: 'assets/images/bitcoin.png',
                                        text1: 'Profilepic',
                                        text2: 'Background',
                                        text3: 'Porfile NFT',
                                        text4: 'Backgr. NFT',
                                        context: context,
                                      );
                                    },
                              child: Stack(
                                children: [
                                  buildImage(widget.controller.userData.profileImageUrl),
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
                          widget.controller.currentview == 2
                              ? buildCountColumn(
                                  context, widget.controller.followerCount, 'Followers')
                              : widget.controller.userData.showFollowers
                                  ? buildCountColumn(
                                      context, widget.controller.followerCount, 'Followers')
                                  : Container(
                                      width: 100,
                                    ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.elementSpacing / 2),
                      buildUserInformation(
                        widget.controller.userData.username,
                        widget.controller.userData.displayName,
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
      child: widget.controller.currentview == 2
          ? Align(
              child: IconButton(
                  color: AppTheme.white90,
                  onPressed: () {
                    setState(() {
                      widget.controller.showFollwers = !widget.controller.showFollwers;
                      widget.controller.updateShowFollowers(widget.controller.showFollwers);
                    });
                  },
                  icon: Icon(
                    widget.controller.showFollwers ? Icons.remove_red_eye_rounded : Icons.cancel,
                  )),
            )
          : Container(),
    );
  }

  Widget buildEditEyeLeft() {
    return Positioned(
      top: 165,
      left: 57,
      child: widget.controller.currentview == 2
          ? Align(
              child: IconButton(
                  color: AppTheme.white90,
                  onPressed: () {
                    setState(() {
                      widget.controller.showFollwers = ! widget.controller.showFollwers;
                      widget.controller.updateShowFollowers(widget.controller.showFollwers);
                    });
                  },
                  icon: Icon(
                    widget.controller.showFollwers ? Icons.remove_red_eye_rounded : Icons.cancel,
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
              isGlassmorph: true,
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
            isGlassmorph: true,
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
            key: widget.controller.globalKeyQR,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(AppTheme.cardPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppTheme.cardRadiusSmall),
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.elementSpacing),
                    child: PrettyQr(
                      typeNumber: 5,
                      size: AppTheme.cardPadding * 10,
                      data: 'did: ${widget.controller.userData.did}',
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
            color: widget.controller.currentview == index
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
    final String currentUserId = widget.controller.profileId!;

    bool isProfileOwner = currentUserId == userData.did;

    return Positioned(
      bottom: AppTheme.cardPadding,
      child: Container(
        height: AppTheme.cardPadding * 1.75,
        width: AppTheme.cardPadding * 10,
        decoration: BoxDecoration(
          borderRadius: AppTheme.cardRadiusBigger,
          boxShadow: [
            AppTheme.boxShadowProfile
          ],
        ),
        child: GlassContainer(
          borderThickness: 1.5, // remove border if not active
          blur: 50,
          opacity: 0.1,
          borderRadius: AppTheme.cardRadiusBigger,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCenterWidgetIcon(
                iconData: Icons.table_rows_rounded,
                index: 0,
                onTap: () => setState(() {
                  widget.controller.currentview = 0;
                }),
              ),
              buildCenterWidgetIcon(
                iconData: Icons.wallet,
                index: 1,
                onTap: () => setState(() {
                  widget.controller.currentview = 1;
                }),
              ),
              GestureDetector(
                  onTap: () => setState(() {
                    widget.controller.currentview = 2;
                      }),
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Colors.greenAccent[700],
                        borderRadius: AppTheme.cardRadiusSmall),
                    child: Icon(
                      isProfileOwner ? Icons.edit : Icons.person_add_rounded,
                      size: AppTheme.iconSize,
                      color: widget.controller.currentview == 2
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
      ),
    );
  }

  Widget buildImage(String imagePath) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: widget.controller.currentview != 2
            ? LinearGradient(colors: [
                Color.fromRGBO(199, 77, 77, 1.0),
                Color.fromRGBO(242, 169, 0, 1.0),
              ])
            : LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary
              ]),
        borderRadius: AppTheme.cardRadiusBigger * 1.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.elementSpacing / 4),
        child: ClipRRect(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: AppTheme.cardRadiusBigger * 1.5,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusBigger * 1.5,
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
      widget.controller.isUserLoading
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
                        .headlineMedium!
                        .copyWith(color: AppTheme.white90),
                  ),
                  SizedBox(
                    height: AppTheme.elementSpacing / 4,
                  ),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
              focusNode: widget.controller.focusNodeUsername,
              readOnly: widget.controller.currentview == 2 ? false : true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                isDense: true,
                border: InputBorder.none,
                errorText: widget.controller.displayNameValid
                    ? null
                    : 'Bad characters', // Add this line
              ),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppTheme.white70,
                  ),
              controller: widget.controller.userNameController,
            ),
            const SizedBox(height: AppTheme.cardPadding),
            TextField(
              focusNode: widget.controller.focusNodeDisplayName,
              readOnly: widget.controller.currentview == 2 ? false : true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  isDense: true,
                  border: InputBorder.none,
                  errorText:
                  widget.controller.displayNameValid ? null : "Couldn't change username"),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppTheme.white90),
              controller: widget.controller.displayNameController,
            ),
            TextField(
              focusNode: widget.controller.focusNodeBio,
              readOnly: widget.controller.currentview == 2 ? false : true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                border: InputBorder.none,
                isDense: true,
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppTheme.white70),
              controller: widget.controller.bioController,
            ),
            const SizedBox(height: AppTheme.elementSpacing / 2),
          ],
        ),
      );
}
