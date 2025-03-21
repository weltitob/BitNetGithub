import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/website/emailfetcher.dart';
import 'package:bitnet/pages/website/seo/seo_text.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';

class PageTwo extends StatefulWidget {
  final WebsiteLandingPageController controller;

  const PageTwo({super.key, required this.controller});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    final latestUserData = Provider.of<List<UserData>>(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Check if the screen width is less than 600 pixels.
        bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
        bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
        bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;
        bool isIntermediateScreen = constraints.maxWidth < AppTheme.isIntermediateScreen;

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
                    ? 0.5
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

        return BackgroundWithContent(
          //https://de.fiverr.com/buzzzy/design-a-modern-app-icon-logo?context_referrer=listings_page&source=your_recently_viewed_gigs&ref_ctx_id=1048bfb54f4d89424086c09d740f5724&context=recommendation&pckg_id=1&pos=1&context_alg=recently_viewed&imp_id=43806367-a06d-4aac-8553-a3f253ae12af
          backgroundType: BackgroundType.asset,
          withGradientBottomSmall: true,
          withGradientTopSmall: true,
          withGradientLeftBig: true,
          assetPath: "assets/images/x.png",
          opacity: 0.7,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: centerSpacing + AppTheme.cardPadding * spacingMultiplier),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppTheme.cardPadding * 1 * spacingMultiplier,
                      ),
                      Container(
                        width: textWidth,
                        child: SeoText(
                          tagStyle: TextTagStyle.h1,
                          L10n.of(context)!.weUnlockAssets,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding * 1 * spacingMultiplier,
                      ),
                      Container(
                        width: subtitleWidth,
                        child: SeoText(L10n.of(context)!.beAmongFirst, style: Theme.of(context).textTheme.bodyLarge),
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding * 1.5 * spacingMultiplier,
                      ),
                      Container(
                        width: AppTheme.cardPadding * 10,
                        child: LongButtonWidget(
                            title: L10n.of(context)!.register,
                            onTap: () async {
                              // Original redirect commented out
                              // context.go('/authhome/pinverification');
                              
                              // Show early bird dialog instead
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  bool isSuperSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSuperSmallScreen;
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: isSuperSmallScreen ? 20 : 40,
                                      vertical: isSuperSmallScreen ? 24 : 40,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                                        child: const EmailFetcherLandingPage(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 3 + AppTheme.cardPadding * 3 * spacingMultiplier,
                ),
                isSmallScreen
                    ? Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SeoText(
                              tagStyle: TextTagStyle.h2,
                              L10n.of(context)!.claimNFT,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              width: AppTheme.elementSpacing,
                            ),
                            Expanded(child: MyDivider()),
                          ],
                        ),
                      )
                    : Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.boltLightning),
                            const SizedBox(
                              width: AppTheme.elementSpacing,
                            ),
                            Expanded(child: MyDivider()),
                            const SizedBox(
                              width: AppTheme.elementSpacing,
                            ),
                            SeoText(
                              L10n.of(context)!.historyClaim,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              width: AppTheme.elementSpacing,
                            ),
                            Expanded(child: MyDivider()),
                            const SizedBox(width: AppTheme.elementSpacing),
                            const Icon(FontAwesomeIcons.boltLightning),
                          ],
                        ),
                      ),
                SizedBox(
                  height: AppTheme.cardPadding * 2 * spacingMultiplier,
                ),
                Container(
                  height: AppTheme.cardPadding * 5.5,
                  child: latestUserData.isEmpty
                      ? SizedBox(height: AppTheme.cardPadding * 4, child: Center(child: dotProgress(context)))
                      : Container(
                          alignment: Alignment.center,
                          height: AppTheme.cardPadding * 5.5,
                          child: HorizontalFadeListView(
                            child: ListView.builder(
                              //physics: NeverScrollableScrollPhysics(),
                              controller: widget.controller.scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: latestUserData.length,
                              itemBuilder: (context, index) {
                                final userData = latestUserData.reversed.toList()[index];
                                return Container(
                                  width: AppTheme.cardPadding * 5.5,
                                  child: Column(
                                    children: [
                                      Avatar(
                                          size: AppTheme.cardPadding * 4,
                                          mxContent: Uri.parse(userData.profileImageUrl),
                                          isNft: userData.nft_profile_id.isNotEmpty),
                                      const SizedBox(height: AppTheme.elementSpacing / 2),
                                      Container(
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "${userData.username}",
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
