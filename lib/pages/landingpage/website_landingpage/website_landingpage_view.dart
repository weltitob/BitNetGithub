import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/bitnetScaffold.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/glassbutton.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/futurelottie.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/custom_card_landigpage.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/socialrow.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class WebsiteLandingPageView extends StatelessWidget {
  final WebsiteLandingPageController controller;

  const WebsiteLandingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      appBar: websiteAppBar(context),
      context: context,
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: controller.pageController,
        children: [
          pageOne(context),
          pageTwo(context),
          pageThree(context),
          pageFour(context),
          pageFooter(context),
        ],
      ),
    );
  }

  AppBar websiteAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: darken(Colors.deepPurple, 80),
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: AppTheme.columnWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: AppTheme.cardPadding * 1.25,
                    width: AppTheme.cardPadding * 1.25,
                    child: Image.asset(
                      "./images/logoclean.png",
                    )),
                SizedBox(
                  width: AppTheme.elementSpacing,
                ),
                Text("BitNet"),
              ],
            ),
            Container(
              width: AppTheme.cardPadding * 20,
              //color: Colors.green,
              child: Center(
                child: StreamBuilder<List<UserData>>(
                    stream: controller.lastTenUsersStream(),
                    builder: (context, userDataSnapshot) {
                      if (!userDataSnapshot.hasData) {
                        return SizedBox(
                            height: AppTheme.cardPadding * 4,
                            child: Center(child: dotProgress(context)));
                      }
                      List<UserData> all_userresults = userDataSnapshot.data!;
                      if (all_userresults.length == 0) {
                        return Container();
                      }
                      List<String> firstFourUsernames = all_userresults.reversed
                          .take(
                              4) // Take the last 4, which means first 4 when reversed
                          .map((user) => user.username)
                          .toList();
                      return AnimatedTextKit(
                        repeatForever: true,
                        pause: Duration(milliseconds: 1000),
                        animatedTexts: [
                          RotateAnimatedText(
                            "We have liftoff! Exclusive Early Access for Invited Users.", // We have liftoff!
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                          RotateAnimatedText(
                            '+2432.0% User-change in the last 7 days!',
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                          RotateAnimatedText(
                            '@${firstFourUsernames[0]} just joined the BitNet!',
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Container(
              //color: Colors.green,
              child: glassButton(
                  iconData: FontAwesomeIcons.circleArrowRight,
                  text: "Get started",
                  onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageOne(BuildContext context) {
    return BackgroundWithContent(
      backgroundType: BackgroundType.asset,
      withGradient: true,
      opacity: 0.7,
      child: Column(
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 7,
          ),
          Container(
            width: AppTheme.cardPadding * 33,
            child: Text(
                "Bitcoin solved the trust, but we the people need to solve the adoption problem!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium),
          ),
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          Container(
            width: AppTheme.cardPadding * 25,
            child: Text(
                "BitNet is not a social network. It's the third layer platform built on the Bitcoin Network.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          Container(
            width: AppTheme.cardPadding * 10,
            child: LongButtonWidget(
                title: L10n.of(context)!.register,
                onTap: () async {
                  VRouter.of(context).to('/pinverification');
                }),
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     buildLastUsersJoined(),
          //     SizedBox(
          //       width: AppTheme.cardPadding,
          //     ),
          //     buildPercentagChange(context),
          //   ],
          // ),
          SizedBox(
            height: AppTheme.cardPadding * 8,
          ),
          StreamBuilder<Object>(
              stream: controller.userCountStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                      height: AppTheme.cardPadding * 4,
                      child: Center(child: dotProgress(context)));
                }
                int currentusernumber = snapshot.data as int;
                num _value = (1000000 - currentusernumber);
                //"${(NumberFormat("#,###", "de_DE").format(1000000 - currentusernumber))}";
                return AnimatedFlipCounter(
                  value: _value,
                  thousandSeparator: ".",
                  decimalSeparator: ",",
                  textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 100,
                      ),
                );
              }),
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          Text(
            "limited spots left!",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
          //hier der slider mit den nfts die man bekommt
          SizedBox(height: AppTheme.cardPadding * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // creating the signup button
              SizedBox(width: AppTheme.cardPadding),
            ],
          ),
        ],
      ),
    );
  }

  //eine page mit explore the blockchain with BitNet...

  //get your decentralized identity...

  //eine page mit so containern wie auf moveworks nur mit 3
  //get your crypto wallet, start sending lightning payments, get your first NFT

  Widget pageTwo(BuildContext context) {
    return Container(
      color: darken(Colors.deepPurple, 80),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              child: Image(
                  height: 900,
                  width: 2000,
                  fit: BoxFit.cover,
                  //https://de.fiverr.com/buzzzy/design-a-modern-app-icon-logo?context_referrer=listings_page&source=your_recently_viewed_gigs&ref_ctx_id=1048bfb54f4d89424086c09d740f5724&context=recommendation&pckg_id=1&pos=1&context_alg=recently_viewed&imp_id=43806367-a06d-4aac-8553-a3f253ae12af
                  image: AssetImage('assets/images/x.png'))),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.7),
          ),
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
                    darken(Colors.deepPurple, 80).withOpacity(0.25),
                    darken(Colors.deepPurple, 80).withOpacity(0.7),
                    darken(Colors.deepPurple, 80),
                    darken(Colors.deepPurple, 80),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.transparent,
                    darken(Colors.deepPurple, 80).withOpacity(0.25),
                    darken(Colors.deepPurple, 80).withOpacity(0.7),
                    darken(Colors.deepPurple, 80),
                    darken(Colors.deepPurple, 80),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.transparent,
                  darken(Colors.deepPurple, 80).withOpacity(0.25),
                  darken(Colors.deepPurple, 80).withOpacity(0.7),
                  darken(Colors.deepPurple, 80),
                  darken(Colors.deepPurple, 80),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppTheme.columnWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildLeftSideOne(context),
                    Container(),
                    // Container(
                    //     height: AppTheme.cardPadding * 15,
                    //     child: buildFutureLottie(controller.composition, true))
                  ],
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 5,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.boltLightning),
                      SizedBox(
                        width: AppTheme.elementSpacing,
                      ),
                      Expanded(child: MyDivider()),
                      SizedBox(
                        width: AppTheme.elementSpacing,
                      ),
                      Text(
                        "History in Making: Be Part with Your Free Bitcoin NFT.",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        width: AppTheme.elementSpacing,
                      ),
                      Expanded(child: MyDivider()),
                      SizedBox(width: AppTheme.elementSpacing),
                      Icon(FontAwesomeIcons.boltLightning),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 2,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                  height: AppTheme.cardPadding * 6,
                  child: StreamBuilder<List<UserData>>(
                    stream: controller.lastTenUsersStream(),
                    builder: (context, userDataSnapshot) {
                      if (!userDataSnapshot.hasData) {
                        return SizedBox(
                            height: AppTheme.cardPadding * 4,
                            child: Center(child: dotProgress(context)));
                      }
                      List<UserData> all_userresults = userDataSnapshot.data!;
                      if (all_userresults.length == 0) {
                        return Container(child: Text("No users found"));
                      }
                      return Container(
                        alignment: Alignment.center,
                        height: AppTheme.cardPadding * 6,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.black,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black
                              ],
                              stops: [
                                0.0,
                                0.2,
                                0.8,
                                1.0
                              ], // You can adjust the stops to control the fade length
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstOut,
                          child: ListView.builder(
                            //physics: NeverScrollableScrollPhysics(),
                            controller: controller.scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: all_userresults.length,
                            itemBuilder: (context, index) {
                              final userData =
                                  all_userresults.reversed.toList()[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding),
                                width: AppTheme.cardPadding * 6,
                                child: Column(
                                  children: [
                                    Avatar(
                                      size: AppTheme.cardPadding * 4,
                                      mxContent:
                                          Uri.parse(userData.profileImageUrl),
                                    ),
                                    SizedBox(
                                        height: AppTheme.elementSpacing / 2),
                                    Text(
                                      "${userData.username}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pageThree(BuildContext context) {
    return Container(
      color: darken(Colors.deepPurple, 80),
      child: Stack(
        children: [
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Image(image: AssetImage('assets/images/metaverse_fb.png')),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.7),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 700,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    darken(Colors.deepPurple, 80).withOpacity(0.25),
                    darken(Colors.deepPurple, 80).withOpacity(0.5),
                    darken(Colors.deepPurple, 80).withOpacity(0.75),
                    darken(Colors.deepPurple, 80),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 700,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.transparent,
                    darken(Colors.deepPurple, 80).withOpacity(0.25),
                    darken(Colors.deepPurple, 80).withOpacity(0.5),
                    darken(Colors.deepPurple, 80).withOpacity(0.75),
                    darken(Colors.deepPurple, 80),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 5,
              ),
              Text(
                "Our mission.",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: AppTheme.cardPadding * 3,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppTheme.columnWidth),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCard(
                      lottieAssetPath:
                          'assets/lottiefiles/wallet_animation.json', // Ihren gewünschten Lottie-Dateipfad hier angeben
                      mainTitle: "We the people, control our money!",
                      subTitle:
                          "We are a simple and secure way to send and receive payments on the Bitcoin Network",
                              //all over the world! Lightning fast and with no additional fees.",
                      buttonText: "Start sending BTC",
                      onButtonTap: () {
                        // Hier Ihre Aktion
                      },
                    ),
                    CustomCard(
                      lottieAssetPath:
                          'assets/lottiefiles/asset_animation.json', // Ihren gewünschten Lottie-Dateipfad hier angeben
                      mainTitle: "We the people, own our data!",
                      subTitle:
                          "We are building a third layer platform on top of the trustless Bitcoin Network.",
                              //"We have our own decentralized identity.",
                      buttonText: "Get a DID",
                      onButtonTap: () {
                        // Hier Ihre Aktion
                      },
                    ),
                    CustomCard(
                      lottieAssetPath:
                          'assets/lottiefiles/wallet_animation.json', // Ihren gewünschten Lottie-Dateipfad hier angeben
                      mainTitle: "We the people, build our future!",
                      subTitle:
                          "and start exploring the blockchain exploring the blockchain.",
                              //"and start exploring the blockchain",
                      buttonText: "Explore BTC",
                      onButtonTap: () {
                        // Hier Ihre Aktion
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget pageFooter(BuildContext context) {
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: AppTheme.cardPadding * 5,),
              child: Stack(
                children: [
                  Positioned(
                    top: AppTheme.cardPadding * 2,
                    left: AppTheme.cardPadding * 2,
                    child: Avatar(
                      size: AppTheme.cardPadding * 4,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 2.5,
                    right: AppTheme.cardPadding * 11,
                    child: Avatar(
                      size: AppTheme.cardPadding * 3,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 0,
                    right: AppTheme.cardPadding * 9,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 0,
                    left: AppTheme.cardPadding * 15.5,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 2,
                    right: AppTheme.cardPadding * 12,
                    child: Avatar(
                      size: AppTheme.cardPadding * 3,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 0.5,
                    right: AppTheme.cardPadding * 10,
                    child: Avatar(
                      size: AppTheme.cardPadding * 3,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 6,
                    left: AppTheme.cardPadding * 0,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 0.5,
                    left: AppTheme.cardPadding * 8,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 0,
                    right: AppTheme.cardPadding * 15,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 0.5,
                    right: AppTheme.cardPadding * 14,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 2.25,
                    right: AppTheme.cardPadding * 20,
                    child: Avatar(
                      size: AppTheme.cardPadding * 4,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 2,
                    left: AppTheme.cardPadding * 9.5,
                    child: Avatar(
                      size: AppTheme.cardPadding * 4,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 7,
                    left: AppTheme.cardPadding * 2.5,
                    child: Avatar(
                      size: AppTheme.cardPadding * 3,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 2,
                    right: AppTheme.cardPadding * 18,
                    child: Avatar(
                      size: AppTheme.cardPadding * 4,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 7,
                    right: AppTheme.cardPadding * 0.5,
                    child: Avatar(
                      size: AppTheme.cardPadding * 3,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 2.5,
                    right: AppTheme.cardPadding * 2,
                    child: Avatar(
                      size: AppTheme.cardPadding * 4,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 2.5,
                    right: AppTheme.cardPadding * 17,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding * 4,
                        vertical: AppTheme.cardPadding * 4,
                    ),
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
                  Positioned(
                    top: AppTheme.cardPadding * 2,
                    right: AppTheme.cardPadding * 0,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 2.25,
                    right: AppTheme.cardPadding * 2.25,
                    child: Avatar(
                      size: AppTheme.cardPadding * 5,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 0.25,
                    left: AppTheme.cardPadding * 10,
                    child: Avatar(
                      size: AppTheme.cardPadding * 5,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 5,
                    left: AppTheme.cardPadding * 0,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 0,
                    left: AppTheme.cardPadding * 6.5,
                    child: Avatar(
                      size: AppTheme.cardPadding * 3,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 2,
                    right: AppTheme.cardPadding * 7,
                    child: Avatar(
                      size: AppTheme.cardPadding * 3,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    top: AppTheme.cardPadding * 0,
                    right: AppTheme.cardPadding * 20,
                    child: Avatar(
                      size: AppTheme.cardPadding * 2,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 2.5,
                    left: AppTheme.cardPadding * 4,
                    child: Avatar(
                      size: AppTheme.cardPadding * 3,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                  Positioned(
                    bottom: AppTheme.cardPadding * 0.5,
                    left: AppTheme.cardPadding * 15,
                    child: Avatar(
                      size: AppTheme.cardPadding * 4,
                      mxContent:
                      Uri.parse("https://static.wixstatic.com/media/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png/v1/fill/w_640,h_366,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/94a51f_584cc92073134fa99e91e0de65bd4020~mv2.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
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
          ),
        ]));
  }

  Widget buildPercentagChange(BuildContext context) {
    return GlassContainer(
      borderThickness: 1.5, // remove border if not active
      blur: 50,
      opacity: 0.1,
      borderRadius: AppTheme.cardRadiusMid,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
        child: Column(
          children: [
            Text(
              "+ 2432.0%",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppTheme.successColor,
                  ),
            ),
            SizedBox(
              height: AppTheme.elementSpacing,
            ),
            Text(
              "Userchange last 7 days",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget pageFour(BuildContext context) {
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
                  height: AppTheme.cardPadding * 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: AppTheme.cardPadding * 25,
                      width: AppTheme.cardPadding * 25,
                      child: Lottie.asset(
                          'assets/lottiefiles/blob.json',),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: AppTheme.cardPadding * 22,
                          margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                          child: Text(
                            "We are the light that helps others see Bitcoin. We form the third layer what the text should be here haha building on the bitcoin blockchain!",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        SizedBox(
                          height: AppTheme.cardPadding * 2,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                          width: AppTheme.cardPadding * 22,
                          child: Text(
                            "Lightning...!",
                            style:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: AppTheme.cardPadding * 2,
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
                SizedBox(
                  height: AppTheme.cardPadding * 5,
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLeftSideOne(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppTheme.cardPadding * 22,
          margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Text(
            "Unlock your gateway to our future of digital assets!",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        SizedBox(
          height: AppTheme.cardPadding * 2,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          width: AppTheme.cardPadding * 22,
          child: Text(
            "Be among the first million users and secure your exclusive, complimentary early-bird Bitcoin inscription!",
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 24),
          ),
        ),
        SizedBox(
          height: AppTheme.cardPadding * 2,
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
    );
  }
}
