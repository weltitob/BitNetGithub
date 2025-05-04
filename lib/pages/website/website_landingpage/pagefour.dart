// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
// import 'package:bitnet/components/appstandards/mydivider.dart';
// import 'package:bitnet/components/buttons/longbutton.dart';
// import 'package:bitnet/pages/website/emailfetcher.dart';
// import 'package:bitnet/pages/website/seo/seo_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/l10n.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lottie/lottie.dart';
// import 'package:seo/seo.dart';

// class PageFour extends StatefulWidget {
//   const PageFour({super.key});

//   @override
//   State<PageFour> createState() => _PageFourState();
// }

// class _PageFourState extends State<PageFour> {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
//         bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
//         bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;
//         bool isIntermediateScreen = constraints.maxWidth < AppTheme.isIntermediateScreen;

//         double textWidth = isMidScreen
//             ? isSmallScreen
//                 ? isSuperSmallScreen
//                     ? AppTheme.cardPadding * 13
//                     : AppTheme.cardPadding * 16
//                 : AppTheme.cardPadding * 22
//             : AppTheme.cardPadding * 24;
//         double subtitleWidth = isMidScreen
//             ? isSmallScreen
//                 ? isSuperSmallScreen
//                     ? AppTheme.cardPadding * 13
//                     : AppTheme.cardPadding * 16
//                 : AppTheme.cardPadding * 18
//             : AppTheme.cardPadding * 22;
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
//           withGradientTopSmall: true,
//           withGradientBottomSmall: true,
//           withGradientRightBig: true,
//           child: Container(
//             margin: isSmallScreen ? const EdgeInsets.symmetric(horizontal: 0) : EdgeInsets.symmetric(horizontal: centerSpacing),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     isSmallScreen ? Container() : mobileWithPicture(),
//                     Stack(
//                       children: [
//                         isSmallScreen
//                             ? Align(
//                                 child: Container(
//                                   width: MediaQuery.of(context).size.width * 1,
//                                   alignment: Alignment.center,
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: MediaQuery.of(context).size.height * 0.9,
//                                     width: MediaQuery.of(context).size.width * 0.3 + 280,
//                                     child: Stack(
//                                       children: [
//                                         Align(
//                                           alignment: Alignment.center,
//                                           child: Container(
//                                             child: Image.asset(
//                                               'assets/images/phone.png',
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : Container(),
//                         Container(
//                           height: isSmallScreen ? MediaQuery.of(context).size.height * 0.9 : 500,
//                           width: isSmallScreen ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 2.6,
//                           alignment: Alignment.center,
//                           child: Column(
//                             crossAxisAlignment: isSmallScreen ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 margin: isSmallScreen
//                                     ? const EdgeInsets.only(top: AppTheme.cardPadding * 4)
//                                     : const EdgeInsets.symmetric(horizontal: 0),
//                                 width: isSmallScreen ? 180 + MediaQuery.of(context).size.width / 3.5 : textWidth,
//                                 child: SeoText(
//                                   tagStyle: TextTagStyle.h2,
//                                   L10n.of(context)!.beAPart,
//                                   style: Theme.of(context).textTheme.displayMedium,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: AppTheme.cardPadding * 1 * spacingMultiplier,
//                               ),
//                               Container(
//                                 width: isSmallScreen ? 180 + MediaQuery.of(context).size.width / 3.5 : subtitleWidth,
//                                 child: SeoText(
//                                   L10n.of(context)!.moreAndMore,
//                                   style: Theme.of(context).textTheme.bodyLarge,
//                                 ),
//                               ),
//                               SizedBox(height: AppTheme.cardPadding * 2.5 * spacingMultiplier),
//                               AllButtons(isSmallScreen: isSmallScreen, isIntermediateScreen: isIntermediateScreen),
//                             ],
//                           ),
//                         ),
//                         isSmallScreen
//                             ? Positioned(
//                                 bottom: MediaQuery.of(context).size.height / 12,
//                                 left: MediaQuery.of(context).size.width * 0.65 - 80,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.width / 2.5,
//                                   width: MediaQuery.of(context).size.width / 2.5,
//                                   child: Lottie.asset(
//                                     'assets/lottiefiles/chartgoup.json',
//                                     fit: BoxFit.cover,
//                                     repeat: false,
//                                   ),
//                                 ),
//                               )
//                             : Container(),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget downloadAPKButton() {
//     return Column(
//       children: [
//         Container(
//           height: AppTheme.cardPadding,
//           width: AppTheme.cardPadding * 20,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(child: MyDivider()),
//               const SizedBox(
//                 width: AppTheme.elementSpacing,
//               ),
//               Text(
//                 L10n.of(context)!.or.toUpperCase(),
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               const SizedBox(
//                 width: AppTheme.elementSpacing,
//               ),
//               Expanded(child: MyDivider()),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: AppTheme.cardPadding,
//         ),
//         Container(
//           width: AppTheme.cardPadding * 10,
//           child: LongButtonWidget(
//               leadingIcon: const Icon(FontAwesomeIcons.download),
//               title: "${L10n.of(context)!.download} .apk",
//               buttonType: ButtonType.solid,
//               onTap: () async {
//                 // Original redirect commented out
//                 // context.go('/authhome/pinverification');
                
//                 // Show early bird dialog instead
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     bool isSuperSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSuperSmallScreen;
//                     return Dialog(
//                       backgroundColor: Colors.transparent,
//                       insetPadding: EdgeInsets.symmetric(
//                         horizontal: isSuperSmallScreen ? 20 : 40,
//                         vertical: isSuperSmallScreen ? 24 : 40,
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                           borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                           child: const EmailFetcherLandingPage(),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//         ),
//       ],
//     );
//   }

//   Widget mobileWithPicture() {
//     return Container(
//       height: AppTheme.cardPadding * 20,
//       width: AppTheme.cardPadding * 14,
//       child: Stack(
//         children: [
//           Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: AppTheme.cardPadding * 18.5,
//                 width: AppTheme.cardPadding * 14,
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         padding: const EdgeInsets.only(bottom: AppTheme.elementSpacing),
//                         height: AppTheme.cardPadding * 17.6,
//                         width: AppTheme.cardPadding * 14,
//                         alignment: Alignment.bottomCenter,
//                         child: Image.asset(
//                           'assets/images/screenshot_small.png',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.only(bottom: AppTheme.elementSpacing),
//                       alignment: Alignment.bottomCenter,
//                       child: Image.asset(
//                         'assets/images/phone.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//           Align(
//               alignment: Alignment.bottomRight,
//               child: Container(
//                 margin: const EdgeInsets.only(right: 0, bottom: AppTheme.elementSpacing * 0),
//                 height: AppTheme.cardPadding * 8,
//                 width: AppTheme.cardPadding * 8,
//                 child: Lottie.asset(
//                   'assets/lottiefiles/chartgoup.json', //phone_bubbles
//                   fit: BoxFit.cover,
//                 ),
//               )),
//           //bottomGradientPhone(),
//         ],
//       ),
//     );
//   }

//   Widget bottomGradientPhone() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             height: AppTheme.cardPadding * 2,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.transparent,
//                 Theme.of(context).colorScheme.surface,
//               ],
//             )),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> downloadFromStores(isIntermediateScreen) {
//     return [
//       isIntermediateScreen
//           ? const Icon(
//               FontAwesomeIcons.googlePlay,
//               size: AppTheme.cardPadding * 1.4,
//             )
//           : Container(
//               width: AppTheme.cardPadding * 10,
//               child: LongButtonWidget(
//                   leadingIcon: Icon(
//                     color: AppTheme.white90,
//                     FontAwesomeIcons.googlePlay,
//                   ),
//                   title: "Google Play",
//                   buttonType: ButtonType.transparent,
//                   onTap: () async {
//                     // Original redirect commented out
//                     // context.go('/authhome/pinverification');
                    
//                     // Show early bird dialog instead
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         bool isSuperSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSuperSmallScreen;
//                         return Dialog(
//                           backgroundColor: Colors.transparent,
//                           insetPadding: EdgeInsets.symmetric(
//                             horizontal: isSuperSmallScreen ? 20 : 40,
//                             vertical: isSuperSmallScreen ? 24 : 40,
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                               child: const EmailFetcherLandingPage(),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//             ),
//       const SizedBox(
//         width: AppTheme.elementSpacing,
//         height: AppTheme.elementSpacing,
//       ),
//       isIntermediateScreen
//           ? Icon(
//               FontAwesomeIcons.apple,
//               size: AppTheme.cardPadding * 1.6,
//               color: AppTheme.white90,
//             )
//           : Container(
//               width: AppTheme.cardPadding * 10,
//               child: LongButtonWidget(
//                   leadingIcon: const Icon(FontAwesomeIcons.apple),
//                   title: "Apple Store",
//                   buttonType: ButtonType.transparent,
//                   onTap: () async {
//                     // Original redirect commented out
//                     // context.go('/authhome/pinverification');
                    
//                     // Show early bird dialog instead
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         bool isSuperSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSuperSmallScreen;
//                         return Dialog(
//                           backgroundColor: Colors.transparent,
//                           insetPadding: EdgeInsets.symmetric(
//                             horizontal: isSuperSmallScreen ? 20 : 40,
//                             vertical: isSuperSmallScreen ? 24 : 40,
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                               child: const EmailFetcherLandingPage(),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//             ),
//       isIntermediateScreen
//           ? const SizedBox(
//               width: AppTheme.elementSpacing,
//               height: AppTheme.elementSpacing,
//             )
//           : Container(),
//       isIntermediateScreen
//           ? Icon(
//               color: AppTheme.white90,
//               FontAwesomeIcons.download,
//               size: AppTheme.cardPadding * 1.35,
//             )
//           : Container(),
//     ];
//   }
// }

// class AllButtons extends StatelessWidget {
//   final bool isSmallScreen;
//   final bool isIntermediateScreen;

//   const AllButtons({
//     Key? key,
//     required this.isSmallScreen,
//     required this.isIntermediateScreen,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: isSmallScreen ? 180 + MediaQuery.of(context).size.width / 3.5 : 500,
//           child: Row(
//             mainAxisAlignment: isIntermediateScreen ? MainAxisAlignment.start : MainAxisAlignment.center,
//             children: [
//               DownloadFromStores(
//                 isIntermediateScreen: isIntermediateScreen,
//                 isSmallScreen: isSmallScreen,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: AppTheme.cardPadding),
//         isIntermediateScreen ? Container() : const DownloadAPKButton(),
//       ],
//     );
//   }
// }

// class DownloadAPKButton extends StatelessWidget {
//   const DownloadAPKButton({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: AppTheme.cardPadding,
//           width: AppTheme.cardPadding * 20,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(child: MyDivider()),
//               const SizedBox(width: AppTheme.elementSpacing),
//               Text(
//                 L10n.of(context)!.or.toUpperCase(),
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               const SizedBox(width: AppTheme.elementSpacing),
//               Expanded(child: MyDivider()),
//             ],
//           ),
//         ),
//         const SizedBox(height: AppTheme.cardPadding),
//         Container(
//           width: AppTheme.cardPadding * 10,
//           child: LongButtonWidget(
//             leadingIcon: const Icon(FontAwesomeIcons.download),
//             title: "${L10n.of(context)!.download} .apk",
//             buttonType: ButtonType.solid,
//             onTap: () async {
//               // Original redirect commented out
//               // context.go('/authhome/pinverification');
              
//               // Show early bird dialog instead
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   bool isSuperSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSuperSmallScreen;
//                   return Dialog(
//                     backgroundColor: Colors.transparent,
//                     insetPadding: EdgeInsets.symmetric(
//                       horizontal: isSuperSmallScreen ? 20 : 40,
//                       vertical: isSuperSmallScreen ? 24 : 40,
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).scaffoldBackgroundColor,
//                         borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                         child: const EmailFetcherLandingPage(),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MobileWithPicture extends StatelessWidget {
//   const MobileWithPicture({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: AppTheme.cardPadding * 20,
//       width: AppTheme.cardPadding * 14,
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: AppTheme.cardPadding * 18.5,
//               width: AppTheme.cardPadding * 14,
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       padding: const EdgeInsets.only(bottom: AppTheme.elementSpacing),
//                       height: AppTheme.cardPadding * 17.6,
//                       width: AppTheme.cardPadding * 14,
//                       alignment: Alignment.bottomCenter,
//                       child: Image.asset(
//                         'assets/images/screenshot_small.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(bottom: AppTheme.elementSpacing),
//                     alignment: Alignment.bottomCenter,
//                     child: Image.asset(
//                       'assets/images/phone.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Container(
//               margin: const EdgeInsets.only(right: 0, bottom: AppTheme.elementSpacing * 0),
//               height: AppTheme.cardPadding * 8,
//               width: AppTheme.cardPadding * 8,
//               child: Lottie.asset(
//                 'assets/lottiefiles/chartgoup.json',
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const BottomGradientPhone(),
//         ],
//       ),
//     );
//   }
// }

