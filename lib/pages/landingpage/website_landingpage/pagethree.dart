import 'package:bitnet/backbone/helper/theme/theme.dart';
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
        double titleSpacing = height * 0.05;
        double cardSpacing = height * 0.03;
        double cardMargin =
            (width > 600) ? AppTheme.columnWidth : 16.0; // Beispielhafte Grenze

        return Container(
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              FittedBox(
                fit: BoxFit.fitHeight,
                child:
                    Image(image: AssetImage('assets/images/metaverse_fb.png')),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.7),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 700,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.background.withOpacity(0.2),
                        Theme.of(context).colorScheme.background.withOpacity(0.5),
                        Theme.of(context).colorScheme.background.withOpacity(0.9),
                        Theme.of(context).colorScheme.background,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 700,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.background.withOpacity(0.2),
                        Theme.of(context).colorScheme.background.withOpacity(0.5),
                        Theme.of(context).colorScheme.background.withOpacity(0.9),
                        Theme.of(context).colorScheme.background,
                      ],
                    ),
                  ),
                ),
              ),
              Column(
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
