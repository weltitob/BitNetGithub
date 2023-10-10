import 'package:bitnet/backbone/helper/theme/theme.dart';
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
        // Check if the screen width is less than 600 pixels.
        bool isSmallScreen = constraints.maxWidth < 600;

        // Adjust widget sizes based on screen size.
        double textWidth = isSmallScreen ? AppTheme.cardPadding * 20 : AppTheme.cardPadding * 33;
        double subtitleWidth = isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 25;
        double spacingMultiplier = isSmallScreen ? 3 : 1;

        return Container(
        color: darken(Colors.deepPurple, 80),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppTheme.columnWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppTheme.cardPadding * 5 * spacingMultiplier,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: AppTheme.cardPadding * 18 * spacingMultiplier,
                        width: AppTheme.cardPadding * 18 * spacingMultiplier,
                        child: Lottie.asset(
                          'assets/lottiefiles/blob.json',),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: AppTheme.cardPadding * 18 * spacingMultiplier,
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
                            width: AppTheme.cardPadding * 18 * spacingMultiplier,
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
          ],
        ),
      );},
    );
  }
}
