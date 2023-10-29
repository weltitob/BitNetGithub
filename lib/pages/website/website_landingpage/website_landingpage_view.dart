import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/bitnetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefooter.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefour.dart';
import 'package:bitnet/pages/website/website_landingpage/pageone.dart';
import 'package:bitnet/pages/website/website_landingpage/pagethree.dart';
import 'package:bitnet/pages/website/website_landingpage/pagetwo.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
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
      appBar: bitnetWebsiteAppBar(controller: controller),
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
