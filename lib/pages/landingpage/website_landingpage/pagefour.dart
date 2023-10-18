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

        double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isSmallScreen ? SizedBox(
                      width: 0,
                      height: 0,
                    ) : Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(AppTheme.cardPadding * 9 * spacingMultiplier),
                          height: AppTheme.cardPadding * 12 * spacingMultiplier,
                          width: AppTheme.cardPadding * 12 * spacingMultiplier,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: textWidth,
                          child: Text(
                            "More and more decide to join us each day!",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        SizedBox(
                          height: AppTheme.cardPadding * 2 * spacingMultiplier,
                        ),
                        Container(
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
                          width: AppTheme.cardPadding * 10,
                          child: LongButtonWidget(
                              title: L10n.of(context)!.register,
                              onTap: () async {
                                VRouter.of(context).to('/pinverification');
                              }),
                        ),
                      ],
                    ),
                    isSmallScreen ? SizedBox(
                      width: 0,
                      height: 0,
                    ) : SizedBox(
                      width: AppTheme.cardPadding * 2,
                      height: AppTheme.cardPadding * 2,)
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
