// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:flutter/material.dart';
//
// showModalBottomSheetWidget({
//   required BuildContext context,
//   required dynamic height,
//   required String title,
//   required Widget child,
//   IconData? iconData,
//   required bool goBack,
// }) {
//   bool _hasIcon = false;
//   if(iconData != null) {
//     _hasIcon = true;
//   }
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) => Container(
//       height: height,
//       decoration: new BoxDecoration(
//         color: Theme.of(context).colorScheme.background,
//         borderRadius: new BorderRadius.only(
//           topLeft: AppTheme.cornerRadiusBig,
//           topRight: AppTheme.cornerRadiusBig,
//         ),
//       ),
//       child: Column(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(left: AppTheme.cardPadding, right: AppTheme.cardPadding, top: AppTheme.elementSpacing),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 goBack ? Icon(
//                   Icons.arrow_back_rounded,
//                   size: AppTheme.cardPadding,
//                   color: AppTheme.white70,
//                 ) : Container(width: 20,),
//                 Row(
//                   children: [
//                     _hasIcon ? Padding(
//                       padding: const EdgeInsets.only(right: AppTheme.elementSpacing * 0.5),
//                       child: Icon(
//                         iconData,
//                         size: AppTheme.cardPadding,
//                         color: AppTheme.white70,
//                       ),
//                     ) : Container(),
//                     Text(
//                       title,
//                       style: Theme.of(context).textTheme.titleSmall,
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   child: Icon(
//                     Icons.clear_rounded,
//                     size: AppTheme.cardPadding,
//                     color: AppTheme.white70,
//                   ),
//                   onTap: () => Navigator.pop(context),
//                 )
//               ],
//             ),
//           ),
//           child,
//         ],
//       ),
//     ),
//   );
// }