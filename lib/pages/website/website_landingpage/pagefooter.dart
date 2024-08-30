import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/pages/website/seo/seo_text.dart';
import 'package:bitnet/pages/website/website_landingpage/quoteswidget.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:seo/seo.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
      bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
      bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;
      bool isIntermediateScreen = constraints.maxWidth < AppTheme.isIntermediateScreen;

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
          color: Theme.of(context).colorScheme.surface,
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
                    padding: EdgeInsets.only(bottom: AppTheme.cardPadding * 10 * spacingMultiplier),
                    child: Quotes(
                      controller: widget.controller,
                    ),
                  ), //PageFive(controller: widget.controller,),
            FooterWidget(
                showFab: showFab,
                centerSpacing: centerSpacing,
                spacingMultiplier: spacingMultiplier,
                isSmallScreen: isSmallScreen,
                toggleFooter: toggleFooter),
          ]));
    });
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
          const SizedBox(
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
          L10n.of(context)!.product,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(
          platformName: L10n.of(context)!.getStarted,
          onTap: () => context.go('/website'),
        ), // VRouter auth
        SocialRow(
          platformName: L10n.of(context)!.aboutUs,
          onTap: () => context.go('/website/aboutus'),
        ), // About us page (nur ich lol)make roadmap how the app should develop
        SocialRow(
          platformName: L10n.of(context)!.ourTeam,
          onTap: () => context.go('/website/ourteam'),
        ),
        SocialRow(
            platformName: L10n.of(context)!.fundUs,
            onTap: () {
              launchUrlString(AppTheme.goFundMeUrl);
            }), // Support the project give money or buy these nfts
        SocialRow(
          platformName: L10n.of(context)!.whitePaper,
          onTap: () {},
        ),
      ],
    );
  }

  Widget helpandSupport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeoText(
          tagStyle: TextTagStyle.h3,
          L10n.of(context)!.contacts,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(
          platformName: L10n.of(context)!.helpCenter,
          onTap: () {
            context.go("/help");
          },
        ), //vrouter help page (faq voreingetsellt)
        SocialRow(
          platformName: L10n.of(context)!.reportIssue, //bugs, incidents, security issues etc abuse and fraud etc problems in general
          onTap: () {
            context.go("/website/report");
          },
        ), //vrouter reporting page (bug voreingetsellt)
        SocialRow(
            platformName: L10n.of(context)!.submitIdea,
            onTap: () {
              context.go('/website/submitidea');
            }), //vrouter reporting page (fraud voreingetsellt)//vrouter reporting page (security voreingetsellt)
        SocialRow(platformName: "AGBS", onTap: () => context.go('/website/agbs')), //
        SocialRow(platformName: "Impressum", onTap: () => context.go('/website/impressum')), //
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
      padding: const EdgeInsets.only(bottom: AppTheme.elementSpacing / 1.25),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap, // <-- Use the passed function here
          child: Row(
            children: [
              if (iconData != null) Icon(iconData, size: AppTheme.elementSpacing * 1.5),
              if (iconData != null) const SizedBox(width: AppTheme.elementSpacing / 2),
              SeoText(platformName, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  final double centerSpacing;
  final double spacingMultiplier;
  final bool isSmallScreen;
  final bool showFab;
  final VoidCallback toggleFooter;

  const FooterWidget({
    Key? key,
    required this.centerSpacing,
    required this.spacingMultiplier,
    required this.isSmallScreen,
    required this.showFab,
    required this.toggleFooter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppTheme.cardPadding * 3 * spacingMultiplier,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: centerSpacing),
        child: Row(
          mainAxisAlignment: isSmallScreen ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        if (isSmallScreen)
                          RoundedButtonWidget(
                            buttonType: ButtonType.transparent,
                            iconData: showFab ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                            onTap: () {
                              toggleFooter();
                              print("showFab: $showFab");
                            },
                          ),
                        if (isSmallScreen) const SizedBox(width: AppTheme.cardPadding),
                        const SizedBox(
                          height: AppTheme.cardPadding * 2.5,
                          width: AppTheme.cardPadding * 2.5,
                          child: Image(
                            image: AssetImage('assets/images/logotransparent.png'),
                          ),
                        ),
                        const SizedBox(width: AppTheme.cardPadding),
                        SeoText(
                          tagStyle: TextTagStyle.h6,
                          "BitNet",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.cardPadding),
                SeoText(
                  tagStyle: TextTagStyle.h6,
                  "©2023 by BitNet GmBH, Germany",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                if (isSmallScreen)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300), // Adjust duration as needed
                    curve: Curves.easeInOut, // This is the animation curve
                    height: showFab ? 475 : 0, // Adjust these values as needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppTheme.cardPadding * 4 * spacingMultiplier,
                        ),
                        Row(
                          children: [
                            const ProductWidget(),
                            SizedBox(
                              width: AppTheme.cardPadding * 4 * spacingMultiplier,
                            ),
                            const HelpAndSupportWidget(),
                          ],
                        ),
                        SizedBox(height: AppTheme.cardPadding * 2 * spacingMultiplier),
                        SocialsWidget(spacingMultiplier: spacingMultiplier),
                      ],
                    ),
                  ),
              ],
            ),
            if (!isSmallScreen)
              Row(
                children: [
                  const ProductWidget(),
                  SizedBox(
                    width: AppTheme.cardPadding * 4 * spacingMultiplier,
                  ),
                  const HelpAndSupportWidget(),
                  SizedBox(
                    width: AppTheme.cardPadding * 4 * spacingMultiplier,
                  ),
                  SocialsWidget(spacingMultiplier: spacingMultiplier),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class SocialsWidget extends StatelessWidget {
  final double spacingMultiplier;

  const SocialsWidget({Key? key, required this.spacingMultiplier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeoText(
          tagStyle: TextTagStyle.h3,
          "Socials",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
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
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeoText(
          tagStyle: TextTagStyle.h3,
          L10n.of(context)!.product,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(
          platformName: L10n.of(context)!.getStarted,
          onTap: () => context.go('/website'),
        ),
        SocialRow(
          platformName: L10n.of(context)!.aboutUs,
          onTap: () => context.go('/website/aboutus'),
        ),
        SocialRow(
          platformName: L10n.of(context)!.ourTeam,
          onTap: () => context.go('/website/ourteam'),
        ),
        SocialRow(
          platformName: L10n.of(context)!.fundUs,
          onTap: () {
            launchUrlString(AppTheme.goFundMeUrl);
          },
        ),
        SocialRow(
          platformName: L10n.of(context)!.whitePaper,
          onTap: () {},
        ),
      ],
    );
  }
}

class HelpAndSupportWidget extends StatelessWidget {
  const HelpAndSupportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeoText(
          tagStyle: TextTagStyle.h3,
          L10n.of(context)!.contacts,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppTheme.elementSpacing,
        ),
        SocialRow(
          platformName: L10n.of(context)!.helpCenter,
          onTap: () {
            context.go("/help");
          },
        ),
        SocialRow(
          platformName: L10n.of(context)!.reportIssue,
          onTap: () {
            context.go("/website/report");
          },
        ),
        SocialRow(
          platformName: L10n.of(context)!.submitIdea,
          onTap: () {
            context.go('/website/submitidea');
          },
        ),
        SocialRow(
          platformName: "AGBS",
          onTap: () => context.go('/website/agbs'),
        ),
        SocialRow(
          platformName: "Impressum",
          onTap: () => context.go('/website/impressum'),
        ),
      ],
    );
  }
}
