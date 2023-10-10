import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/landingpage/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class PageTwo extends StatefulWidget {
  final WebsiteLandingPageController controller;

  const PageTwo({super.key, required this.controller});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isSmallScreen = constraints.maxWidth < 600;

        // Adjust widget sizes based on screen size.
        double textWidth = isSmallScreen ? AppTheme.cardPadding * 20 : AppTheme.cardPadding * 33;
        double subtitleWidth = isSmallScreen ? AppTheme.cardPadding * 15 : AppTheme.cardPadding * 25;
        double spacingMultiplier = isSmallScreen ? 3 : 0.75;

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
                    height: AppTheme.cardPadding * 5 * spacingMultiplier,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Column(
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
                        height: AppTheme.cardPadding * 2 * spacingMultiplier,
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
                        height: AppTheme.cardPadding * 2 * spacingMultiplier,
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
                      Container(),
                      // Container(
                      //     height: AppTheme.cardPadding * 15,
                      //     child: buildFutureLottie(controller.composition, true))
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 5 * spacingMultiplier,
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
                    height: AppTheme.cardPadding * 2 * spacingMultiplier,
                  ),
                  Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                    height: AppTheme.cardPadding * 6,
                    child: StreamBuilder<List<UserData>>(
                      stream: widget.controller.lastUsersStream(),
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
                              controller: widget.controller.scrollController,
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
      );},
    );
  }
}
