import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class PageFour extends StatefulWidget {
  const PageFour({super.key});

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
        bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

        double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 33;
        double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
        double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
        double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

        return BackgroundWithContent(
          opacity: 0.7,
          backgroundType: BackgroundType.asset,
          withGradientTopSmall: true,
          withGradientBottomSmall: true,
          withGradientRightBig: true,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: centerSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 8 * spacingMultiplier,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(AppTheme.cardPadding * 4.5),
                          height: AppTheme.cardPadding * 18 * spacingMultiplier,
                          width: AppTheme.cardPadding * 18 * spacingMultiplier,
                          child: Lottie.asset(
                            'assets/lottiefiles/btc_3d.json',),
                        ),
                        Container(
                          height: AppTheme.cardPadding * 30 * spacingMultiplier,
                          width: AppTheme.cardPadding * 30 * spacingMultiplier,
                          child: Lottie.asset(
                            'assets/lottiefiles/circle_animation.json',),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: textWidth,
                          margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                          child: Text(
                            "More and more decide to join us each day!",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        SizedBox(
                          height: AppTheme.cardPadding * 2 * spacingMultiplier,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                          width: subtitleWidth,
                          child: Text(
                            "We are the light that helps others see Bitcoin. We form the next step in the evolution of bitcoin!",
                            style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: AppTheme.cardPadding * 2 * spacingMultiplier
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                          width: AppTheme.cardPadding * 10,
                          child: LongButtonWidget(
                              title: L10n.of(context)!.register,
                              onTap: () async {
                                VRouter.of(context).to('/pinverification');
                              }),
                        ),
                      ],
                    ),
                    // Container(
                    //     height: AppTheme.cardPadding * 15,
                    //     child: buildFutureLottie(controller.composition, true))
                  ],
                ),
              ],
            ),
          ),
        );},
    );
  }
}
