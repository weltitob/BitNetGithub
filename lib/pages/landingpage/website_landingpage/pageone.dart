import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class PageOne extends StatefulWidget {
  final WebsiteLandingPageController controller;

  const PageOne({super.key, required this.controller});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Check if the screen width is less than 600 pixels.
        bool isSmallScreen = constraints.maxWidth < 600;

        // Adjust widget sizes based on screen size.
        double textWidth = isSmallScreen ? AppTheme.cardPadding * 20 : AppTheme.cardPadding * 33;
        double subtitleWidth = isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 25;
        double spacingMultiplier = isSmallScreen ? 3 : 2;

        return BackgroundWithContent(
          backgroundType: BackgroundType.asset,
          withGradient: true,
          opacity: 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppTheme.cardPadding * spacingMultiplier,
              ),
              Container(
                width: textWidth,
                child: Text(
                  "Bitcoin solved the trust, but we the people need to solve the adoption problem!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding,
              ),
              Container(
                width: subtitleWidth,
                child: Text(
                  "BitNet is not a social network. It's the third layer platform built on the Bitcoin Network.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding,
              ),
              Container(
                width: AppTheme.cardPadding * 10,
                child: LongButtonWidget(
                  title: L10n.of(context)!.register,
                  onTap: () async {
                    VRouter.of(context).to('/pinverification');
                  },
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 7,
              ),
              StreamBuilder<Object>(
                stream: widget.controller.userCountStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                        height: AppTheme.cardPadding * 4,
                        child: Center(child: dotProgress(context)));
                  }
                  int currentusernumber = snapshot.data as int;
                  num _value = (1000000 - currentusernumber);
                  return AnimatedFlipCounter(
                    value: _value,
                    thousandSeparator: ".",
                    decimalSeparator: ",",
                    textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 100,
                    ),
                  );
                },
              ),
              SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                "limited spots left!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                children: [
                  Container()
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
