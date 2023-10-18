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
        bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
        bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

        double bigtextWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 24 : AppTheme.cardPadding * 28 : AppTheme.cardPadding * 30;
        double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
        double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
        double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
        double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

        return BackgroundWithContent(
          backgroundType: BackgroundType.asset,
          withGradientBottomBig: true,
          opacity: 0.7,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: centerSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 4 * spacingMultiplier,
                ),
                Container(
                  width: bigtextWidth,
                  child: Text(
                    "Bitcoin solved the trust, but we the people need to solve the adoption problem!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * spacingMultiplier,
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
                  height: AppTheme.cardPadding * 2 * spacingMultiplier,
                ),
                LongButtonWidget(
                  buttonType: ButtonType.solid,
                  title: L10n.of(context)!.register,
                  onTap: () async {
                    VRouter.of(context).to('/pinverification');
                  },
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 10 * spacingMultiplier,
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
                  height: AppTheme.cardPadding * spacingMultiplier,
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
          ),
        );
      },
    );
  }
}
