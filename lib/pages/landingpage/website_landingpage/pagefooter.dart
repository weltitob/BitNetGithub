import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/container/randomcontainers/randomavatarcontainer.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/socialrow.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
          bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

          double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 20 : AppTheme.cardPadding * 25 : AppTheme.cardPadding * 33;
          double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
          double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
          double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

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
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: AppTheme.cardPadding * 5,),
                    width: 850 + AppTheme.cardPadding * 10,
                    height: 350,
                    child: RandomAvatarWidget(

                      start: false,
                      width: 850 + AppTheme.cardPadding * 10,
                      height: 350,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: AppTheme.cardPadding * 8,),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: (){
                          VRouter.of(context).to("/register");
                        },
                        child: GlassContainer(
                          borderThickness: 1.5, // remove border if not active
                          blur: 50,
                          opacity: 0.1,
                          borderRadius: AppTheme.cardRadiusMid,
                          child: Container(
                            width: 850,
                            padding: EdgeInsets.symmetric(
                                horizontal: AppTheme.cardPadding * 3,
                                vertical: AppTheme.cardPadding * 3
                            ),
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    AppTheme.colorBitcoin,
                                    AppTheme.colorPrimaryGradient, // You can change this to any other color to achieve the gradient effect you want
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  tileMode: TileMode.clamp
                              ).createShader(bounds),
                              child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    '"We take it in our own hands!"',
                                    textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                                      color: Colors.white, // This color will be replaced by the gradient effect
                                    ),
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                  TypewriterAnimatedText(
                                    '      Join the revolution now!',
                                    textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                                      color: Colors.white, // This color will be replaced by the gradient effect
                                    ),
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: AppTheme.cardPadding * 5,),
                    width: 850 + AppTheme.cardPadding * 10,
                    height: 350,
                    child: RandomAvatarWidget(
                      start: true,
                      width: 850 + AppTheme.cardPadding * 10,
                      height: 350,
                    ),
                  ),
                ),
              ],
            ),
            buildFooter(context),
          ]));}
    );
  }

  Widget buildFooter(BuildContext context){
    return Positioned(
      bottom: AppTheme.cardPadding * 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: AppTheme.columnWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: (){},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: AppTheme.cardPadding * 2.5,
                          width: AppTheme.cardPadding * 2.5,
                          child: Image(
                              image: AssetImage('assets/images/logotransparent.png')),
                        ),
                        SizedBox(
                          width: AppTheme.cardPadding,
                        ),
                        Text("BitNet", style: Theme.of(context).textTheme.displaySmall,),
                      ],
                    ),
                    SizedBox(height: AppTheme.cardPadding,),
                    Text("©2023 by BitNet GmBH, Germany", style: Theme.of(context).textTheme.labelSmall,),
                  ],
                ),
              ),
            ),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product", style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: AppTheme.elementSpacing,),
                    SocialRow(platformName: "Get Started"), // VRouter auth
                    SocialRow(platformName: "About us"), // About us page (nur ich lol)
                    SocialRow(platformName: "Fund us"), // Support the project give money or buy these nfts
                    SocialRow(platformName: "Roadmap"), // make roadmap how the app should develop
                    SocialRow(platformName: "Whitepaper"), // whitepaper (webbrowser einfach n tab mit dem whitepaper öffnen
                    //reddit??
                    //tumblr??
                  ],
                ),
                SizedBox(width: AppTheme.cardPadding * 4,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Help and Support", style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: AppTheme.elementSpacing,),
                    SocialRow(platformName: "Contact"), //lauch gmail mit contact@mybitnet
                    SocialRow(platformName: "Report Bug"), //vrouter reporting page (bug voreingetsellt)
                    SocialRow(platformName: "Report Abuse"), //vrouter reporting page (abuse voreingetsellt)
                    SocialRow(platformName: "Report Fraud"), //vrouter reporting page (fraud voreingetsellt)
                    SocialRow(platformName: "Report Security Issue"), //vrouter reporting page (security voreingetsellt)
                  ],
                ),
                SizedBox(width: AppTheme.cardPadding * 4,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Socials", style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: AppTheme.elementSpacing,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SocialRow(iconData: FontAwesomeIcons.instagram, platformName: "Instagram", onTap: (){
                              launchUrlString(AppTheme.instagramUrl);
                            },),
                            SocialRow(iconData: FontAwesomeIcons.facebook, platformName: "Facebook", onTap: (){
                              launchUrlString(AppTheme.facebookUrl);
                            },),
                            SocialRow(iconData: FontAwesomeIcons.twitter, platformName: "Twitter", onTap: (){
                              launchUrlString(AppTheme.twitterUrl);
                            },),
                            SocialRow(iconData: FontAwesomeIcons.linkedin, platformName: "LinkedIn", onTap: (){
                              launchUrlString(AppTheme.linkedinUrl);
                            },),
                            SocialRow(iconData: FontAwesomeIcons.tiktok, platformName: "TikTok", onTap: (){
                              launchUrlString(AppTheme.tiktokUrl);
                            },),
                          ],
                        ),
                        SizedBox(width: AppTheme.cardPadding * 2,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SocialRow(iconData: FontAwesomeIcons.youtube, platformName: "YouTube", onTap: (){
                              launchUrlString(AppTheme.youtubeUrl);
                            },),
                            SocialRow(iconData: FontAwesomeIcons.pinterest, platformName: "Pinterest", onTap: (){
                              launchUrlString(AppTheme.pinterestUrl);
                            },),
                            SocialRow(iconData: FontAwesomeIcons.snapchat, platformName: "Snapchat", onTap: (){
                              launchUrlString(AppTheme.snapchatUrl);
                            },),
                            SocialRow(iconData: FontAwesomeIcons.telegram, platformName: "Telegram", onTap: (){
                              launchUrlString(AppTheme.telegramUrl);
                            },),
                            SocialRow(iconData: FontAwesomeIcons.discord, platformName: "Discord", onTap: (){
                              launchUrlString(AppTheme.discordUrl);
                            },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
