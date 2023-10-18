// import 'package:bitnet/components/container/imagewithtext.dart';
// import 'package:flutter/material.dart';
// import 'package:bitnet/backbone/helper/theme/theme.dart';
//
// class glassButton extends StatefulWidget {
//   final String text;
//   final IconData? iconData;
//   final Function()? onTap;
//   final bool? isSelected;
//
//   const glassButton({
//     required this.text,
//     required this.onTap,
//     this.iconData,
//     this.isSelected,
//   });
//
//   @override
//   State<glassButton> createState() => _glassButtonState();
// }
//
// class _glassButtonState extends State<glassButton> {
//   bool _isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         double screenWidth = MediaQuery.of(context).size.width;
//         bool isSmallScreen = screenWidth < AppTheme.isSmallScreen;
//         bool isMidScreen = screenWidth < AppTheme.isMidScreen;
//
//         return Material(
//           color: Colors.transparent,
//           child: InkWell(
//             hoverColor: Colors.black.withOpacity(0.1),
//             borderRadius: AppTheme.cardRadiusSmall,
//             onHover: (value) => _isHovered = true,
//             onTap: widget.onTap,
//             child: Ink(
//               child: GlassContainer(
//                 borderThickness:
//                     widget.isSelected == null || widget.isSelected! ? 1.5 : 0,
//                 blur: 50,
//                 opacity: 0.1,
//                 borderRadius: AppTheme.cardRadiusSmall,
//                 child: Container(
//                   width: isSmallScreen
//                       ? AppTheme.cardPadding * 5
//                       : AppTheme.cardPadding * 6,
//                   padding: EdgeInsets.symmetric(
//                     vertical: isSmallScreen
//                         ? AppTheme.elementSpacing * 0.5
//                         : AppTheme.elementSpacing * 0.75,
//                     horizontal: isSmallScreen
//                         ? AppTheme.elementSpacing * 0.5
//                         : AppTheme.elementSpacing * 0.75,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       widget.iconData == null
//                           ? Container()
//                           : Icon(
//                               widget.iconData,
//                               color: (widget.isSelected == null ||
//                                       widget.isSelected!)
//                                   ? AppTheme.white90
//                                   : AppTheme.white80,
//                               size: isSmallScreen
//                                   ? AppTheme.elementSpacing * 1.25
//                                   : AppTheme.elementSpacing * 1.5,
//                             ),
//                       widget.iconData == null
//                           ? Container()
//                           : SizedBox(
//                               width: isSmallScreen
//                                   ? AppTheme.elementSpacing / 2
//                                   : AppTheme.elementSpacing / 1.5,
//                             ),
//                       Text(
//                         widget.text,
//                         style: isSmallScreen
//                             ? AppTheme.textTheme.titleSmall!.copyWith(
//                                 fontSize: 14,
//                                 color: (widget.isSelected == null ||
//                                         widget.isSelected!)
//                                     ? AppTheme.white90
//                                     : AppTheme.white80,
//                               )
//                             : AppTheme.textTheme.titleSmall!.copyWith(
//                                 color: (widget.isSelected == null ||
//                                         widget.isSelected!)
//                                     ? AppTheme.white90
//                                     : AppTheme.white80,
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ColorfulGradientButton extends StatefulWidget {
//   final String text;
//   final IconData? iconData;
//   final Function()? onTap;
//   final bool? isSelected;
//   final Gradient gradient;
//
//   const ColorfulGradientButton({
//     required this.text,
//     required this.onTap,
//     this.iconData,
//     this.isSelected,
//     this.gradient = const LinearGradient(
//       colors: [
//         AppTheme.colorBitcoin,
//         AppTheme.colorPrimaryGradient
//       ],
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     ),
//   });
//
//   @override
//   State<ColorfulGradientButton> createState() => _ColorfulGradientButtonState();
// }
//
// class _ColorfulGradientButtonState extends State<ColorfulGradientButton> {
//   bool _isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         hoverColor: Colors.black.withOpacity(0.1),
//         onHover: (value) => setState(() => _isHovered = value),
//         onTap: widget.onTap,
//         borderRadius: AppTheme.cardRadiusSmall,
//         child: Ink(
//           decoration: BoxDecoration(
//             gradient: widget.gradient,
//             borderRadius: AppTheme.cardRadiusSmall,
//             boxShadow: [AppTheme.boxShadowProfile],
//           ),
//           width: AppTheme.cardPadding * 6,
//           padding: const EdgeInsets.symmetric(
//             vertical: AppTheme.elementSpacing * 0.75,
//             horizontal: AppTheme.elementSpacing * 0.75,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               widget.iconData == null
//                   ? Container()
//                   : Icon(
//                 widget.iconData,
//                 color: AppTheme.white90,
//                 size: AppTheme.elementSpacing * 1.5,
//               ),
//               widget.iconData == null
//                   ? Container()
//                   : const SizedBox(
//                 width: AppTheme.elementSpacing / 1.5,
//               ),
//               Text(
//                 widget.text,
//                 style: AppTheme.textTheme.titleSmall!.copyWith(
//                   color: Colors.white,
//                   shadows: [
//                     AppTheme.boxShadowButton,
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }