import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetShaderMask.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/container/fadein.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/container/randomcontainers/randomavatarcontainer.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/components/items/usersearchresult.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vrouter/vrouter.dart';

class PageFooter extends StatefulWidget {
  final WebsiteLandingPageController controller;
  const PageFooter({super.key, required this.controller});

  @override
  State<PageFooter> createState() => _PageFooterState();
}

class _PageFooterState extends State<PageFooter> {
  PageController _pageController = PageController();
  GlobalKey<FadeInState> fadeInKey = GlobalKey<FadeInState>();
  int _selectedindex = 0;
  bool _isThirdAnimationCompleted = false;

  @override
  void dispose() {
    _pageController.dispose(); // Don't forget to dispose the PageController
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
      bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

      double textWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 16
              : AppTheme.cardPadding * 22
          : AppTheme.cardPadding * 24;
      double subtitleWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 14
              : AppTheme.cardPadding * 18
          : AppTheme.cardPadding * 22;
      double spacingMultiplier = isMidScreen
          ? isSmallScreen
              ? 0.5
              : 0.75
          : 1;
      double centerSpacing = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding
              : AppTheme.columnWidth * 0.65
          : AppTheme.columnWidth;

      return Container(
          color: Theme.of(context).colorScheme.background,
          child: Stack(children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.25),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.75),
                        Colors.black,
                      ],
                    ),
                  ),
                )),
            isSmallScreen
                ? Container()
                : Stack(
                    children: [
                      _isThirdAnimationCompleted
                          ? Container()
                          : FadeIn(
                              delay: Duration(milliseconds: 1200),
                              duration: Duration(seconds: 2),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: AppTheme.cardPadding * 10 * spacingMultiplier + 180,
                                    left: 850 - AppTheme.cardPadding,
                                  ),
                                  child: quoteText(),
                                ),
                              ),
                            ),
                      _isThirdAnimationCompleted
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: AppTheme.cardPadding *
                                      6.5 *
                                      spacingMultiplier,
                                ),
                                width: 850 + AppTheme.cardPadding * 10,
                                height: 400,
                                child: RandomAvatarWidget(
                                  start: false,
                                  width: 850 + AppTheme.cardPadding * 10,
                                  height: 400,
                                ),
                              ),
                            )
                          : Container(),
                      FadeIn(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: AppTheme.cardPadding * 10 * spacingMultiplier,
                            ),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  VRouter.of(context).to("/register");
                                },
                                child: GlassContainer(
                                  borderThickness:
                                      1.5, // remove border if not active
                                  blur: 50,
                                  opacity: 0.1,
                                  borderRadius: BorderRadius.circular(240 / 3.5),
                                  child: Container(
                                    width: 850,
                                    height: 240,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 850,
                                          height: 240,
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                AppTheme.cardPadding,
                                            vertical: AppTheme.cardPadding * 2.25,
                                          ),
                                          child: _isThirdAnimationCompleted
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  child: BitNetShaderMask(
                                                    child: AnimatedTextKit(
                                                      isRepeatingAnimation:
                                                          false,
                                                      animatedTexts: [
                                                        TypewriterAnimatedText(
                                                          '"We take it in our own hands!"',
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white, // This color will be replaced by the gradient effect
                                                                  ),
                                                          speed: const Duration(
                                                              milliseconds: 50),
                                                        ),
                                                        TypewriterAnimatedText(
                                                          'Join BitNet now!',
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white, // This color will be replaced by the gradient effect
                                                                  ),
                                                          speed: const Duration(
                                                              milliseconds: 50),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : HorizontalFadeListView(
                                                child: PageView.builder(
                                                    controller: _pageController,
                                                    onPageChanged: (index) {
                                                      setState(() {
                                                        _selectedindex = index;
                                                      });
                                                      // Restart the FadeIn animation
                                                      fadeInKey.currentState
                                                          ?.restartAnimation();
                                                    },
                                                    itemCount:
                                                    widget.controller.pageDataList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 1.25),
                                                        child: Column(
                                                          children: [
                                                            _buildTypewriterText(
                                                                widget.controller.pageDataList[index]
                                                                    .text, () {
                                                              if (index <
                                                                  widget.controller.pageDataList
                                                                          .length -
                                                                      1) {
                                                                Future.delayed(
                                                                    const Duration(
                                                                        milliseconds:
                                                                            2000),
                                                                    () {
                                                                  _pageController
                                                                      .nextPage(
                                                                    duration:
                                                                        const Duration(
                                                                            milliseconds:
                                                                                300),
                                                                    curve: Curves
                                                                        .easeInOut,
                                                                  );
                                                                });
                                                              }
                                                            }),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                              ),
                                        ),
                                        _isThirdAnimationCompleted
                                            ? Container()
                                            : Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                      bottom:
                                                          AppTheme.cardPadding *
                                                              1 *
                                                              spacingMultiplier,
                                                    ),
                                                    child: buildIndicator(
                                                      dotHeight: AppTheme
                                                          .elementSpacing,
                                                      dotWidth: AppTheme
                                                          .elementSpacing,
                                                      pageController:
                                                          _pageController,
                                                      count: 3,
                                                    )),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _isThirdAnimationCompleted
                          ? Container()
                          : FadeIn(
                              delay: Duration(milliseconds: 1200),
                              duration: Duration(seconds: 2),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: AppTheme.cardPadding *
                                        7.75 *
                                        spacingMultiplier,
                                    right: 850 - AppTheme.cardPadding,
                                  ),
                                  child: quoteText(),
                                ),
                              ),
                            ),
                      _isThirdAnimationCompleted
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: AppTheme.cardPadding *
                                      6.5 *
                                      spacingMultiplier,
                                ),
                                width: 850 + AppTheme.cardPadding * 10,
                                height: 400,
                                child: RandomAvatarWidget(
                                  start: true,
                                  width: 850 + AppTheme.cardPadding * 10,
                                  height: 400,
                                ),
                              ),
                            )
                          : Container(),
                      _isThirdAnimationCompleted
                          ? Container()
                          : FadeIn(
                              key: fadeInKey,
                              delay: Duration(milliseconds: 500),
                              duration: Duration(seconds: 2),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: AppTheme.cardPadding *
                                        7.5 *
                                        spacingMultiplier,
                                  ),
                                  child: _buildUserSearchResult(
                                      widget.controller.pageDataList[_selectedindex].userData),
                                ),
                              ),
                            ),
                    ],
                  ),
            buildFooter(
                context, centerSpacing, spacingMultiplier, isSmallScreen),
          ]));
    });
  }

  Widget quoteText() {
    return Text(
      '"',
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 170,
            fontFamily: GoogleFonts.lobster().fontFamily,
            color: AppTheme
                .colorBitcoin, // This color will be replaced by the gradient effect
          ),
    );
  }

  Widget _buildTypewriterText(String text, VoidCallback onCompleted) {
    return Container(
      child: AnimatedTextKit(
        totalRepeatCount: 1,
        //pause: const Duration(milliseconds: 4000),
        animatedTexts: [
          TypewriterAnimatedText(
            text,
            textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppTheme.white90,
                ),
            speed: const Duration(milliseconds: 50),
            textAlign: TextAlign.center,
          ),
        ],
        onFinished: () {
          if (_selectedindex == 2) {
            // Assuming the pages are 0-indexed and the third page is index 2
            onCompleted();
            setState(() {
              _isThirdAnimationCompleted = true;
            });
          } else {
            onCompleted();
          }
        }, // Call the callback when the animation is finished
      ),
    );
  }

  Widget _buildUserSearchResult(UserData userData) {
    return UserSearchResult(
      scaleRatio: 1.2,
      onTap: () {
        print("User selected: ${userData.displayName}");
      },
      userData: UserData(
        backgroundImageUrl: userData.backgroundImageUrl,
        isPrivate: userData.isPrivate,
        showFollowers: userData.showFollowers,
        did: userData.did,
        displayName: userData.displayName,
        bio: userData.bio,
        customToken: userData.customToken,
        username: userData.username,
        profileImageUrl: userData.profileImageUrl,
        createdAt: userData.createdAt,
        updatedAt: userData.updatedAt,
        isActive: userData.isActive,
        dob: userData.dob,
        mainWallet: UserWallet(
          walletAddress: userData.mainWallet.walletAddress,
          walletType: userData.mainWallet.walletType,
          walletBalance: userData.mainWallet.walletBalance,
          privateKey: userData.mainWallet.privateKey,
          userdid: userData.mainWallet.userdid,
        ),
        wallets: userData.wallets,
      ),
    );
  }

  Widget buildFooter(
      BuildContext context, centerSpacing, spacingMultiplier, isSmallScreen) {
    return Positioned(
      bottom: AppTheme.cardPadding * 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: centerSpacing),
        child: Row(
          mainAxisAlignment: isSmallScreen
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: double.infinity,
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        VRouter.of(context).to("/");
                      },
                      child: Row(
                        children: [
                          Container(
                            height: AppTheme.cardPadding * 2.5,
                            width: AppTheme.cardPadding * 2.5,
                            child: Image(
                                image: AssetImage(
                                    'assets/images/logotransparent.png')),
                          ),
                          SizedBox(
                            width: AppTheme.cardPadding,
                          ),
                          Text(
                            "BitNet",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  Text(
                    "©2023 by BitNet GmBH, Germany",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  isSmallScreen
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height:
                                  AppTheme.cardPadding * 4 * spacingMultiplier,
                            ),
                            Row(
                              children: [
                                product(),
                                SizedBox(
                                  width: AppTheme.cardPadding *
                                      4 *
                                      spacingMultiplier,
                                ),
                                helpandSupport(),
                              ],
                            ),
                            SizedBox(
                                height: AppTheme.cardPadding *
                                    2 *
                                    spacingMultiplier),
                            socials(spacingMultiplier),
                          ],
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
            isSmallScreen
                ? Container()
                : Row(
                    children: [
                      product(),
                      SizedBox(
                        width: AppTheme.cardPadding * 4 * spacingMultiplier,
                      ),
                      helpandSupport(),
                      SizedBox(
                        width: AppTheme.cardPadding * 4 * spacingMultiplier,
                      ),
                      socials(spacingMultiplier),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget socials(spacingMultiplier) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Socials",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: AppTheme.elementSpacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SocialRow(
                    iconData: FontAwesomeIcons.instagram,
                    platformName: "Instagram",
                    onTap: () {
                      launchUrlString(AppTheme.instagramUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.facebook,
                    platformName: "Facebook",
                    onTap: () {
                      launchUrlString(AppTheme.facebookUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.twitter,
                    platformName: "Twitter",
                    onTap: () {
                      launchUrlString(AppTheme.twitterUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.linkedin,
                    platformName: "LinkedIn",
                    onTap: () {
                      launchUrlString(AppTheme.linkedinUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.tiktok,
                    platformName: "TikTok",
                    onTap: () {
                      launchUrlString(AppTheme.tiktokUrl);
                    },
                  ),
                ],
              ),
              SizedBox(
                width: AppTheme.cardPadding * 2 * spacingMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SocialRow(
                    iconData: FontAwesomeIcons.youtube,
                    platformName: "YouTube",
                    onTap: () {
                      launchUrlString(AppTheme.youtubeUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.pinterest,
                    platformName: "Pinterest",
                    onTap: () {
                      launchUrlString(AppTheme.pinterestUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.snapchat,
                    platformName: "Snapchat",
                    onTap: () {
                      launchUrlString(AppTheme.snapchatUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.telegram,
                    platformName: "Telegram",
                    onTap: () {
                      launchUrlString(AppTheme.telegramUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.discord,
                    platformName: "Discord",
                    onTap: () {
                      launchUrlString(AppTheme.discordUrl);
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget product() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(
          platformName: "Get Started",
          onTap: () => VRouter.of(context).to('/website'),
        ), // VRouter auth
        SocialRow(
          platformName: "About us",
          onTap: () => VRouter.of(context).to('/aboutus'),
        ), // About us page (nur ich lol)make roadmap how the app should develop
        SocialRow(
          platformName: "Our Team",
          onTap: () => VRouter.of(context).to('/ourteam'),
        ),
        SocialRow(
            platformName: "Fund us",
            onTap: () {
              launchUrlString(AppTheme.goFundMeUrl);
            }), // Support the project give money or buy these nfts
        SocialRow(
          platformName: "Whitepaper",
          onTap: () {
            print("Download whitepaper as pdf or smth...");
          },
        ), // whitepaper (webbrowser einfach n tab mit dem whitepaper öffnen

        //reddit??
        //tumblr??
      ],
    );
  }

  Widget helpandSupport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(
          platformName: "Help Center",
          onTap: () {
            print("Help and Support");
            VRouter.of(context).to("/help");
          },
        ), //vrouter help page (faq voreingetsellt)
        SocialRow(
          platformName:
              "Report issue", //bugs, incidents, security issues etc abuse and fraud etc problems in general
          onTap: () {
            print("Help and Support");
            VRouter.of(context).to("/report");
          },
        ), //vrouter reporting page (bug voreingetsellt)
        SocialRow(
            platformName: "Submit Idea",
            onTap: () {
              VRouter.of(context).to('/submitidea');
            }), //vrouter reporting page (fraud voreingetsellt)//vrouter reporting page (security voreingetsellt)
        SocialRow(
            platformName: "AGBS",
            onTap: () => VRouter.of(context).to('/agbs')), //
        SocialRow(
            platformName: "Impressum",
            onTap: () => VRouter.of(context).to('/impressum')), //
      ],
    );
  }
}

class SocialRow extends StatelessWidget {
  IconData? iconData;
  final String platformName;
  final VoidCallback? onTap; // <-- Declare an onTap function

  SocialRow({
    this.iconData,
    required this.platformName,
    this.onTap, // <-- Initialize it in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing / 1.25),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap, // <-- Use the passed function here
          child: Row(
            children: [
              if (iconData != null)
                Icon(iconData, size: AppTheme.elementSpacing * 1.5),
              if (iconData != null)
                SizedBox(width: AppTheme.elementSpacing / 2),
              Text(platformName, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