// class BottomGradientPhone extends StatelessWidget {
//   const BottomGradientPhone({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             height: AppTheme.cardPadding * 2,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.transparent,
//                   Theme.of(context).colorScheme.surface,
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DownloadFromStores extends StatelessWidget {
//   final bool isIntermediateScreen;
//   final bool isSmallScreen;

//   const DownloadFromStores({
//     Key? key,
//     required this.isIntermediateScreen,
//     required this.isSmallScreen,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: isIntermediateScreen
//           ? isSmallScreen
//               ? MainAxisAlignment.start
//               : MainAxisAlignment.start
//           : MainAxisAlignment.center,
//       children: [
//         isIntermediateScreen
//             ? const Icon(
//                 FontAwesomeIcons.googlePlay,
//                 size: AppTheme.cardPadding * 1.4,
//               )
//             : Container(
//                 width: AppTheme.cardPadding * 10,
//                 child: LongButtonWidget(
//                   leadingIcon: Icon(
//                     color: AppTheme.white90,
//                     FontAwesomeIcons.googlePlay,
//                   ),
//                   title: "Google Play",
//                   buttonType: ButtonType.transparent,
//                   onTap: () async {
//                     // Original redirect commented out
//                     // context.go('/authhome/pinverification');
                    
//                     // Show early bird dialog instead
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         bool isSuperSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSuperSmallScreen;
//                         return Dialog(
//                           backgroundColor: Colors.transparent,
//                           insetPadding: EdgeInsets.symmetric(
//                             horizontal: isSuperSmallScreen ? 20 : 40,
//                             vertical: isSuperSmallScreen ? 24 : 40,
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                               child: const EmailFetcherLandingPage(),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//         const SizedBox(width: AppTheme.elementSpacing, height: AppTheme.elementSpacing),
//         isIntermediateScreen
//             ? Icon(
//                 FontAwesomeIcons.apple,
//                 size: AppTheme.cardPadding * 1.6,
//                 color: AppTheme.white90,
//               )
//             : Container(
//                 width: AppTheme.cardPadding * 10,
//                 child: LongButtonWidget(
//                   leadingIcon: const Icon(FontAwesomeIcons.apple),
//                   title: "Apple Store",
//                   buttonType: ButtonType.transparent,
//                   onTap: () async {
//                     // Original redirect commented out
//                     // context.go('/authhome/pinverification');
                    
//                     // Show early bird dialog instead
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         bool isSuperSmallScreen = MediaQuery.of(context).size.width < AppTheme.isSuperSmallScreen;
//                         return Dialog(
//                           backgroundColor: Colors.transparent,
//                           insetPadding: EdgeInsets.symmetric(
//                             horizontal: isSuperSmallScreen ? 20 : 40,
//                             vertical: isSuperSmallScreen ? 24 : 40,
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).scaffoldBackgroundColor,
//                               borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
//                               child: const EmailFetcherLandingPage(),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//         isIntermediateScreen ? const SizedBox(width: AppTheme.elementSpacing, height: AppTheme.elementSpacing) : Container(),
//         isIntermediateScreen
//             ? Icon(
//                 color: AppTheme.white90,
//                 FontAwesomeIcons.download,
//                 size: AppTheme.cardPadding * 1.35,
//               )
//             : Container(),
//       ],
//     );
//   }
// }