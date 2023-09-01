import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/bitnetAppBar.dart';
import 'package:bitnet/components/appstandards/bitnetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/userresult.dart';
import 'package:bitnet/components/swipebutton/swipeable_button_view.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class SocialRecoveryScreen extends StatefulWidget {
  const SocialRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<SocialRecoveryScreen> createState() => _SocialRecoveryScreenState();
}

class _SocialRecoveryScreenState extends State<SocialRecoveryScreen> {

  bool isFinished = false; // a flag indicating whether the send process is finished
  bool readyForLogin = false; // a flag indicating wh

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
            actions: [
              GestureDetector(
                onTap: () {
                  print("Forwarding to social recovery info sceen...");
                  VRouter.of(context).to('/info_social_recovery');
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: AppTheme.elementSpacing,
                    bottom: AppTheme.elementSpacing,
                    right: AppTheme.elementSpacing * 1.5,
                    left: AppTheme.elementSpacing * 0.5,
                  ),
                  child: GlassContainer(
                      borderThickness: 4, // remove border if not active
                      blur: 50,
                      opacity: 0.1,
                      borderRadius: AppTheme.cardRadiusCircular,
                      child: Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: AppTheme.white90,
                            size: AppTheme.cardPadding * 1,
                          ),
                        ),
                      )),
                ),
              ),
            ],
            text: "Social recovery",
            context: context,
            onTap: () {
              VRouter.of(context).pop();
            }),
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding,
                  vertical: AppTheme.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: AppTheme.cardPadding * 3,
                  ),
                  Text(
                    "Recovery account",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    height: AppTheme.cardPadding,
                  ),
                  UserResult(
                    onTap: () async {
                      print("Test");
                    },
                    onDelete: () {},
                    userData: UserData(
                        backgroundImageUrl: "",
                        isPrivate: false,
                        showFollowers: true,
                        did: "did",
                        displayName: "displayName",
                        bio: "bio",
                        customToken: "customToken",
                        username: "username",
                        profileImageUrl: "profileImageUrl",
                        createdAt: Timestamp.fromMicrosecondsSinceEpoch(20),
                        updatedAt: Timestamp.fromMicrosecondsSinceEpoch(20),
                        isActive: true,
                        dob: 10,
                        mainWallet: UserWallet(
                            walletAddress: "walletAddress",
                            walletType: "walletType",
                            walletBalance: "walletBalance",
                            privateKey: "privateKey",
                            userdid: "userdid"),
                        wallets: []),
                  ),
                  Container(
                    height: AppTheme.elementSpacing,
                  ),
                  Text(
                    "Contact your friends and tell them to free-up your key! The free-ups will only be valid for 24 hours. After their keys are freed up the login sign will appear green and you'll have to wait additional 24hours before you can login to your recovered account.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Container(
                    height: AppTheme.cardPadding * 2,
                  ),
                  Text(
                    "Friends / Key-Issuers",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Container(
                    height: AppTheme.cardPadding,
                  ),
                  UserResult(
                    onTap: () async {
                      print("Test");
                    },
                    onDelete: () {},
                    userData: UserData(
                        backgroundImageUrl: "",
                        isPrivate: false,
                        showFollowers: true,
                        did: "did",
                        displayName: "displayName",
                        bio: "bio",
                        customToken: "customToken",
                        username: "username",
                        profileImageUrl: "profileImageUrl",
                        createdAt: Timestamp.fromMicrosecondsSinceEpoch(20),
                        updatedAt: Timestamp.fromMicrosecondsSinceEpoch(20),
                        isActive: true,
                        dob: 10,
                        mainWallet: UserWallet(
                            walletAddress: "walletAddress",
                            walletType: "walletType",
                            walletBalance: "walletBalance",
                            privateKey: "privateKey",
                            userdid: "userdid"),
                        wallets: []),
                  ),
                  Container(
                    height: AppTheme.elementSpacing,
                  ),
                  UserResult(
                    onTap: () async {
                      print("Test");
                    },
                    onDelete: () {},
                    userData: UserData(
                        backgroundImageUrl: "",
                        isPrivate: false,
                        showFollowers: true,
                        did: "did",
                        displayName: "displayName",
                        bio: "bio",
                        customToken: "customToken",
                        username: "username",
                        profileImageUrl: "profileImageUrl",
                        createdAt: Timestamp.fromMicrosecondsSinceEpoch(20),
                        updatedAt: Timestamp.fromMicrosecondsSinceEpoch(20),
                        isActive: true,
                        dob: 10,
                        mainWallet: UserWallet(
                            walletAddress: "walletAddress",
                            walletType: "walletType",
                            walletBalance: "walletBalance",
                            privateKey: "privateKey",
                            userdid: "userdid"),
                        wallets: []),
                  ),
                  Container(
                    height: AppTheme.elementSpacing,
                  ),
                  UserResult(
                    onTap: () async {
                      print("Test");
                    },
                    onDelete: () {},
                    userData: UserData(
                        backgroundImageUrl: "",
                        isPrivate: false,
                        showFollowers: true,
                        did: "did",
                        displayName: "displayName",
                        bio: "bio",
                        customToken: "customToken",
                        username: "username",
                        profileImageUrl: "profileImageUrl",
                        createdAt: Timestamp.fromMicrosecondsSinceEpoch(20),
                        updatedAt: Timestamp.fromMicrosecondsSinceEpoch(20),
                        isActive: true,
                        dob: 10,
                        mainWallet: UserWallet(
                            walletAddress: "walletAddress",
                            walletType: "walletType",
                            walletBalance: "walletBalance",
                            privateKey: "privateKey",
                            userdid: "userdid"),
                        wallets: []),
                  ),
                  Container(
                    height: AppTheme.cardPadding,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: AppTheme.cardPadding * 2,
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: SwipeableButtonView(
                // Determine if the button should be active based on whether a receiver has been selected
                isActive: false,
                // Set the text style for the button text
                buttontextstyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                        color: AppTheme.white80,
                        shadows: [AppTheme.boxShadowSmall]),
                // Set the text to display on the button
                buttonText: "Unlock account",
                // Set the widget to display inside the button
                buttonWidget: Container(
                  child: Icon(
                    // Set the icon to display based on whether a receiver has been selected
                    readyForLogin
                        ? Icons.double_arrow_rounded
                        : Icons.lock_outline_rounded,
                    color: AppTheme.white90,
                    size: 33,
                    shadows: [AppTheme.boxShadowProfile],
                  ),
                ),
                // Set the active and disabled colors for the button
                activeColor: Theme.of(context).primaryColor,
                disableColor: Theme.of(context).primaryColor,
                // Determine whether the button has finished its operation
                isFinished: isFinished,
                // Define the function to execute while the button is in a waiting state
                onWaitingProcess: () {
                  // Wait for 2 seconds, then set isFinished to true
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      isFinished = true;
                    });
                  });
                },
                // Define the function to execute when the button is finished
                onFinish: () async {
                  // Check if biometric authentication is available
                }),
          )),
        ]),
        context: context);
  }
}
