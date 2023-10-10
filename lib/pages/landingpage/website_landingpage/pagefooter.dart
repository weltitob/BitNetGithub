import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/container/randomcontainers/randomavatarcontainer.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/socialrow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageFooter extends StatefulWidget {
  const PageFooter({super.key});

  @override
  State<PageFooter> createState() => _PageFooterState();
}

class _PageFooterState extends State<PageFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: darken(Colors.deepPurple, 80),
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
                  margin: EdgeInsets.only(top: AppTheme.cardPadding * 2,),
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
                  margin: EdgeInsets.only(top: AppTheme.cardPadding * 5,),
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
                              '"Our freedom is not for sale!"',
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
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: AppTheme.cardPadding * 2,),
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
        ]));
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: AppTheme.cardPadding * 3,
                      width: AppTheme.cardPadding * 3,
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

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product", style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: AppTheme.elementSpacing,),
                    SocialRow(platformName: "Get Started"),
                    SocialRow(platformName: "Features"),
                    SocialRow(platformName: "Pricing"),
                    SocialRow(platformName: "Roadmap"),
                    SocialRow(platformName: "Whitepaper"),
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
                    SocialRow(platformName: "Contact"),
                    SocialRow(platformName: "Report Bug"),
                    SocialRow(platformName: "Report Abuse"),
                    SocialRow(platformName: "Report Fraud"),
                    SocialRow(platformName: "Report Security Issue"),
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
                            SocialRow(iconData: FontAwesomeIcons.instagram, platformName: "Instagram"),
                            SocialRow(iconData: FontAwesomeIcons.facebook, platformName: "Facebook"),
                            SocialRow(iconData: FontAwesomeIcons.twitter, platformName: "Twitter"),
                            SocialRow(iconData: FontAwesomeIcons.linkedin, platformName: "LinkedIn"),
                            SocialRow(iconData: FontAwesomeIcons.tiktok, platformName: "TikTok"),
                          ],
                        ),
                        SizedBox(width: AppTheme.cardPadding * 2,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SocialRow(iconData: FontAwesomeIcons.youtube, platformName: "YouTube"),
                            SocialRow(iconData: FontAwesomeIcons.pinterest, platformName: "Pinterest"),
                            SocialRow(iconData: FontAwesomeIcons.snapchat, platformName: "Snapchat"),
                            SocialRow(iconData: FontAwesomeIcons.telegram, platformName: "Telegram"),
                            SocialRow(iconData: FontAwesomeIcons.discord, platformName: "Discord"),
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
