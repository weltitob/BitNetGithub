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

class Quotes extends StatefulWidget {
  final WebsiteLandingPageController controller;

  const Quotes({super.key, required this.controller});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
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
      bool isIntermediateScreen =
          constraints.maxWidth < AppTheme.isIntermediateScreen;

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

      return Stack(
        children: [
          _isThirdAnimationCompleted
              ? Container()
              : FadeIn(
                  delay: Duration(milliseconds: 1200),
                  duration: Duration(seconds: 2),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: isIntermediateScreen
                            ? isSmallScreen
                                ? AppTheme.cardPadding * 16 + 160
                                : AppTheme.cardPadding * 5 +
                                    spacingMultiplier +
                                    180
                            : AppTheme.cardPadding * 5 +
                                spacingMultiplier +
                                180,
                        left: isIntermediateScreen
                            ? isSmallScreen
                                ? 425 - AppTheme.cardPadding * 6
                                : 700 - AppTheme.cardPadding
                            : 850 - AppTheme.cardPadding,
                      ),
                      child: quoteText(),
                    ),
                  ),
                ),
          _isThirdAnimationCompleted && !isSmallScreen
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: isIntermediateScreen
                        ? isSmallScreen
                            ? 300 + AppTheme.cardPadding * 5
                            : 700 + AppTheme.cardPadding * 7.5
                        : 850 + AppTheme.cardPadding * 10,
                    height: isIntermediateScreen
                        ? isSmallScreen
                            ? 500
                            : 400
                        : 400,
                    child: RandomAvatarWidget(
                      start: true,
                      width: isIntermediateScreen
                          ? isSmallScreen
                              ? 300 + AppTheme.cardPadding * 5
                              : 700 + AppTheme.cardPadding * 7.5
                          : 850 + AppTheme.cardPadding * 10,
                      height: isIntermediateScreen
                          ? isSmallScreen
                              ? 500
                              : 400
                          : 400,
                    ),
                  ),
                )
              : Container(),
          FadeIn(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      VRouter.of(context).to("/register");
                    },
                    child: GlassContainer(
                      borderThickness: 1.5, // remove border if not active
                      blur: 50,
                      opacity: 0.1,
                      borderRadius: BorderRadius.circular(240 / 3.5),
                      child: Container(
                        width: isIntermediateScreen
                            ? isSmallScreen
                                ? 300
                                : 700
                            : 850,
                        height: isIntermediateScreen
                            ? isSmallScreen
                                ? 500
                                : 240
                            : 240,
                        child: Stack(
                          children: [
                            Container(
                              width: isIntermediateScreen
                                  ? isSmallScreen
                                      ? 300
                                      : 700
                                  : 850,
                              height: isIntermediateScreen
                                  ? isSmallScreen
                                      ? 500
                                      : 240
                                  : 240,
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    AppTheme.cardPadding * spacingMultiplier,
                                vertical: AppTheme.cardPadding * 2.25,
                              ),
                              child: _isThirdAnimationCompleted
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: BitNetShaderMask(
                                        child: AnimatedTextKit(
                                          isRepeatingAnimation: false,
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              '"We empower Our Tomorrow!"',
                                              textAlign: TextAlign.center,
                                              textStyle: Theme.of(context)
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
                                              'Join us Today!',
                                              textAlign: TextAlign.center,
                                              textStyle: Theme.of(context)
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
                                        itemCount: widget
                                            .controller.pageDataList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    AppTheme.cardPadding *
                                                        1.25),
                                            child: Column(
                                              children: [
                                                _buildTypewriterText(
                                                    widget
                                                        .controller
                                                        .pageDataList[index]
                                                        .text, () {
                                                  if (index <
                                                      widget
                                                              .controller
                                                              .pageDataList
                                                              .length -
                                                          1) {
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 2000),
                                                        () {
                                                      _pageController.nextPage(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        curve: Curves.easeInOut,
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
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: AppTheme.cardPadding * 1),
                                        child: buildIndicator(
                                          dotHeight: AppTheme.elementSpacing,
                                          dotWidth: AppTheme.elementSpacing,
                                          pageController: _pageController,
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
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: isIntermediateScreen
                            ? isSmallScreen
                                ? AppTheme.cardPadding * 16
                                : AppTheme.cardPadding * 5
                            : AppTheme.cardPadding * 5,
                        right: isIntermediateScreen
                            ? isSmallScreen
                                ? 425 - AppTheme.cardPadding * 3.5
                                : 700
                            : 850,
                      ),
                      child: quoteText(),
                    ),
                  ),
                ),
          _isThirdAnimationCompleted && !isSmallScreen
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: isIntermediateScreen
                        ? isSmallScreen
                            ? 300 + AppTheme.cardPadding * 5
                            : 700 + AppTheme.cardPadding * 7.5
                        : 850 + AppTheme.cardPadding * 10,
                    height: isIntermediateScreen
                        ? isSmallScreen
                            ? 500
                            : 400
                        : 400,
                    child: RandomAvatarWidget(
                      start: true,
                      width: isIntermediateScreen
                          ? isSmallScreen
                              ? 300 + AppTheme.cardPadding * 5
                              : 700 + AppTheme.cardPadding * 7.5
                          : 850 + AppTheme.cardPadding * 10,
                      height: isIntermediateScreen
                          ? isSmallScreen
                              ? 500
                              : 400
                          : 400,
                    ),
                  ),
                )
              : Container(),
          _isThirdAnimationCompleted
              ? Container()
              : FadeIn(
                  key: fadeInKey,
                  delay: Duration(milliseconds: 400),
                  duration: Duration(seconds: 2),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: isSmallScreen
                            ? 240 + AppTheme.cardPadding * 10.5
                            : AppTheme.cardPadding * 10.5,
                      ),
                      child: _buildUserSearchResult(widget
                          .controller.pageDataList[_selectedindex].userData),
                    ),
                  ),
                ),
        ],
      );
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
      scaleRatio: 1.15,
      onTap: () {
        print("User selected: ${userData.displayName}");
        return null;
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
      ),
    );
  }
}
