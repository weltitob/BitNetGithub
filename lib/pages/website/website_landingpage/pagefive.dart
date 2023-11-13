import 'package:animated_text_kit/animated_text_kit.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:vrouter/vrouter.dart';

class PageFive extends StatefulWidget {
  final WebsiteLandingPageController controller;

  const PageFive({super.key, required this.controller});

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
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
          // Diese sind die Breite und Höhe aus den Constraints
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;

          bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
          bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
          bool isSuperSmallScreen =
              constraints.maxWidth < AppTheme.isSuperSmallScreen;

          double bigtextWidth = isMidScreen
              ? isSmallScreen
              ? isSuperSmallScreen
              ? AppTheme.cardPadding * 13
              : AppTheme.cardPadding * 24
              : AppTheme.cardPadding * 28
              : AppTheme.cardPadding * 30;
          double textWidth = isMidScreen
              ? isSmallScreen
              ? isSuperSmallScreen
              ? AppTheme.cardPadding * 13
              : AppTheme.cardPadding * 16
              : AppTheme.cardPadding * 22
              : AppTheme.cardPadding * 24;
          double subtitleWidth = isMidScreen
              ? isSmallScreen
              ? isSuperSmallScreen
              ? AppTheme.cardPadding * 13
              : AppTheme.cardPadding * 16
              : AppTheme.cardPadding * 18
              : AppTheme.cardPadding * 22;
          double spacingMultiplier = isMidScreen
              ? isSmallScreen
              ? isSuperSmallScreen
              ? 0.25
              : 0.5
              : 0.75
              : 1;
          double centerSpacing = isMidScreen
              ? isSmallScreen
              ? isSuperSmallScreen
              ? AppTheme.columnWidth * 0.075
              : AppTheme.columnWidth * 0.15
              : AppTheme.columnWidth * 0.65
              : AppTheme.columnWidth;

          return Stack(
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
            _isThirdAnimationCompleted && !isSmallScreen
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
                          width: isSmallScreen? 300: 850,
                          height: isSmallScreen? 500: 240,
                          child: Stack(
                            children: [
                              Container(
                                width: isSmallScreen? 300 : 850,
                                height: isSmallScreen? 500: 240,
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
            _isThirdAnimationCompleted && !isSmallScreen
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
        );
      }
    );
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

}
