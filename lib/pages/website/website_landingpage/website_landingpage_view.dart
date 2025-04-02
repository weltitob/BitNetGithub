import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetFAB.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/website/emailfetcher.dart';
import 'package:bitnet/pages/website/seo/seo_container.dart';
import 'package:bitnet/pages/website/seo/structured_data.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefooter.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefour.dart';
import 'package:bitnet/pages/website/website_landingpage/pageone.dart';
import 'package:bitnet/pages/website/website_landingpage/pagethree.dart';
import 'package:bitnet/pages/website/website_landingpage/pagetwo.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';

class WebsiteLandingPageView extends StatelessWidget {
  final WebsiteLandingPageController controller;

  const WebsiteLandingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final percentagechange = Provider.of<double>(context);
    final lastRegisteredUsers = Provider.of<List<UserData>>(context);

    // Create structured data for the homepage
    final Map<String, dynamic> homepageStructuredData = {
      '@context': 'https://schema.org',
      '@type': 'WebSite',
      'name': 'BitNet - Building a Bitcoin Future That Works',
      'description': 'We are growing a Bitcoin Network that is not only fair and equitable but also liberates us from a dystopian future.',
      'url': 'https://bitnet.im',
      'potentialAction': {
        '@type': 'SearchAction',
        'target': 'https://bitnet.im/search?q={search_term_string}',
        'query-input': 'required name=search_term_string'
      },
      'publisher': {
        '@type': 'Organization',
        'name': 'BitNet',
        'logo': {
          '@type': 'ImageObject',
          'url': 'https://bitnet.im/assets/images/logoclean.png'
        }
      }
    };

    // Main scaffold content
    final Widget mainContent = bitnetScaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: controller.showFab,
          builder: (context, showFab, child) {
            return AnimatedOpacity(
              opacity: showFab ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: BitNetFAB(
                onPressed: () {
                  if (controller.pageController.hasClients) {
                    var nextPage = controller.pageController.page!.toInt() + 1;
                    if (nextPage < 5) {
                      controller.pageController.animateToPage(
                        nextPage,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {}
                  }
                },
              ),
            );
          }),
      extendBodyBehindAppBar: true,
      appBar: bitnetWebsiteAppBar(
        centerWidget: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          // Check if the screen width is less than 600 pixels.
          bool isSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSmallScreen;

          List<UserData> all_userresults = lastRegisteredUsers;
          List<String> firstFourUsernames = all_userresults.isEmpty 
              ? ["user1", "user2", "user3", "user4"]  // Default usernames if empty
              : all_userresults.reversed
                  .take(4) // Take the last 4
                  .map((user) => user.username)
                  .toList();

          return isSmallScreen
              ? Container()
              : Container(
                  width: AppTheme.cardPadding * 17,
                  child: all_userresults.isEmpty
                      ? SizedBox(height: AppTheme.cardPadding * 4, child: Center(child: dotProgress(context)))
                      : AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 1000),
                          animatedTexts: [
                            RotateAnimatedText(
                              L10n.of(context)!.weHaveBetaLiftOff,
                              duration: const Duration(milliseconds: 2400),
                              textStyle: Theme.of(context).textTheme.titleSmall,
                            ),
                            RotateAnimatedText(
                              '+${percentagechange.toStringAsFixed(1)}%${L10n.of(context)!.userCharged}',
                              duration: const Duration(milliseconds: 2400),
                              textStyle: Theme.of(context).textTheme.titleSmall,
                            ),
                            RotateAnimatedText(
                              '@${firstFourUsernames[0]}${L10n.of(context)!.justJoinedBitnet}',
                              duration: const Duration(milliseconds: 2400),
                              textStyle: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                );
        }),
      ),
      context: context,
      body: PageView(
        padEnds: false,
        scrollDirection: Axis.vertical,
        controller: controller.pageController,
        children: [
          // Show actual website pages by default
          PageOne(
            controller: controller,
          ),
          PageTwo(
            controller: controller,
          ),
          const PageThree(),
          const PageFour(),
          PageFooter(
            controller: controller,
          ),
        ],
      ),
    );

    // Apply SEO wrapper only on web
    if (!kIsWeb) {
      return mainContent;
    }

    // Enhanced with SEO metadata for web
    return SeoContainer(
      title: 'BitNet - Building a Bitcoin Future That Works',
      description: 'We are growing a Bitcoin Network that is not only fair and equitable but also liberates us from a dystopian future.',
      canonicalUrl: 'https://bitnet.im',
      image: 'https://bitnet.im/assets/images/logoclean.png',
      structuredData: homepageStructuredData,
      keywords: ['BitNet', 'Bitcoin', 'Cryptocurrency', 'Wallet', 'Blockchain', 'DeFi', 'Digital Currency'],
      role: 'main',
      id: 'main-content',
      ariaLabel: 'BitNet Homepage',
      child: mainContent,
    );
  }
}
