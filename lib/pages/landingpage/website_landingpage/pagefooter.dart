import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/container/randomcontainers/randomavatarcontainer.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/socialrow.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vrouter/vrouter.dart';

class PageFooter extends StatefulWidget {
  final WebsiteLandingPageController controller;
  const PageFooter({super.key, required this.controller});

  @override
  State<PageFooter> createState() => _PageFooterState();
}

class _PageFooterState extends State<PageFooter> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
      bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

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
              ? AppTheme.cardPadding
              : AppTheme.columnWidth * 0.65
          : AppTheme.columnWidth;

      return Container(
          color: Theme.of(context).colorScheme.background,
          child: Stack(children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.25),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.75),
                        Colors.black,
                      ],
                    ),
                  ),
                )),
            isSmallScreen
                ? Container()
                : Stack(
                    children: [
                      // Align(
                      //   alignment: Alignment.topCenter,
                      //   child: Container(
                      //     margin: EdgeInsets.only(top: AppTheme.cardPadding * 7 * spacingMultiplier,),
                      //     width: 850 + AppTheme.cardPadding * 10,
                      //     height: 350,
                      //     child: RandomAvatarWidget(
                      //
                      //       start: false,
                      //       width: 850 + AppTheme.cardPadding * 10,
                      //       height: 350,
                      //     ),
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: AppTheme.cardPadding * 18 * spacingMultiplier,
                            left:
                                AppTheme.cardPadding * 35.5 * spacingMultiplier,
                          ),
                          child: Text(
                            '"',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontSize: 170,
                                  fontFamily: GoogleFonts.lobster().fontFamily,
                                  color: AppTheme
                                      .colorBitcoin, // This color will be replaced by the gradient effect
                                ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: AppTheme.cardPadding * 10 * spacingMultiplier,
                          ),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                VRouter.of(context).to("/register");
                              },
                              child: GlassContainer(
                                borderThickness:
                                    1.5, // remove border if not active
                                blur: 50,
                                opacity: 0.1,
                                borderRadius: AppTheme.cardRadiusBigger,
                                child: Container(
                                  width: 850,
                                  height: 240,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding * 2,
                                    vertical: AppTheme.cardPadding * 2,
                                  ),
                                  child: Container(
                                    //color: Colors.green.withOpacity(0.1),
                                    child: Container(
                                      width: AppTheme.cardPadding * 24,
                                      child: AnimatedTextKit(
                                        isRepeatingAnimation: false,
                                        animatedTexts: [
                                          TypewriterAnimatedText(
                                            '"This feels like the time the first iPhone was announced"',
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                              color: AppTheme.white90, // This color will be replaced by the gradient effect
                                            ),
                                            speed: const Duration(
                                                milliseconds: 100),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // child: ShaderMask(
                                  //   shaderCallback: (bounds) => LinearGradient(
                                  //       colors: [
                                  //         AppTheme.colorBitcoin,
                                  //         AppTheme.colorPrimaryGradient, // You can change this to any other color to achieve the gradient effect you want
                                  //       ],
                                  //       begin: Alignment.topCenter,
                                  //       end: Alignment.bottomCenter,
                                  //       tileMode: TileMode.clamp
                                  //   ).createShader(bounds),
                                  //   child:
                                  //   AnimatedTextKit(
                                  //     isRepeatingAnimation: false,
                                  //     animatedTexts: [
                                  //
                                  //       TypewriterAnimatedText(
                                  //         '"We take it in our own hands!"',
                                  //         textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                                  //           color: Colors.white, // This color will be replaced by the gradient effect
                                  //         ),
                                  //         speed: const Duration(milliseconds: 100),
                                  //       ),
                                  //       TypewriterAnimatedText(
                                  //         '      Join the revolution now!',
                                  //         textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                                  //           color: Colors.white, // This color will be replaced by the gradient effect
                                  //         ),
                                  //         speed: const Duration(milliseconds: 100),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin: EdgeInsets.only(
                              top: AppTheme.cardPadding *
                                  18.5 *
                                  spacingMultiplier,
                            ),
                            child: buildIndicator(
                              dotHeight: AppTheme.elementSpacing,
                              dotWidth: AppTheme.elementSpacing,
                              pageController: pageController,
                              count: 3,
                            )),
                      ),

                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                            top:
                                AppTheme.cardPadding * 7.75 * spacingMultiplier,
                            right:
                                AppTheme.cardPadding * 36.5 * spacingMultiplier,
                          ),
                          child: Text(
                            '"',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontSize: 170,
                                  fontFamily: GoogleFonts.lobster().fontFamily,
                                  color: AppTheme
                                      .colorBitcoin, // This color will be replaced by the gradient effect
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: AppTheme.cardPadding * 8 * spacingMultiplier,
                          ),
                          child: GlassContainer(
                            borderThickness: 1.5, // remove border if not active
                            blur: 50,
                            opacity: 0.1,
                            borderRadius: AppTheme.cardRadiusBigger,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing,
                                vertical: AppTheme.elementSpacing,
                              ),
                              height: AppTheme.cardPadding * 2.5,
                              width: AppTheme.cardPadding * 12,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Avatar(
                                    mxContent:
                                    Uri.parse("https://matrix.org/m"),

                                    //mxContent: ,
                                    size: AppTheme.cardPadding * 2.5,
                                  ),
                                  SizedBox(
                                    width: AppTheme.cardPadding * 0.5,
                                    height: 1,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "@nameofperson",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      SizedBox(
                                        height:
                                        AppTheme.elementSpacing / 2,
                                      ),
                                      Text(
                                        "Joined BitNet 2 days ago",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.topCenter,
                      //   child: Container(
                      //     margin: EdgeInsets.only(top: AppTheme.cardPadding * 7 * spacingMultiplier,),
                      //     width: 850 + AppTheme.cardPadding * 10,
                      //     height: 350,
                      //     child: RandomAvatarWidget(
                      //       start: true,
                      //       width: 850 + AppTheme.cardPadding * 10,
                      //       height: 350,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
            buildFooter(
                context, centerSpacing, spacingMultiplier, isSmallScreen),
          ]));
    });
  }

  Widget buildFooter(
      BuildContext context, centerSpacing, spacingMultiplier, isSmallScreen) {
    return Positioned(
      bottom: AppTheme.cardPadding * 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: centerSpacing),
        child: Row(
          mainAxisAlignment: isSmallScreen
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: double.infinity,
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        VRouter.of(context).to("/");
                      },
                      child: Row(
                        children: [
                          Container(
                            height: AppTheme.cardPadding * 2.5,
                            width: AppTheme.cardPadding * 2.5,
                            child: Image(
                                image: AssetImage(
                                    'assets/images/logotransparent.png')),
                          ),
                          SizedBox(
                            width: AppTheme.cardPadding,
                          ),
                          Text(
                            "BitNet",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  Text(
                    "©2023 by BitNet GmBH, Germany",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  isSmallScreen
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height:
                                  AppTheme.cardPadding * 4 * spacingMultiplier,
                            ),
                            Row(
                              children: [
                                product(),
                                SizedBox(
                                  width: AppTheme.cardPadding *
                                      4 *
                                      spacingMultiplier,
                                ),
                                helpandSupport(),
                              ],
                            ),
                            SizedBox(
                                height: AppTheme.cardPadding *
                                    2 *
                                    spacingMultiplier),
                            socials(spacingMultiplier),
                          ],
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
            isSmallScreen
                ? Container()
                : Row(
                    children: [
                      product(),
                      SizedBox(
                        width: AppTheme.cardPadding * 4 * spacingMultiplier,
                      ),
                      helpandSupport(),
                      SizedBox(
                        width: AppTheme.cardPadding * 4 * spacingMultiplier,
                      ),
                      socials(spacingMultiplier),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget socials(spacingMultiplier) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Socials",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: AppTheme.elementSpacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SocialRow(
                    iconData: FontAwesomeIcons.instagram,
                    platformName: "Instagram",
                    onTap: () {
                      launchUrlString(AppTheme.instagramUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.facebook,
                    platformName: "Facebook",
                    onTap: () {
                      launchUrlString(AppTheme.facebookUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.twitter,
                    platformName: "Twitter",
                    onTap: () {
                      launchUrlString(AppTheme.twitterUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.linkedin,
                    platformName: "LinkedIn",
                    onTap: () {
                      launchUrlString(AppTheme.linkedinUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.tiktok,
                    platformName: "TikTok",
                    onTap: () {
                      launchUrlString(AppTheme.tiktokUrl);
                    },
                  ),
                ],
              ),
              SizedBox(
                width: AppTheme.cardPadding * 2 * spacingMultiplier,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SocialRow(
                    iconData: FontAwesomeIcons.youtube,
                    platformName: "YouTube",
                    onTap: () {
                      launchUrlString(AppTheme.youtubeUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.pinterest,
                    platformName: "Pinterest",
                    onTap: () {
                      launchUrlString(AppTheme.pinterestUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.snapchat,
                    platformName: "Snapchat",
                    onTap: () {
                      launchUrlString(AppTheme.snapchatUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.telegram,
                    platformName: "Telegram",
                    onTap: () {
                      launchUrlString(AppTheme.telegramUrl);
                    },
                  ),
                  SocialRow(
                    iconData: FontAwesomeIcons.discord,
                    platformName: "Discord",
                    onTap: () {
                      launchUrlString(AppTheme.discordUrl);
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget product() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(platformName: "Get Started"), // VRouter auth
        SocialRow(platformName: "About us"), // About us page (nur ich lol)
        SocialRow(
            platformName:
                "Fund us"), // Support the project give money or buy these nfts
        SocialRow(
            platformName: "Roadmap"), // make roadmap how the app should develop
        SocialRow(
            platformName:
                "Whitepaper"), // whitepaper (webbrowser einfach n tab mit dem whitepaper öffnen
        //reddit??
        //tumblr??
      ],
    );
  }

  Widget helpandSupport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Help and Support",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(platformName: "Contact"), //lauch gmail mit contact@mybitnet
        SocialRow(
            platformName:
                "Report incident"), //vrouter reporting page (bug voreingetsellt)
        SocialRow(
            platformName:
                "Report Abuse"), //vrouter reporting page (abuse voreingetsellt)
        SocialRow(
            platformName:
                "Report Fraud"), //vrouter reporting page (fraud voreingetsellt)
        SocialRow(
            platformName:
                "Report Security Issue"), //vrouter reporting page (security voreingetsellt)
      ],
    );
  }
}
