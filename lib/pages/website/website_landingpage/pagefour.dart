import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:vrouter/vrouter.dart';

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
        bool isSuperSmallScreen =
            constraints.maxWidth < AppTheme.isSuperSmallScreen;
        bool isIntermediateScreen = constraints.maxWidth < AppTheme.isIntermediateScreen;

        double bigtextWidth = isMidScreen
            ? isSmallScreen
                ? isSuperSmallScreen
                    ? AppTheme.cardPadding * 13
                    : AppTheme.cardPadding * 24
                : AppTheme.cardPadding * 28
            : AppTheme.cardPadding * 30;
        double textWidth = isMidScreen
            ? isSmallScreen
                ? isSuperSmallScreen
                    ? AppTheme.cardPadding * 13
                    : AppTheme.cardPadding * 16
                : AppTheme.cardPadding * 22
            : AppTheme.cardPadding * 24;
        double subtitleWidth = isMidScreen
            ? isSmallScreen
                ? isSuperSmallScreen
                    ? AppTheme.cardPadding * 13
                    : AppTheme.cardPadding * 16
                : AppTheme.cardPadding * 18
            : AppTheme.cardPadding * 22;
        double spacingMultiplier = isMidScreen
            ? isSmallScreen
                ? isSuperSmallScreen
                    ? 0.25
                    : 0.5
                : 0.75
            : 1;
        double centerSpacing = isMidScreen ? isIntermediateScreen
            ? isSmallScreen
            ? isSuperSmallScreen
            ? AppTheme.columnWidth * 0.075
            : AppTheme.columnWidth * 0.15
            : AppTheme.columnWidth * 0.35
            : AppTheme.columnWidth * 0.65
            : AppTheme.columnWidth;


        return BackgroundWithContent(
          opacity: 0.7,
          backgroundType: BackgroundType.asset,
          withGradientTopSmall: true,
          withGradientBottomSmall: true,
          withGradientRightBig: true,
          child: Container(
            margin: isSmallScreen
                ? EdgeInsets.symmetric(horizontal: 0)
                : EdgeInsets.symmetric(horizontal: centerSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isSmallScreen ? Container() : mobileWithPicture(),
                    Stack(
                      children: [
                        // isSmallScreen
                        //     ? Positioned(
                        //         left: MediaQuery.of(context).size.width / 10,
                        //         top: MediaQuery.of(context).size.height / 10,
                        //         child: Container(
                        //           alignment: Alignment.center,
                        //           height:
                        //               MediaQuery.of(context).size.width * 0.25,
                        //           width:
                        //               MediaQuery.of(context).size.width * 0.25,
                        //           child: Image.asset(
                        //             'assets/images/logoclean.png',
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       )
                        //     : Container(),
                        isSmallScreen
                            ? Align(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  alignment: Alignment.center,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height:
                                        MediaQuery.of(context).size.height * 0.9,
                                    width: MediaQuery.of(context).size.width * 0.35 + 250,
                                    child: Stack(
                                      children: [
                                        // Align(
                                        //   alignment: Alignment.center,
                                        //   child: Container(
                                        //     height:
                                        //         MediaQuery.of(context).size.height *
                                        //             0.5,
                                        //     decoration: BoxDecoration(
                                        //       borderRadius: AppTheme.cardRadiusBig,
                                        //       color: Theme.of(context).colorScheme.background,
                                        //     ),
                                        //     margin: EdgeInsets.symmetric(
                                        //       horizontal:
                                        //             AppTheme.elementSpacing,
                                        //     )),
                                        // ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            child: Image.asset(
                                              'assets/images/phone.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        bottomGradientPhone(),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          height: isSmallScreen
                              ? MediaQuery.of(context).size.height * 0.9
                            :  500,
                          width: isSmallScreen
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width / 2.6,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: isSmallScreen
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: isSmallScreen
                                    ? EdgeInsets.only(
                                        top: AppTheme.cardPadding * 4)
                                    : EdgeInsets.symmetric(horizontal: 0),
                                width: isSmallScreen
                                    ? 180 + MediaQuery.of(context).size.width / 3.5
                                    : textWidth,
                                child: Text(
                                  "More and more join us each day!",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              SizedBox(
                                height: AppTheme.cardPadding *
                                    2 *
                                    spacingMultiplier,
                              ),
                              Container(
                                width: isSmallScreen
                                    ? 180 + MediaQuery.of(context).size.width / 3.5
                                    : subtitleWidth,
                                child: Text(
                                  "Get the app now and join the BitNet community too!",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              SizedBox(
                                  height: AppTheme.cardPadding *
                                      4 *
                                      spacingMultiplier),
                              buildAllButtons(isSmallScreen, isIntermediateScreen),
                            ],
                          ),
                        ),
                        isSmallScreen
                            ? Positioned(
                                bottom: MediaQuery.of(context).size.height / 12,
                                left:  MediaQuery.of(context).size.width * 0.65 - 80,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width / 2.5,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Lottie.asset(
                                    'assets/lottiefiles/chartgoup.json',
                                    fit: BoxFit.cover,
                                    repeat: false,
                                  ),
                                ))
                            : Container(),
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
        );
      },
    );
  }

  Widget buildAllButtons(isSmallScreen, isIntermediateScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width:
              isSmallScreen ? 180 + MediaQuery.of(context).size.width / 3.5 : 500,
          child: Row(
            mainAxisAlignment: isIntermediateScreen ? isSmallScreen
                ? MainAxisAlignment.start
                : MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              ...downloadFromStores(isIntermediateScreen), // Using the spread operator
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.cardPadding,
        ),
        isIntermediateScreen ? Container() : downloadAPKButton(),
      ],
    );
  }

  Widget downloadAPKButton() {
    return Column(
      children: [
        Container(
          height: AppTheme.cardPadding,
          width: AppTheme.cardPadding * 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: MyDivider()),
              SizedBox(
                width: AppTheme.elementSpacing,
              ),
              Text(
                "OR",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                width: AppTheme.elementSpacing,
              ),
              Expanded(child: MyDivider()),
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.cardPadding,
        ),
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
    );
  }

  Widget mobileWithPicture() {
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
                        padding:
                            EdgeInsets.only(bottom: AppTheme.elementSpacing),
                        height: AppTheme.cardPadding * 18.6,
                        width: AppTheme.cardPadding * 18.25,
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/images/screenshot_small.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing),
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
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(
                    right: AppTheme.elementSpacing * 1.5,
                    bottom: AppTheme.elementSpacing * 0),
                height: AppTheme.cardPadding * 8,
                width: AppTheme.cardPadding * 8,
                child: Lottie.asset(
                  'assets/lottiefiles/chartgoup.json', //phone_bubbles
                  fit: BoxFit.cover,
                ),
              )),
          bottomGradientPhone(),
        ],
      ),
    );
  }

  Widget bottomGradientPhone(){
    return Align(
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
                    Theme.of(context).colorScheme.background,
                  ],
                )),
          ),
        ],
      ),
    );
  }

  List<Widget> downloadFromStores(isIntermediateScreen) {
    return [
      isIntermediateScreen
          ? Icon(
              FontAwesomeIcons.googlePlay,
              size: AppTheme.cardPadding * 1.4,
            )
          : Container(
              width: AppTheme.cardPadding * 10,
              child: LongButtonWidget(
                  leadingIcon: Icon(
                    color: AppTheme.white90,
                    FontAwesomeIcons.googlePlay,
                  ),
                  title: "Google Play",
                  buttonType: ButtonType.transparent,
                  onTap: () async {
                    VRouter.of(context).to('/pinverification');
                  }),
            ),
      SizedBox(
        width: AppTheme.elementSpacing,
        height: AppTheme.elementSpacing,
      ),
      isIntermediateScreen
          ? Icon(
              FontAwesomeIcons.apple,
              size: AppTheme.cardPadding * 1.6,
              color: AppTheme.white90,
            )
          : Container(
              width: AppTheme.cardPadding * 10,
              child: LongButtonWidget(
                  leadingIcon: Icon(FontAwesomeIcons.apple),
                  title: "Apple Store",
                  buttonType: ButtonType.transparent,
                  onTap: () async {
                    VRouter.of(context).to('/pinverification');
                  }),
            ),
      isIntermediateScreen
          ? SizedBox(
              width: AppTheme.elementSpacing,
              height: AppTheme.elementSpacing,
            )
          : Container(),
      isIntermediateScreen
          ? Icon(
              color: AppTheme.white90,
              FontAwesomeIcons.download,
              size: AppTheme.cardPadding * 1.35,
            )
          : Container(),
    ];
  }
}
