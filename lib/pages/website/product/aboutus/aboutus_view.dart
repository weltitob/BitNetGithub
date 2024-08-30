import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/pages/website/product/aboutus/aboutus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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

        double bigtextWidth = isMidScreen
            ? isSmallScreen
                ? AppTheme.cardPadding * 24
                : AppTheme.cardPadding * 28
            : AppTheme.cardPadding * 30;
        double textWidth = isMidScreen
            ? isSmallScreen
                ? AppTheme.cardPadding * 16
                : AppTheme.cardPadding * 22
            : AppTheme.cardPadding * 24;
        double subtitleWidth = isMidScreen
            ? isSmallScreen
                ? AppTheme.cardPadding * 14
                : AppTheme.cardPadding * 18
            : AppTheme.cardPadding * 22;
        double spacingMultiplier = isMidScreen
            ? isSmallScreen
                ? 0.5
                : 0.75
            : 1;
        double centerSpacing = isMidScreen
            ? isSmallScreen
                ? AppTheme.columnWidth * 0.15
                : AppTheme.columnWidth * 0.65
            : AppTheme.columnWidth;

        return bitnetScaffold(
          extendBodyBehindAppBar: true,
          appBar: const bitnetWebsiteAppBar(),
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
                        L10n.of(context)!.aboutUs,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding * 4 * spacingMultiplier,
                    ),
                    Text(
                      L10n.of(context)!.weAreLight,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isSmallScreen
                            ? const SizedBox(
                                width: 0,
                                height: 0,
                              )
                            : Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(
                                        AppTheme.cardPadding *
                                            11 *
                                            spacingMultiplier),
                                    height: AppTheme.cardPadding *
                                        14 *
                                        spacingMultiplier,
                                    width: AppTheme.cardPadding *
                                        14 *
                                        spacingMultiplier,
                                    child: Lottie.asset(
                                      'assets/lottiefiles/btc_threed.json',
                                    ),
                                  ),
                                  Container(
                                    height: AppTheme.cardPadding *
                                        36 *
                                        spacingMultiplier,
                                    width: AppTheme.cardPadding *
                                        36 *
                                        spacingMultiplier,
                                    child: Lottie.asset(
                                      'assets/lottiefiles/circle_animation.json',
                                    ),
                                  ),
                                ],
                              ),
                        Container(
                          width: textWidth,
                          child: Text(
                            L10n.of(context)!.history,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        SizedBox(
                            height: AppTheme.elementSpacing *
                                1 *
                                spacingMultiplier),
                        Container(
                          width: textWidth,
                          child: Text(
                            L10n.of(context)!.foundedIn2023,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(
                            height: AppTheme.elementSpacing *
                                2.5 *
                                spacingMultiplier),
                        Container(
                          width: textWidth,
                          child: Text(
                            L10n.of(context)!.mission,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        SizedBox(
                            height: AppTheme.elementSpacing *
                                1 *
                                spacingMultiplier),
                        Container(
                          width: textWidth,
                          child: Text(
                          L10n.of(context)!.ourMission,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(
                            height: AppTheme.elementSpacing *
                                2.5 *
                                spacingMultiplier),
                        Container(
                          width: textWidth,
                          child: Text(
                            L10n.of(context)!.vision,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        SizedBox(
                            height: AppTheme.elementSpacing *
                                1 *
                                spacingMultiplier),
                        Container(
                          width: textWidth,
                          child: Text(
                            L10n.of(context)!.butBitcoin,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    isSmallScreen
                        ? const SizedBox(
                            width: 0,
                            height: 0,
                          )
                        : const SizedBox(
                            width: AppTheme.cardPadding * 2,
                            height: AppTheme.cardPadding * 2,
                          ),
                    SizedBox(
                      height: AppTheme.cardPadding * 2 * spacingMultiplier,
                    ),
                    Row(
                      children: [Container()],
                    )
                  ],
                ),
              ),
            ),
          ),
          context: context,
        );
      },
    );
  }
}
