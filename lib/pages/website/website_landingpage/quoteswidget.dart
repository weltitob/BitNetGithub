// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:bitnet/components/appstandards/BitNetShaderMask.dart';
// import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
// import 'package:bitnet/components/container/fadein.dart';
// import 'package:bitnet/components/container/imagewithtext.dart';
// import 'package:bitnet/components/container/randomcontainers/randomavatarcontainer.dart';
// import 'package:bitnet/components/indicators/smoothpageindicator.dart';
// import 'package:bitnet/components/items/usersearchresult.dart';
// import 'package:bitnet/models/user/userdata.dart';
// import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/l10n.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Quotes extends StatefulWidget {
//   final WebsiteLandingPageController controller;

//   const Quotes({super.key, required this.controller});

//   @override
//   State<Quotes> createState() => _QuotesState();
// }

// class _QuotesState extends State<Quotes> {
//   PageController _pageController = PageController();
//   GlobalKey<FadeInState> fadeInKey = GlobalKey<FadeInState>();
//   int _selectedindex = 0;
//   bool _isThirdAnimationCompleted = false;

//   @override
//   void dispose() {
//     _pageController.dispose(); // Don't forget to dispose the PageController
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//       bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
//       bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
//       bool isSuperSmallScreen =
//           constraints.maxWidth < AppTheme.isSuperSmallScreen;
//       bool isIntermediateScreen =
//           constraints.maxWidth < AppTheme.isIntermediateScreen;

//       double spacingMultiplier = isMidScreen
//           ? isSmallScreen
//               ? isSuperSmallScreen
//                   ? 0.25
//                   : 0.5
//               : 0.75
//           : 1;

