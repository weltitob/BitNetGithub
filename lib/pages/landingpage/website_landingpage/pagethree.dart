import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/custom_card_landigpage.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {

  PageController pageController = PageController(viewportFraction: 0.7);
  int _selectedindex = 0;
  double _scale = 0.9;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Diese sind die Breite und Höhe aus den Constraints
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
        bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

        double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
        double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
        double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
        double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

        return BackgroundWithContent(
          opacity: 0.7,
          backgroundType: BackgroundType.asset,
          withGradientBottomMedium: true,
          withGradientTopMedium: true,
          child: Column(
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 7 * spacingMultiplier
              ),
              Text(
                "Our mission.",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: AppTheme.cardPadding * 3 * spacingMultiplier,
              ),
              Container(
                child: isSmallScreen ?
                Container(
                  height: 500,
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedindex = index;
                      });
                    },
                    itemCount: _buildCards().length, // Set the itemCount to the length of the _buildCards list
                    itemBuilder: (context, index) {

                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: _scale, end: _scale),
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 350),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: _buildCards()[index],  // Use the index to get the specific CustomCard from the _buildCards list
                      );
                    },
                  ),
                ) : Container(
                  margin: EdgeInsets.symmetric(horizontal: centerSpacing),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildCards(), // Use the complete list of CustomCard widgets
                  ),
                ),
              ),
              SizedBox(height: AppTheme.cardPadding * 2 * spacingMultiplier,),
              isSmallScreen ? buildIndicator(
                  pageController: pageController,
                  count: 3,) : Container(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildCards() {
    return [
      CustomCard(
        lottieAssetPath: 'assets/lottiefiles/wallet_animation.json',
        mainTitle: "We the people, control our money!",
        subTitle:
            "We are a simple and secure way to send and receive payments on the Bitcoin Network",
        buttonText: "Send BTC",
        onButtonTap: () {},
      ), // Abstand für das Spaltenlayout
      CustomCard(
        lottieAssetPath: 'assets/lottiefiles/asset_animation.json',
        mainTitle: "We the people, own our data!",
        subTitle:
            "We are building a third layer platform on top of the trustless Bitcoin Network.",
        buttonText: "Get a DID",
        onButtonTap: () {},
      ), // Abstand für das Spaltenlayout
      CustomCard(
        lottieAssetPath: 'assets/lottiefiles/wallet_animation.json',
        mainTitle: "We the people, build our future!",
        subTitle:
            "and start exploring the blockchain exploring the blockchain.",
        buttonText: "Explore BTC",
        onButtonTap: () {},
      ),
    ];
  }
}
