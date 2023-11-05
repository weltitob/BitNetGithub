import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                    Container(
                      height: AppTheme.cardPadding * 20,
                      width: AppTheme.cardPadding * 20,
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: AppTheme.cardPadding * 20,
                                width: AppTheme.cardPadding * 20,
                                child: Image.asset(
                                  'assets/images/phone.png',
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(height: AppTheme.cardPadding * 6.5,
                                width: AppTheme.cardPadding * 6.5,
                                child: Lottie.asset(
                                  'assets/lottiefiles/phone_bubbles.json',
                                  fit: BoxFit.cover,
                                ),
                              )
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(height: AppTheme.cardPadding,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Theme.of(context).colorScheme.background,],)),),
                          ),
                        ],
                      ),
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
                            "Get the app now and join the BitNet community!",
                            style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: AppTheme.cardPadding * 2 * spacingMultiplier
                        ),
                        Row(
                          children: [
                            Container(
                              width: AppTheme.cardPadding * 10,
                              child: LongButtonWidget(
                                  leadingIcon: Icon(FontAwesomeIcons.googlePlay,
                                  size: 20,),
                                  title: "Google Play",
                                  buttonType: ButtonType.transparent,
                                  onTap: () async {
                                    VRouter.of(context).to('/pinverification');
                                  }),
                            ),
                            SizedBox(width: AppTheme.elementSpacing,),
                            Container(
                              width: AppTheme.cardPadding * 10,
                              child: LongButtonWidget(
                                leadingIcon: Icon(FontAwesomeIcons.apple),
                                  title: "Apple Store",
                                  buttonType: ButtonType.transparent,
                                  onTap: () async {
                                    VRouter.of(context).to('/pinverification');
                                  }),
                            ),
                          ],
                        ),

                        SizedBox(height: AppTheme.cardPadding,),

                        Row(
                          children: [
                            Container(
                              width: AppTheme.cardPadding * 9,
                                child: MyDivider()),
                            SizedBox(width: AppTheme.elementSpacing,),
                            Text("OR", style: Theme.of(context).textTheme.bodyLarge,),
                            SizedBox(width: AppTheme.elementSpacing,),
                            Container(
                                width: AppTheme.cardPadding * 9,
                                child: MyDivider()),
                          ],
                        ),
                        SizedBox(height: AppTheme.elementSpacing,),
                        Container(
                          width: AppTheme.cardPadding * 10,
                          child: LongButtonWidget(
                              leadingIcon: Icon(FontAwesomeIcons.download),
                              title: "Download .apk",
                              buttonType: ButtonType.solid,
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