//       return Stack(
//         children: [
//           _isThirdAnimationCompleted
//               ? Container()
//               : FadeIn(
//                   delay: const Duration(milliseconds: 1200),
//                   duration: const Duration(seconds: 2),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       margin: EdgeInsets.only(
//                         top: isIntermediateScreen
//                             ? isSmallScreen
//                                 ? AppTheme.cardPadding * 16 + 160
//                                 : AppTheme.cardPadding * 5 +
//                                     spacingMultiplier +
//                                     180
//                             : AppTheme.cardPadding * 5 +
//                                 spacingMultiplier +
//                                 180,
//                         left: isIntermediateScreen
//                             ? isSmallScreen
//                                 ? 425 - AppTheme.cardPadding * 6
//                                 : 700 - AppTheme.cardPadding
//                             : 850 - AppTheme.cardPadding,
//                       ),
//                       child: const QuoteTextWidget(),
//                     ),
//                   ),
//                 ),
//           _isThirdAnimationCompleted && !isSmallScreen
//               ? Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     width: isIntermediateScreen
//                         ? isSmallScreen
//                             ? 300 + AppTheme.cardPadding * 5
//                             : 700 + AppTheme.cardPadding * 7.5
//                         : 850 + AppTheme.cardPadding * 10,
//                     height: isIntermediateScreen
//                         ? isSmallScreen
//                             ? 500
//                             : 400
//                         : 400,
//                     child: RandomAvatarWidget(
//                       start: true,
//                       width: isIntermediateScreen
//                           ? isSmallScreen
//                               ? 300 + AppTheme.cardPadding * 5
//                               : 700 + AppTheme.cardPadding * 7.5
//                           : 850 + AppTheme.cardPadding * 10,
//                       height: isIntermediateScreen
//                           ? isSmallScreen
//                               ? 500
//                               : 400
//                           : 400,
//                     ),
//                   ),
//                 )
//               : Container(),
//           FadeIn(
//             child: Align(
//               alignment: Alignment.center,
//               child: Container(
//                 child: MouseRegion(
//                   cursor: SystemMouseCursors.click,
//                   child: GestureDetector(
//                     onTap: () {
//                       context.go("/register");
//                     },
//                     child: GlassContainer(
//                       borderThickness: 1.5, // remove border if not active
//                       blur: 50,
//                       opacity: 0.1,
//                       borderRadius: BorderRadius.circular(240 / 3.5),
//                       child: Container(
//                         width: isIntermediateScreen
//                             ? isSmallScreen
//                                 ? 300
//                                 : 700
//                             : 850,
//                         height: isIntermediateScreen
//                             ? isSmallScreen
//                                 ? 500
//                                 : 240
//                             : 240,
//                         child: Stack(
//                           children: [
//                             Container(
//                               width: isIntermediateScreen
//                                   ? isSmallScreen
//                                       ? 300
//                                       : 700
//                                   : 850,
//                               height: isIntermediateScreen
//                                   ? isSmallScreen
//                                       ? 500
//                                       : 240
//                                   : 240,
//                               padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     AppTheme.cardPadding * spacingMultiplier,
//                                 vertical: AppTheme.cardPadding * 2.25,
//                               ),
//                               child: _isThirdAnimationCompleted
//                                   ? Container(
//                                       alignment: Alignment.center,
//                                       child: BitNetShaderMask(
//                                         child: AnimatedTextKit(
//                                           isRepeatingAnimation: false,
//                                           animatedTexts: [
//                                             TypewriterAnimatedText(
//                                               L10n.of(context)!
//                                                   .weEmpowerTomorrow,
//                                               textAlign: TextAlign.center,
//                                               textStyle: Theme.of(context)
//                                                   .textTheme
//                                                   .displayLarge!
//                                                   .copyWith(
//                                                     color: Colors
//                                                         .white, // This color will be replaced by the gradient effect
//                                                   ),
//                                               speed: const Duration(
//                                                   milliseconds: 50),
//                                             ),
//                                             TypewriterAnimatedText(
//                                               L10n.of(context)!.joinUsToday,
//                                               textAlign: TextAlign.center,
//                                               textStyle: Theme.of(context)
//                                                   .textTheme
//                                                   .displayLarge!
//                                                   .copyWith(
//                                                     color: Colors
//                                                         .white, // This color will be replaced by the gradient effect
//                                                   ),
//                                               speed: const Duration(
//                                                   milliseconds: 50),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   : HorizontalFadeListView(
//                                       child: PageView.builder(
//                                         controller: _pageController,
//                                         onPageChanged: (index) {
//                                           setState(() {
//                                             _selectedindex = index;
//                                           });
//                                           // Restart the FadeIn animation
//                                           fadeInKey.currentState
//                                               ?.restartAnimation();
//                                         },
//                                         itemCount: widget
//                                             .controller.pageDataList.length,
//                                         itemBuilder: (context, index) {
//                                           return Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     AppTheme.cardPadding *
//                                                         1.25),
//                                             child: Column(
//                                               children: [
//                                                 TypewriterTextWidget(
//                                                     text: widget
//                                                         .controller
//                                                         .pageDataList[index]
//                                                         .text,
//                                                     selectedIndex:
//                                                         _selectedindex,
//                                                     isThirdAnimationCompleted:
//                                                         () {
//                                                       _isThirdAnimationCompleted =
//                                                           true;
//                                                       setState(() {});
//                                                     },
//                                                     onCompleted: () {
//                                                       if (index <
//                                                           widget
//                                                                   .controller
//                                                                   .pageDataList
//                                                                   .length -
//                                                               1) {
//                                                         Future.delayed(
//                                                             const Duration(
//                                                                 milliseconds:
//                                                                     2000), () {
//                                                           _pageController
//                                                               .nextPage(
//                                                             duration:
//                                                                 const Duration(
//                                                                     milliseconds:
//                                                                         400),
//                                                             curve: Curves
//                                                                 .easeInOut,
//                                                           );
//                                                         });
//                                                       }
//                                                     }),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                             ),
//                             _isThirdAnimationCompleted
//                                 ? Container()
//                                 : Align(
//                                     alignment: Alignment.bottomCenter,
//                                     child: Container(
//                                         margin: const EdgeInsets.only(
//                                             bottom: AppTheme.cardPadding * 1),
//                                         child: CustomIndicator(
//                                           dotHeight: AppTheme.elementSpacing,
//                                           dotWidth: AppTheme.elementSpacing,
//                                           pageController: _pageController,
//                                           count: 3,
//                                           onClickIndicator: (i) {
//                                             _pageController.animateToPage(i,
//                                                 duration: const Duration(
//                                                     milliseconds: 400),
//                                                 curve: Curves.easeInOut);
//                                           },
//                                         )),
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           _isThirdAnimationCompleted
//               ? Container()
//               : FadeIn(
//                   delay: const Duration(milliseconds: 1200),
//                   duration: const Duration(seconds: 2),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       margin: EdgeInsets.only(
//                         bottom: isIntermediateScreen
//                             ? isSmallScreen
//                                 ? AppTheme.cardPadding * 16
//                                 : AppTheme.cardPadding * 5
//                             : AppTheme.cardPadding * 5,
//                         right: isIntermediateScreen
//                             ? isSmallScreen
//                                 ? 425 - AppTheme.cardPadding * 3.5
//                                 : 700
//                             : 850,
//                       ),
//                       child: const QuoteTextWidget(),
//                     ),
//                   ),
//                 ),
//           _isThirdAnimationCompleted && !isSmallScreen
//               ? Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     width: isIntermediateScreen
//                         ? isSmallScreen
//                             ? 300 + AppTheme.cardPadding * 5
//                             : 700 + AppTheme.cardPadding * 7.5
//                         : 850 + AppTheme.cardPadding * 10,
//                     height: isIntermediateScreen
//                         ? isSmallScreen
//                             ? 500
//                             : 400
//                         : 400,
//                     child: RandomAvatarWidget(
//                       start: true,
//                       width: isIntermediateScreen
//                           ? isSmallScreen
//                               ? 300 + AppTheme.cardPadding * 5
//                               : 700 + AppTheme.cardPadding * 7.5
//                           : 850 + AppTheme.cardPadding * 10,
//                       height: isIntermediateScreen
//                           ? isSmallScreen
//                               ? 500
//                               : 400
//                           : 400,
//                     ),
//                   ),
//                 )
//               : Container(),
//           _isThirdAnimationCompleted
//               ? Container()
//               : FadeIn(
//                   key: fadeInKey,
//                   delay: const Duration(milliseconds: 400),
//                   duration: const Duration(seconds: 2),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       margin: EdgeInsets.only(
//                         bottom: isSmallScreen
//                             ? 240 + AppTheme.cardPadding * 10.5
//                             : AppTheme.cardPadding * 10.5,
//                       ),
//                       child: UserSearchResultWidget(
//                           userData: widget.controller
//                               .pageDataList[_selectedindex].userData),
//                     ),
//                   ),
//                 ),
//         ],
//       );
//     });
//   }
// }

