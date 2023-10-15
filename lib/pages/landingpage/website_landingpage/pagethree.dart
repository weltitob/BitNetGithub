import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/custom_card_landigpage.dart';
import 'package:flutter/material.dart';

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Diese sind die Breite und Höhe aus den Constraints
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        // Werte anpassen basierend auf der Bildschirmhöhe
        double cardMargin =
            (width > 600) ? AppTheme.columnWidth : 16.0; // Beispielhafte Grenze

        return BackgroundWithContent(
          opacity: 0.7,
          backgroundType: BackgroundType.asset,
          withGradientBottomMedium: true,
          withGradientTopMedium: true,
          child: Column(
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 5,
              ),
              Text(
                "Our mission.",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: AppTheme.cardPadding * 3,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: cardMargin),
                child: (width > 600) // Beispielhafte Grenze
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _buildCards(),
                      )
                    : Column(
                        children: _buildCards(),
                      ),
              ),
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
      ),
      SizedBox(height: 16.0), // Abstand für das Spaltenlayout
      CustomCard(
        lottieAssetPath: 'assets/lottiefiles/asset_animation.json',
        mainTitle: "We the people, own our data!",
        subTitle:
            "We are building a third layer platform on top of the trustless Bitcoin Network.",
        buttonText: "Get a DID",
        onButtonTap: () {},
      ),
      SizedBox(height: 16.0), // Abstand für das Spaltenlayout
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
