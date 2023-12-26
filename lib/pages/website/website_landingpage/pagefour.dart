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
        bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;

        double bigtextWidth = isMidScreen ? isSmallScreen ? isSuperSmallScreen ? AppTheme.cardPadding * 13 : AppTheme.cardPadding * 24 : AppTheme.cardPadding * 28 : AppTheme.cardPadding * 30;
        double textWidth = isMidScreen ? isSmallScreen ? isSuperSmallScreen ? AppTheme.cardPadding * 13 : AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
        double subtitleWidth = isMidScreen ? isSmallScreen ?isSuperSmallScreen ?  AppTheme.cardPadding * 13 : AppTheme.cardPadding * 16 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
        double spacingMultiplier = isMidScreen ? isSmallScreen ? isSuperSmallScreen ? 0.25 : 0.5 : 0.75 : 1;
        double centerSpacing = isMidScreen ? isSmallScreen ? isSuperSmallScreen ? AppTheme.columnWidth * 0.075 : AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

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
                    isSmallScreen ? Container() :
                    mobileWithPicture(),
                    Stack(
                      children: [
                        isSmallScreen ? Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          width: MediaQuery.of(context).size.width * 0.85,
                          padding: EdgeInsets.only(bottom: AppTheme.elementSpacing ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/phone.png',
                            fit: BoxFit.cover,
                          ),
                        ) : Container(),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                  Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              SizedBox(
                                height: AppTheme.cardPadding * 2 * spacingMultiplier
                              ),
                              isSmallScreen
                                  ? Column(
                                children: [
                                  ...downloadFromStores(), // Using the spread operator
                                ],
                              )
                                  : Row(
                                children: [
                                  ...downloadFromStores(), // Using the spread operator
                                ],
                              ),
                              SizedBox(height: AppTheme.cardPadding,),
                              Container(
                                height: AppTheme.cardPadding,
                                width: isSmallScreen ? AppTheme.cardPadding * 10 : AppTheme.cardPadding * 22,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: MyDivider()),
                                    SizedBox(width: AppTheme.elementSpacing,),
                                    Text("OR", style: Theme.of(context).textTheme.bodyLarge,),
                                    SizedBox(width: AppTheme.elementSpacing,),
                                    Expanded(
                                        child: MyDivider()),
                                  ],
                                ),
                              ),
                              SizedBox(height: AppTheme.cardPadding,),
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

  Widget mobileWithPicture(){
    return Container(
      height: AppTheme.cardPadding * 20,
      width: AppTheme.cardPadding * 20,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: AppTheme.cardPadding * 20,
                width: AppTheme.cardPadding * 20,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(bottom: AppTheme.elementSpacing ),
                        height: AppTheme.cardPadding * 18.6,
                        width: AppTheme.cardPadding * 18.25,
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/images/screenshot_small.png',
                          fit: BoxFit.cover,),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing ),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/phone.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: AppTheme.cardPadding * 6,
                width: AppTheme.cardPadding * 6,
                child: Lottie.asset(
                  'assets/lottiefiles/phone_bubbles.json',
                  fit: BoxFit.cover,
                ),
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: AppTheme.cardPadding * 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(AppTheme.cardPadding),
                        bottomRight: Radius.circular(AppTheme.cardPadding),
                        topLeft: Radius.circular(AppTheme.cardPadding),
                        topRight: Radius.circular(AppTheme.cardPadding),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).colorScheme.background,],)),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List <Widget> downloadFromStores(){
    return [
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
      SizedBox(width: AppTheme.elementSpacing, height: AppTheme.elementSpacing,),
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
    ];
  }
}
