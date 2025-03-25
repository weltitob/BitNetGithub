import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/website/emailfetcher.dart';
import 'package:bitnet/pages/website/seo/seo_text.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

class PageOne extends StatefulWidget {
  final WebsiteLandingPageController controller;

  const PageOne({super.key, required this.controller});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    final startvalue = 1000000;
    final usercount = Provider.of<int>(context);
    final endvalue = (1000000 - usercount);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Check if the screen width is less than 600 pixels.
        // Check if the screen width is less than 600 pixels.
        bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
        bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
        bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;
        bool isIntermediateScreen = constraints.maxWidth < AppTheme.isIntermediateScreen;

        double bigtextWidth = isMidScreen
            ? isSmallScreen
                ? isSuperSmallScreen
                    ? AppTheme.cardPadding * 14
                    : AppTheme.cardPadding * 28
                : AppTheme.cardPadding * 30
            : AppTheme.cardPadding * 33;
        double textWidth = isMidScreen
            ? isSmallScreen
                ? isSuperSmallScreen
                    ? AppTheme.cardPadding * 12
                    : AppTheme.cardPadding * 16
                : AppTheme.cardPadding * 22
            : AppTheme.cardPadding * 24;
        double subtitleWidth = isMidScreen
            ? isSmallScreen
                ? AppTheme.cardPadding * 14
                : AppTheme.cardPadding * 18
            : AppTheme.cardPadding * 22;
        double spacingMultiplier = isMidScreen
            ? isSmallScreen
                ? isSuperSmallScreen
                    ? 0.5
                    : 0.5
                : 0.75
            : 1;
        double centerSpacing = isMidScreen
            ? isIntermediateScreen
                ? isSmallScreen
                    ? isSuperSmallScreen
                        ? AppTheme.columnWidth * 0.075
                        : AppTheme.columnWidth * 0.15
                    : AppTheme.columnWidth * 0.35
                : AppTheme.columnWidth * 0.65
            : AppTheme.columnWidth;

        return Stack(
          children: [
            BackgroundWithContent(
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
                      width: bigtextWidth + AppTheme.cardPadding,
                      child: SeoText(
                        "Bitcoin for Everyone, Everywhere", // Updated headline
                        tagStyle: TextTagStyle.h1,
                        textAlign: TextAlign.center,
                        style: isSuperSmallScreen ? Theme.of(context).textTheme.displayMedium : Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding * 1 * spacingMultiplier,
                    ),
                    Container(
                      width: subtitleWidth + AppTheme.cardPadding,
                      child: SeoText(
                        L10n.of(context)!.weAreGrowingBitcoin,
                        textAlign: TextAlign.center,
                        style: isSuperSmallScreen ? Theme.of(context).textTheme.bodyLarge : Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding * 1.5 * spacingMultiplier,
                    ),
                    LongButtonWidget(
                      backgroundPainter: false,
                      buttonType: ButtonType.solid,
                      title: L10n.of(context)!.register,
                      onTap: () => context.go('/website/earlybird'),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding * 10 * spacingMultiplier,
                    ),
                    TweenAnimationBuilder<num>(
                      duration: const Duration(seconds: 3), // Adjust the duration according to your need
                      tween: Tween(begin: startvalue, end: endvalue),
                      builder: (context, value, child) {
                        return AnimatedFlipCounter(
                          value: value, // Animated value
                          duration: const Duration(milliseconds: 500), // Adjust the flip duration
                          curve: Curves.easeOut, // Adjust the animation curve
                          thousandSeparator: ".",
                          decimalSeparator: ",",
                          textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                                fontSize: isSuperSmallScreen ? 74 : 84,
                              ),
                        );
                      },
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding * spacingMultiplier,
                    ),
                    SeoText(
                      L10n.of(context)!.limitedSpotsLeft,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      children: [Container()],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}