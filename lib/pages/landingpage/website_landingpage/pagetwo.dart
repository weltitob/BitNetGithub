import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
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
        bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
        bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

        double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 28;
        double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
        double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
        double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

        return BackgroundWithContent(
        //https://de.fiverr.com/buzzzy/design-a-modern-app-icon-logo?context_referrer=listings_page&source=your_recently_viewed_gigs&ref_ctx_id=1048bfb54f4d89424086c09d740f5724&context=recommendation&pckg_id=1&pos=1&context_alg=recently_viewed&imp_id=43806367-a06d-4aac-8553-a3f253ae12af
        backgroundType: BackgroundType.asset,
        withGradientBottomSmall: true,
        withGradientTopSmall: true,
        withGradientLeftBig: true,
        assetPath: "assets/images/x.png",
        opacity: 0.7,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: centerSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppTheme.cardPadding * 8 * spacingMultiplier,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: textWidth,
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
                    width: subtitleWidth,
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
                height: AppTheme.cardPadding * 4 * spacingMultiplier,
              ),
              isSmallScreen? Container() : Container(
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
                height: AppTheme.cardPadding * 1 * spacingMultiplier,
              ),
              Container(
                margin:
                EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                height: AppTheme.cardPadding * 5.5 ,
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
                      height: AppTheme.cardPadding * 5.5,
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
                              width: AppTheme.cardPadding * 5.5,
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
            ],
          ),
        ),
      );},
    );
  }
}
