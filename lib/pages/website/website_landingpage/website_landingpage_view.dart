import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetFAB.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefooter.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefour.dart';
import 'package:bitnet/pages/website/website_landingpage/pageone.dart';
import 'package:bitnet/pages/website/website_landingpage/pagethree.dart';
import 'package:bitnet/pages/website/website_landingpage/pagetwo.dart';

import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WebsiteLandingPageView extends StatelessWidget {
  final WebsiteLandingPageController controller;

  const WebsiteLandingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: controller.showFab,
          builder: (context, showFab, child) {
            return AnimatedOpacity(
              opacity: showFab ? 1 : 0,
              duration: Duration(milliseconds: 200),
              child: BitNetFAB(
                onPressed: () {
                  if (controller.pageController.hasClients) {
                    var nextPage = controller.pageController.page!.toInt() + 1;
                    if (nextPage < 5) {
                      controller.pageController.animateToPage(
                        nextPage,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      print("Last page reached");
                    }
                  }
                },
              ),
            );
          }),
      extendBodyBehindAppBar: true,
      appBar: bitnetWebsiteAppBar(
        centerWidget: centerWidget(context),
      ),
      context: context,
      body: PageView(
        padEnds: false,
        //physics: FastScrollPhysics(), //FastScrollPhysics was causing a bug where pagecontroller would jump back up to the first page when it reached the last page
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
          // PageFive(
          //   controller: controller,
          // ),
          PageFooter(
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget centerWidget(BuildContext context) {
    final percentagechange = Provider.of<double>(context);
    final lastRegisteredUsers = Provider.of<List<UserData>>(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // Check if the screen width is less than 600 pixels.
      bool isSmallScreen =
          MediaQuery.of(context).size.width < AppTheme.isSmallScreen;
      bool isMidScreen =
          MediaQuery.of(context).size.width < AppTheme.isMidScreen;

      List<UserData> all_userresults = lastRegisteredUsers;
      List<String> firstFourUsernames = all_userresults.reversed
          .take(4) // Take the last 4
          .map((user) => user.username)
          .toList();

      return isSmallScreen
          ? Container()
          : Container(
              width: AppTheme.cardPadding * 17,
              child: lastRegisteredUsers.isEmpty
                  ? SizedBox(
                      height: AppTheme.cardPadding * 4,
                      child: Center(child: dotProgress(context)))
                  : AnimatedTextKit(
                      repeatForever: true,
                      pause: Duration(milliseconds: 1000),
                      animatedTexts: [
                        RotateAnimatedText(
                          "We have Beta liftoff! Exclusive Early Access for Invited Users.",
                          duration: Duration(milliseconds: 2400),
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                        RotateAnimatedText(
                          '+${percentagechange.toStringAsFixed(1)}% User-change in the last 7 days!',
                          duration: Duration(milliseconds: 2400),
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                        RotateAnimatedText(
                          '@${firstFourUsernames[0]} just joined the BitNet!',
                          duration: Duration(milliseconds: 2400),
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ], //texts
                    ),
            );
    });
  }
}
