import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/bitnetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefooter.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefour.dart';
import 'package:bitnet/pages/website/website_landingpage/pageone.dart';
import 'package:bitnet/pages/website/website_landingpage/pagethree.dart';
import 'package:bitnet/pages/website/website_landingpage/pagetwo.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';

class WebsiteLandingPageView extends StatelessWidget {
  final WebsiteLandingPageController controller;

  const WebsiteLandingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetWebsiteAppBar(
        centerWidget: centerWidget(),
      ),
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

  Widget centerWidget(){
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Check if the screen width is less than 600 pixels.
          bool isSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSmallScreen;
          bool isMidScreen =  MediaQuery.of(context).size.width < AppTheme.isMidScreen;

          return isSmallScreen ? Container() :Container(
          width: AppTheme.cardPadding * 17,
          child: StreamBuilder<double>(
            stream: controller.percentageChangeInUserCountStream(),
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
        );
      }
    );
  }
}
