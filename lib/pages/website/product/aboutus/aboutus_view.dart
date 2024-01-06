import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/website/product/aboutus/aboutus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vrouter/vrouter.dart';

class AboutUsView extends StatelessWidget {
  final AboutUsController controller;

  const AboutUsView({super.key, required this.controller});

    @override
    Widget build(BuildContext context) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Check if the screen width is less than 600 pixels.
          bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
          bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

          double bigtextWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 24 : AppTheme.cardPadding * 28 : AppTheme.cardPadding * 30;
          double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
          double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
          double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
          double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

          return bitnetScaffold(
            extendBodyBehindAppBar: true,
            appBar: bitnetWebsiteAppBar(),
            body: BackgroundWithContent(
              backgroundType: BackgroundType.asset,
              withGradientRightBig: true,
              withGradientLeftBig: true,
              withGradientTopSmall: true,
              withGradientBottomSmall: true,
              opacity: 0.7,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: centerSpacing),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: AppTheme.cardPadding * 6 * spacingMultiplier,
                      ),
                      Container(
                        width: bigtextWidth,
                        child: Text(
                          "About us",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding * 4 * spacingMultiplier,
                      ),
                      Text(
                        "We are the light that helps others see Bitcoin.",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          isSmallScreen ? SizedBox(
                            width: 0,
                            height: 0,
                          ) : Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(AppTheme.cardPadding * 11 * spacingMultiplier),
                                height: AppTheme.cardPadding * 14 * spacingMultiplier,
                                width: AppTheme.cardPadding * 14 * spacingMultiplier,
                                child: Lottie.asset(
                                  'assets/lottiefiles/btc_3d.json',),
                              ),
                              Container(
                                height: AppTheme.cardPadding * 36 * spacingMultiplier,
                                width: AppTheme.cardPadding * 36 * spacingMultiplier,
                                child: Lottie.asset(
                                  'assets/lottiefiles/circle_animation.json',),
                              ),
                            ],
                          ),
                          Container(
                            width: textWidth,
                            child: Text(
                              "History",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          SizedBox(
                              height: AppTheme.elementSpacing * 1 * spacingMultiplier
                          ),
                          Container(
                            width: textWidth,
                            child: Text(
                              "Founded in 2023, BitNet was born out of the belief that Bitcoin is not just a digital asset for the tech-savvy and financial experts,"
                                  " but a revolutionary tool that has the potential to build the foundations of cyberspace empowering individuals worldwide."
                                  " We recognized the complexity and the mystique surrounding Bitcoin and cryptocurrencies,"
                                  " and we decided it was time to demystify it and make it accessible to everyone."
                                  " We are a pioneering platform dedicated to bringing Bitcoin closer to everyday people like you.",
                              // " Our mission is simple but profound: to accelerate the adoption of Bitcoin and create a world"
                              //     " where digital assets are accessible, understandable, and beneficial to all. "
                              //     "But Bitcoin is more than just a digital asset; it's a movement. A movement towards a more open, accessible, and equitable future."
                              //     " And at BitNet, we are proud to be at the forefront of this movement.",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(
                              height: AppTheme.elementSpacing * 2.5 * spacingMultiplier
                          ),
                          Container(
                            width: textWidth,
                            child: Text(
                              "Mission",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          SizedBox(
                              height: AppTheme.elementSpacing * 1 * spacingMultiplier
                          ),
                          Container(
                            width: textWidth,
                            child: Text(
                              "Our mission is simple but profound: To innovate in the digital "
                                  "economy by integrating blockchain technology with asset digitization, "
                                  "creating a secure and transparent platform that empowers users to engage "
                                  "with the metaverse through Bitcoin. We are dedicated to making digital interactions "
                                  "more accessible, equitable, and efficient for everyone. To accelerate the adoption of Bitcoin and create a world"
                                  " where digital assets are accessible, understandable, and beneficial to all. Where people can verify information "
                              " on their own.",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(
                              height: AppTheme.elementSpacing * 2.5 * spacingMultiplier
                          ),
                          Container(
                            width: textWidth,
                            child: Text(
                              "Vision",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                          SizedBox(
                              height: AppTheme.elementSpacing * 1 * spacingMultiplier
                          ),
                          Container(
                            width: textWidth,
                            child: Text(
                              "But Bitcoin is more than just a digital asset; it's a movement. A movement towards a more open, accessible, and equitable future. "
                                  "BitNet wants be at the forefront of the digital age as a pioneer in asset digitization using Bitcoin,"
                                  " shaping a metaverse where equality, security, and sustainability"
                                  " are not just ideals, but realities. Our vision is to create an"
                                  " interconnected digital world where every user can seamlessly and"
                                  " fairly access, exchange, and grow their digital assets.",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      isSmallScreen ? SizedBox(
                        width: 0,
                        height: 0,
                      ) : SizedBox(
                        width: AppTheme.cardPadding * 2,
                        height: AppTheme.cardPadding * 2,),
                      SizedBox(
                        height: AppTheme.cardPadding * 2 * spacingMultiplier,
                      ),
                      Row(
                        children: [
                          Container()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ), context: context,
          );
        },
      );
    }
}
