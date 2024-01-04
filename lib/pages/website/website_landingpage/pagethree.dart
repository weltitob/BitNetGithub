import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetFAB.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/components/container/custom_card_landigpage.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'dart:math' as math;

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  PageController pageController = PageController(viewportFraction: 0.8);
  int _selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
        double centerSpacing = isMidScreen ? isIntermediateScreen
            ? isSmallScreen
                ? isSuperSmallScreen
                    ? AppTheme.columnWidth * 0.075
                    : AppTheme.columnWidth * 0.15
                : AppTheme.columnWidth * 0.35
                : AppTheme.columnWidth * 0.65
            : AppTheme.columnWidth;

        return BackgroundWithContent(
          opacity: 0.7,
          backgroundType: BackgroundType.asset,
          withGradientBottomMedium: true,
          withGradientTopMedium: true,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: AppTheme.cardPadding * 2 * spacingMultiplier),
                  Text(
                    "Our mission.",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding + AppTheme.cardPadding * 2 * spacingMultiplier,
                  ),
                  Container(
                    child: isSmallScreen
                        ? Container(
                            height: AppTheme.cardPadding * 20,
                            child: PageView.builder(
                              controller: pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _selectedindex = index;
                                });
                              },
                              itemCount: _buildCards()
                                  .length, // Set the itemCount to the length of the _buildCards list
                              itemBuilder: (context, index) {
                                return _buildCardsSmallScreen()[index];
                              },
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: centerSpacing * spacingMultiplier),
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:
                                  _buildCards(), // Use the complete list of CustomCard widgets
                            ),
                          ),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 2 * spacingMultiplier,
                  ),
                  isSmallScreen
                      ? buildIndicator(
                          pageController: pageController,
                          count: 3,
                        )
                      : Container(),
                ],
              ),
              // isSmallScreen ? AnimatedOpacity(
              //   duration: Duration(
              //       milliseconds: 200), // Adjust the duration as needed
              //   opacity: _selectedindex != 2
              //       ? 1.0
              //       : 0.0, // Fully visible or completely transparent
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: AppTheme.elementSpacing * spacingMultiplier),
              //       child: Transform.rotate(
              //         angle: math.pi * 1.5, // 270 degrees in radians
              //         child: BitNetFAB(
              //             iconData: Icons.keyboard_arrow_down_rounded,
              //             onPressed: () {
              //
              //           if (_selectedindex < 2) {
              //             pageController.nextPage(
              //               duration: Duration(milliseconds: 400),
              //               curve: Curves.easeInOut,
              //             );
              //           }
              //         }),
              //       ),
              //     ),
              //   ),
              // ) : Container(),
              // isSmallScreen ? AnimatedOpacity(
              //   duration: Duration(
              //       milliseconds: 200), // Adjust the duration as needed
              //   opacity: _selectedindex != 0
              //       ? 1.0
              //       : 0.0, // Fully visible or completely transparent
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Padding(
              //       padding:
              //           EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * spacingMultiplier),
              //       child: Transform.rotate(
              //         angle: math.pi / 2, // 90 degrees in radians
              //         child: BitNetFAB(
              //             iconData: Icons.keyboard_arrow_down_rounded,
              //             onPressed: () {
              //           if (_selectedindex > 0) {
              //             pageController.previousPage(
              //               duration: Duration(milliseconds: 400),
              //               curve: Curves.easeInOut,
              //             );
              //           }
              //         }),
              //       ),
              //     ),
              //   ),
              // ) : Container(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildCardsSmallScreen() {
    //the center and sizedbox widget is needed to maintain the widgets custom dimensions
    return [
      Container(
        margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: Center(
          child: SizedBox(
            child: CustomCard(
              isBiggerOnHover: false,
              lottieAssetPath: 'assets/lottiefiles/wallet_animation.json',
              mainTitle: "We fight for Bitcoinization!",
              subTitle:
                  "We enable people to use bitcoin in a simple manner!",
              buttonText: "Send BTC",
              onButtonTap: () {},
            ),
          ),
        ),
      ), // Abstand für das Spaltenlayout
      Container(
        margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: Center(
          child: SizedBox(
            child: CustomCard(
              isBiggerOnHover: false,
              lottieAssetPath: 'assets/lottiefiles/asset_animation.json',
              mainTitle: "We give the power back to the people!",
              subTitle:
                  "We own our data and digital identity!",
              buttonText: "Explore BTC",
              onButtonTap: () {},
            ),
          ),
        ),
      ), // Abstand für das Spaltenlayout
      Container(
        margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: Center(
          child: SizedBox(
            child: CustomCard(
              isBiggerOnHover: false,
              lottieAssetPath: 'assets/lottiefiles/plant.json',
              mainTitle: "We grow the Bitcoin Network!",
              subTitle: "We will grow Bitcoin to be much more than just a currency!",
              buttonText: "Get a profile",
              onButtonTap: () {},
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildCards() {
    return [
      CustomCard(
        isBiggerOnHover: true,
        lottieAssetPath: 'assets/lottiefiles/wallet_animation.json',
        mainTitle: "Fight for a faster Bitcoinization!",
        subTitle:
            "We are a simple way to use bitcoin with the most advanced web wallet!",
        buttonText: "Send BTC",
        onButtonTap: () {},
      ), // Abstand für das Spaltenlayout
      CustomCard(
        isBiggerOnHover: true,
        lottieAssetPath: 'assets/lottiefiles/asset_animation.json',
        mainTitle: "Give the power back to the people!",
        subTitle:
            "We own our data and can verify and trust Bitcoins blockchain!",
        buttonText: "Explore BTC",
        onButtonTap: () {},
      ), // Abstand für das Spaltenlayout
      CustomCard(
        isBiggerOnHover: true,
        lottieAssetPath: 'assets/lottiefiles/plant.json',
        mainTitle: "Grow a fair Cyberspace!",
        subTitle: "We form the third layer on top of Bitcoin!",
        buttonText: "Get a profile",
        onButtonTap: () {},
      ),
    ];
  }
}
