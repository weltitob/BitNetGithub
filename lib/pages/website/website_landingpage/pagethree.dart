// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
// import 'package:bitnet/components/indicators/smoothpageindicator.dart';
// import 'package:bitnet/components/container/custom_card_landigpage.dart';
// import 'package:bitnet/models/website/carddata.dart';
// import 'package:bitnet/pages/website/seo/seo_text.dart';
// import 'package:flutter/material.dart';
// import 'package:seo/seo.dart';
// import 'package:flutter_gen/gen_l10n/l10n.dart';

// class PageThree extends StatefulWidget {
//   const PageThree({super.key});

//   @override
//   State<PageThree> createState() => _PageThreeState();
// }

// class _PageThreeState extends State<PageThree> {
//   PageController pageController = PageController(viewportFraction: 0.8);
//   int _selectedindex = 0;

//   @override
//   Widget build(BuildContext context) {

// List<CardData> cardDataList = [
//   CardData(
//     lottieAssetPath: 'assets/lottiefiles/wallet_animation.json',
//     mainTitle: L10n.of(context)!.makeBitcoinEasy,
//     subTitle:
//         L10n.of(context)!.weOfferEasiest,
//     buttonText: L10n.of(context)!.sendBtc,
//     onButtonTap: () {},
//   ),
//   CardData(
//     lottieAssetPath: 'assets/lottiefiles/plant.json',
//     mainTitle: L10n.of(context)!.growAFair,
//     subTitle: L10n.of(context)!.weDigitizeAllSorts,
//     buttonText: L10n.of(context)!.getAProfile,
//     onButtonTap: () {},
//   ),
//   CardData(
//     lottieAssetPath: 'assets/lottiefiles/asset_animation.json',
//     mainTitle: L10n.of(context)!.givePowerBack,
//     subTitle:
//       L10n.of(context)!.weBuildTransparent,
//     buttonText: L10n.of(context)!.exploreBtc,
//     onButtonTap: () {},
//   ),
// ];
//     return LayoutBuilder(
//       builder: (context, constraints) { 
//         bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
//         bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
//         bool isSuperSmallScreen =
//             constraints.maxWidth < AppTheme.isSuperSmallScreen;
//         bool isIntermediateScreen =
//             constraints.maxWidth < AppTheme.isIntermediateScreen;

//         bool isSmallIntermediateScreen =
//             constraints.maxWidth < AppTheme.isSmallIntermediateScreen;
 
//         double spacingMultiplier = isMidScreen
//             ? isSmallScreen
//                 ? isSuperSmallScreen
//                     ? 0.25
//                     : 0.5
//                 : 0.75
//             : 1;
//         double centerSpacing = isMidScreen
//             ? isIntermediateScreen
//                 ? isSmallScreen
//                     ? isSuperSmallScreen
//                         ? AppTheme.columnWidth * 0.075
//                         : AppTheme.columnWidth * 0.15
//                     : AppTheme.columnWidth * 0.35
//                 : AppTheme.columnWidth * 0.65
//             : AppTheme.columnWidth;

//         return BackgroundWithContent(
//           opacity: 0.7,
//           backgroundType: BackgroundType.asset,
//           withGradientBottomMedium: true,
//           withGradientTopMedium: true,
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                       height: AppTheme.cardPadding * 2 * spacingMultiplier),
//                   SeoText(
//                     tagStyle: TextTagStyle.h1,
//                     L10n.of(context)!.ourMissionn,
//                     style: Theme.of(context).textTheme.displayMedium,
//                   ),
//                   SizedBox(
//                     height: AppTheme.cardPadding +
//                         AppTheme.cardPadding * 2 * spacingMultiplier,
//                   ),
//                   Container(
//                     child: isSmallScreen
//                         ? Container(
//                             height: AppTheme.cardPadding * 20,
//                             child: PageView.builder(
//                               controller: pageController,
//                               onPageChanged: (index) {
//                                 setState(() {
//                                   _selectedindex = index;
//                                 });
//                               },
//                               itemCount: _buildCards()
//                                   .length, // Set the itemCount to the length of the _buildCards list
//                               itemBuilder: (context, index) {
//                                 return _buildCardsSmallScreen()[index];
//                               },
//                             ),
//                           )
//                         : Container(
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: isSmallIntermediateScreen
//                                     ? MediaQuery.of(context).size.width * 0.045
//                                     : centerSpacing * spacingMultiplier),
//                             color: Colors.transparent,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children:
//                                   _buildCards(), // Use the complete list of CustomCard widgets
//                             ),
//                           ),
//                   ),
//                   SizedBox(
//                     height: AppTheme.cardPadding * 2 * spacingMultiplier,
//                   ),
//                   isSmallScreen
//                       ? CustomIndicator(
//                           pageController: pageController,
//                           count: 3,
//                         )
//                       : Container(),
//                 ],
//               ),   ],
//           ),
//         );
//       },
//     );
//   }

//   List<Widget> _buildCardsSmallScreen() {
//     return cardDataList.map((cardData) {
//       return Container(
//         child: Center(
//           child: SizedBox(
//             child: CustomCard(
//               isBiggerOnHover: false,
//               lottieAssetPath: cardData.lottieAssetPath,
//               mainTitle: cardData.mainTitle,
//               subTitle: cardData.subTitle,
//               buttonText: cardData.buttonText,
//               onButtonTap: cardData.onButtonTap,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }

//   List<Widget> _buildCards() {
//     return cardDataList.map((cardData) {
//       return CustomCard(
//         isBiggerOnHover: true,
//         lottieAssetPath: cardData.lottieAssetPath,
//         mainTitle: cardData.mainTitle,
//         subTitle: cardData.subTitle,
//         buttonText: cardData.buttonText,
//         onButtonTap: cardData.onButtonTap,
//       );
//     }).toList();
//   }

// }