// class QuoteTextWidget extends StatelessWidget {
//   const QuoteTextWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       '"',
//       style: Theme.of(context).textTheme.displayLarge!.copyWith(
//             fontSize: 170,
//             fontFamily: GoogleFonts.lobster().fontFamily,
//             color: AppTheme
//                 .colorBitcoin, // This color will be replaced by the gradient effect
//           ),
//     );
//   }
// }

// class TypewriterTextWidget extends StatelessWidget {
//   final String text;
//   final VoidCallback onCompleted;
//   final int selectedIndex;
//   final VoidCallback isThirdAnimationCompleted;

//   const TypewriterTextWidget({
//     Key? key,
//     required this.text,
//     required this.onCompleted,
//     required this.selectedIndex,
//     required this.isThirdAnimationCompleted,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: AnimatedTextKit(
//         totalRepeatCount: 1,
//         animatedTexts: [
//           TypewriterAnimatedText(
//             text,
//             textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
//                   color: AppTheme.white90,
//                 ),
//             speed: const Duration(milliseconds: 50),
//             textAlign: TextAlign.center,
//           ),
//         ],
//         onFinished: () {
//           if (selectedIndex == 2) {
//             onCompleted();
//             isThirdAnimationCompleted();
//           } else {
//             onCompleted();
//           }
//         },
//       ),
//     );
//   }
// }

// class UserSearchResultWidget extends StatelessWidget {
//   final UserData userData;

//   const UserSearchResultWidget({Key? key, required this.userData})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return UserSearchResult(
//       scaleRatio: 1.15,
//       onTap: () {
//         print("User selected: ${userData.displayName}");
//         return null;
//       },
//       userData: UserData(
//           backgroundImageUrl: userData.backgroundImageUrl,
//           isPrivate: userData.isPrivate,
//           showFollowers: userData.showFollowers,
//           did: userData.did,
//           displayName: userData.displayName,
//           bio: userData.bio,
//           customToken: userData.customToken,
//           username: userData.username,
//           profileImageUrl: userData.profileImageUrl,
//           createdAt: userData.createdAt,
//           updatedAt: userData.updatedAt,
//           isActive: userData.isActive,
//           dob: userData.dob,
//           setupQrCodeRecovery: userData.setupQrCodeRecovery,
//           setupWordRecovery: userData.setupWordRecovery),
//     );
//   }
// }
