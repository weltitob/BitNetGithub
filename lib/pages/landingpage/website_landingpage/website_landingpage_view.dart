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
          pageFooter(context),
        ],
      ),
    );
  }

  AppBar websiteAppBar(BuildContext context) {

    return AppBar(
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
                          .take(4) // Take the last 4, which means first 4 when reversed
                          .map((user) => user.username)
                          .toList();
                      return AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          RotateAnimatedText(
                            "We have liftoff! Exclusive Early Access for Invited Users.", // We have liftoff!
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                          RotateAnimatedText(
                            '+ 2432.0% Userchange the last 7 days...',
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
            glassButton(
                iconData: FontAwesomeIcons.circleArrowRight,
                text: "Get started",
                onTap: () {})
          ],
        ),
      ),
    );
  }

  Widget pageOne(BuildContext context) {
    return BackgroundWithContent(
      backgroundType: BackgroundType.lottie,
      opacity: 0.8,
      child: Column(
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 6,
          ),
          Container(
            width: AppTheme.cardPadding * 33,
            child: Text(
                "Bitcoin solved the trust, but we the people need to solve the adoption problem!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium),
          ),
          // Lottie.asset(
          //   'assets/lottiefiles/line.json',
          // ),
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          Container(
            width: AppTheme.cardPadding * 25,
            child: Text(
                "Be among the first million users and secure your exclusive, complimentary early-bird Bitcoin inscription!",
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
            height: AppTheme.cardPadding * 7,
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
          )
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
      child: Container(
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
                Container(
                    height: AppTheme.cardPadding * 15,
                    child: buildFutureLottie(controller.composition, true))
              ],
            ),
            SizedBox(
              height: AppTheme.cardPadding * 5,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
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
              margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
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
                                SizedBox(height: AppTheme.elementSpacing / 2),
                                Text(
                                  "${userData.username}",
                                  style: Theme.of(context).textTheme.bodySmall,
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
    );
  }

  Widget pageThree(BuildContext context){
    return Container(

    );
  }

  Widget pageFooter(BuildContext context){
    return Container();
  }

  Widget buildLastUsersJoined() {
    return GlassContainer(
      borderThickness: 1.5, // remove border if not active
      blur: 50,
      opacity: 0.1,
      borderRadius: AppTheme.cardRadiusMid,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
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
                  .take(4) // Take the last 4, which means first 4 when reversed
                  .map((user) => user.username)
                  .toList();
              return Column(
                children: [
                  Text(
                    "@${firstFourUsernames[0]} just joined the BitNet!",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "@${firstFourUsernames[1]} just joined the BitNet!",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "@${firstFourUsernames[2]} just joined the BitNet!",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    "@${firstFourUsernames[3]} just joined the BitNet!",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 8),
                  ),
                ],
              );
            }),
      ),
    );
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

  Widget buildLeftSideOne(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppTheme.cardPadding * 22,
          margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Text(
            "Unlock your gateway to the future of digital assets!",
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
