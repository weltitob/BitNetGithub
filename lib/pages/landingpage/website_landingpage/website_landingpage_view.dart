import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/bitnetScaffold.dart';
import 'package:bitnet/components/buttons/glassbutton.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/pagefooter.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/pagefour.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/pageone.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/pagethree.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/pagetwo.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

class WebsiteLandingPageView extends StatelessWidget {
  final WebsiteLandingPageController controller;

  const WebsiteLandingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
          hasBackButton: false,
          customTitle: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Check if the screen width is less than 600 pixels.
              bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
              bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

              double bigtextWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 24 : AppTheme.cardPadding * 28 : AppTheme.cardPadding * 30;
              double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
              double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
              double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
              double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;


              return Container(
                margin: EdgeInsets.symmetric(horizontal: centerSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: AppTheme.cardPadding *
                                  (isSmallScreen ? 1 : 1.25),
                              width: AppTheme.cardPadding *
                                  (isSmallScreen ? 1 : 1.25),
                              child: Image.asset(
                                "./images/logoclean.png",
                              ),
                            ),
                            SizedBox(
                              width: AppTheme.elementSpacing *
                                  (isSmallScreen ? 0.5 : 1),
                            ),
                            Text(
                              "BitNet",
                              style: TextStyle(
                                fontSize: isSmallScreen
                                    ? 16
                                    : 20, // Adjust font size for small screen
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isSmallScreen
                        ? SizedBox
                            .shrink() // Hide this container on small screens
                        : Container(
                            width: AppTheme.cardPadding * 17,
                            child: Center(
                              child: StreamBuilder<double>(
                                stream: controller
                                    .percentageChangeInUserCountStream(),
                                builder: (context, percentageSnapshot) {
                                  double? percentageChange =
                                      percentageSnapshot.data;
                                  percentageChange ??= 0;
                                  return StreamBuilder<List<UserData>>(
                                    stream: controller.lastUsersStream(),
                                    builder: (context, userDataSnapshot) {
                                      if (!userDataSnapshot.hasData) {
                                        return SizedBox(
                                            height: AppTheme.cardPadding * 4,
                                            child: Center(
                                                child: dotProgress(context)));
                                      }
                                      List<UserData> all_userresults =
                                          userDataSnapshot.data!;
                                      if (all_userresults.length == 0) {
                                        return Container();
                                      }
                                      List<String> firstFourUsernames =
                                          all_userresults.reversed
                                              .take(4) // Take the last 4
                                              .map((user) => user.username)
                                              .toList();
                                      List<AnimatedText> texts = [
                                        RotateAnimatedText(
                                          "We have liftoff! Exclusive Early Access for Invited Users.",
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ];
                                      texts.add(
                                        RotateAnimatedText(
                                          '+${percentageChange!.toStringAsFixed(1)}% User-change in the last 7 days!',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      );
                                      texts.add(
                                        RotateAnimatedText(
                                          '@${firstFourUsernames[0]} just joined the BitNet!',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      );
                                      return AnimatedTextKit(
                                        repeatForever: true,
                                        pause: Duration(milliseconds: 1000),
                                        animatedTexts: texts,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                    Container(
                      //color: Colors.green,
                      child: LongButtonWidget(
                        buttonType: ButtonType.transparent,
                        customWidth: isSmallScreen ? AppTheme.cardPadding * 5 : AppTheme.cardPadding * 6.5,
                        customHeight: isSmallScreen ? AppTheme.cardPadding * 1.25 : AppTheme.cardPadding * 1.6,
                        title: "Get started",
                        leadingIcon: Icon(
                          FontAwesomeIcons.circleArrowRight,
                          size: AppTheme.cardPadding * 0.75,
                          color: AppTheme.white90,
                        ),
                        onTap: () {
                          VRouter.of(context).to('/authhome');
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          context: context),
      context: context,
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: controller.pageController,
        children: [
          PageOne(
            controller: controller,
          ),
          PageTwo(
            controller: controller,
          ),
          PageThree(),
          PageFour(),
          PageFooter(
            controller: controller,
          ),
        ],
      ),
    );
  }

  //eine page mit explore the blockchain with BitNet...

  //get your decentralized identity...

  //eine page mit so containern wie auf moveworks nur mit 3
  //get your crypto wallet, start sending lightning payments, get your first NFT

  Widget buildPercentagChange(BuildContext context) {
    return GlassContainer(
      borderThickness: 1.5, // remove border if not active
      blur: 50,
      opacity: 0.1,
      borderRadius: AppTheme.cardRadiusMid,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
        child: Column(
          children: [
            Text(
              "+ 2432.0%",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppTheme.successColor,
                  ),
            ),
            SizedBox(
              height: AppTheme.elementSpacing,
            ),
            Text(
              "Userchange last 7 days",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
