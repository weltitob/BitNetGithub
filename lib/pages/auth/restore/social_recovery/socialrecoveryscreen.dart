import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/appbaractions.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/items/userresult.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SocialRecoveryScreen extends StatefulWidget {
  const SocialRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<SocialRecoveryScreen> createState() => _SocialRecoveryScreenState();
}

class _SocialRecoveryScreenState extends State<SocialRecoveryScreen> {
  bool isFinished =
      false; // a flag indicating whether the send process is finished
  bool readyForLogin = false; // a flag indicating wh

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      bool isSuperSmallScreen =
          constraints.maxWidth < AppTheme.isSuperSmallScreen;
      return bitnetScaffold(
          margin: isSuperSmallScreen
              ? EdgeInsets.symmetric(horizontal: 0)
              : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250),
          extendBodyBehindAppBar: true,
          appBar: bitnetAppBar(
              actions: [
                GestureDetector(
                  onTap: () {
                    print("Forwarding to social recovery info sceen...");
                    context.go('/authhome/login/social_recovery/info_social_recovery');
                  },
                    child: AppBarActionButton(
                      iconData: Icons.info_outline_rounded,
                    )
                  ),
              ],
              text: "Social recovery",
              context: context,
              onTap: () {
                context.pop();
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
                          ),
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
                    Container(
                      child: UserResult(
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
                            ),
                      ),
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

                          ),
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
                        ),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Container(
                    alignment: Alignment.center,
                    height: AppTheme.cardPadding * 2.5,
                    width: screenWidth - AppTheme.cardPadding * 2,
                    child: LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 14,
                      title: "RECOVER ACCOUNT",
                      onTap: () {  },
                    )
                  ),
                )),
          ]),
          context: context);
    });
  }
}
