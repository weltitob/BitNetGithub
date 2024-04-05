import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/pages/website/seo/seo_text.dart';
import 'package:bitnet/pages/website/website_landingpage/quoteswidget.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seo/seo.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:go_router/go_router.dart';


class PageFooter extends StatefulWidget {
  final WebsiteLandingPageController controller;
  const PageFooter({super.key, required this.controller});

  @override
  State<PageFooter> createState() => _PageFooterState();
}

class _PageFooterState extends State<PageFooter> {
  bool showFab = false;

  void toggleFooter() {
    setState(() {
      showFab = !showFab;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // Diese sind die Breite und Höhe aus den Constraints
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;

      bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
      bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
      bool isSuperSmallScreen =
          constraints.maxWidth < AppTheme.isSuperSmallScreen;
      bool isIntermediateScreen =
          constraints.maxWidth < AppTheme.isIntermediateScreen;

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
      double centerSpacing = isMidScreen
          ? isIntermediateScreen
              ? isSmallScreen
                  ? isSuperSmallScreen
                      ? AppTheme.columnWidth * 0.075
                      : AppTheme.columnWidth * 0.15
                  : AppTheme.columnWidth * 0.35
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
            showFab
                ? Container()
                : Container(
                    padding: EdgeInsets.only(
                        bottom: AppTheme.cardPadding * 10 * spacingMultiplier),
                    child: Quotes(
                      controller: widget.controller,
                    )), //PageFive(controller: widget.controller,),
            buildFooter(
                context, centerSpacing, spacingMultiplier, isSmallScreen),
          ]));
    });
  }

  Widget buildFooter(
      BuildContext context, centerSpacing, spacingMultiplier, isSmallScreen) {
    return Positioned(
      bottom: AppTheme.cardPadding * 3 * spacingMultiplier,
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
                        context.go("/");
                      },
                      child: Row(
                        children: [
                          isSmallScreen
                              ? RoundedButtonWidget(
                                  buttonType: ButtonType.transparent,
                                  iconData: showFab
                                      ? Icons.keyboard_arrow_down_rounded
                                      : Icons.keyboard_arrow_up_rounded,
                                  onTap: () {
                                    toggleFooter();
                                    print("showFab: " + showFab.toString());
                                  },
                                )
                              : Container(),
                          isSmallScreen
                              ? SizedBox(width: AppTheme.cardPadding)
                              : Container(),
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
                          SeoText(
                            tagStyle: TextTagStyle.h6,
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
                  SeoText(
                    tagStyle: TextTagStyle.h6,
                    "©2023 by BitNet GmBH, Germany",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  isSmallScreen
                      ? smallScreenFooter(spacingMultiplier)
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

  Widget smallScreenFooter(spacingMultiplier) {
    double footerHeight = showFab ? 475 : 0; // Adjust these values as needed
    return AnimatedContainer(
      duration: Duration(milliseconds: 300), // Adjust duration as needed
      curve: Curves.easeInOut, // This is the animation curve
      height: footerHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 4 * spacingMultiplier,
          ),
          Row(
            children: [
              product(),
              SizedBox(
                width: AppTheme.cardPadding * 4 * spacingMultiplier,
              ),
              helpandSupport(),
            ],
          ),
          SizedBox(height: AppTheme.cardPadding * 2 * spacingMultiplier),
          socials(spacingMultiplier),
        ],
      ),
    );
  }

  Widget socials(spacingMultiplier) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeoText(
            tagStyle: TextTagStyle.h3,
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
        SeoText(
          tagStyle: TextTagStyle.h3,
          "Product",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(
          platformName: "Get Started",
          onTap: () => context.go('/website'),
        ), // VRouter auth
        SocialRow(
          platformName: "About us",
          onTap: () => context.go('/website/aboutus'),
        ), // About us page (nur ich lol)make roadmap how the app should develop
        SocialRow(
          platformName: "Our Team",
          onTap: () => context.go('/website/ourteam'),
        ),
        SocialRow(
            platformName: "Fund us",
            onTap: () {
              launchUrlString(AppTheme.goFundMeUrl);
            }), // Support the project give money or buy these nfts
        SocialRow(
          platformName: "Whitepaper",
          onTap: () {
            print("Download whitepaper as pdf or smth...");
          },
        ), // whitepaper (webbrowser einfach n tab mit dem whitepaper öffnen

        //reddit??
        //tumblr??
      ],
    );
  }

  Widget helpandSupport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeoText(
          tagStyle: TextTagStyle.h3,
          "Contact",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(
          platformName: "Help Center",
          onTap: () {
            print("Help and Support");
            context.go("/help");
          },
        ), //vrouter help page (faq voreingetsellt)
        SocialRow(
          platformName:
              "Report issue", //bugs, incidents, security issues etc abuse and fraud etc problems in general
          onTap: () {
            print("Help and Support");
            context.go("/website/report");
          },
        ), //vrouter reporting page (bug voreingetsellt)
        SocialRow(
            platformName: "Submit Idea",
            onTap: () {
              context.go('/website/submitidea');
            }), //vrouter reporting page (fraud voreingetsellt)//vrouter reporting page (security voreingetsellt)
        SocialRow(
            platformName: "AGBS",
            onTap: () => context.go('/website/agbs')), //
        SocialRow(
            platformName: "Impressum",
            onTap: () => context.go('/website/impressum')), //
      ],
    );
  }
}

class SocialRow extends StatelessWidget {
  IconData? iconData;
  final String platformName;
  final VoidCallback? onTap; // <-- Declare an onTap function

  SocialRow({
    this.iconData,
    required this.platformName,
    this.onTap, // <-- Initialize it in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing / 1.25),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap, // <-- Use the passed function here
          child: Row(
            children: [
              if (iconData != null)
                Icon(iconData, size: AppTheme.elementSpacing * 1.5),
              if (iconData != null)
                SizedBox(width: AppTheme.elementSpacing / 2),
              SeoText(platformName,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
