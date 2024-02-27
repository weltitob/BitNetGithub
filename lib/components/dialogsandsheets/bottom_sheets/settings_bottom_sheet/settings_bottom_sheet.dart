//
// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// showSettingsBottomSheet({
//   required BuildContext context,
// }) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (context) {
//       return ChangeNotifierProvider(
//         create: (context) => SettingsProvider(),
//         child: StatefulBuilder(
//           builder: (BuildContext context, StateSetter setModalState) {
//             return Container(
//               // Set the desired height
//               height: MediaQuery.of(context).size.height * 0.8, // 80% of screen height
//               decoration: BoxDecoration(
//                 color: Theme.of(context).canvasColor, // Add a background color here
//                 borderRadius: new BorderRadius.only(
//                   topLeft: AppTheme.cornerRadiusBig,
//                   topRight: AppTheme.cornerRadiusBig,
//                 ),
//               ),
//               child: ClipRRect(
//                 borderRadius: new BorderRadius.only(
//                   topLeft: AppTheme.cornerRadiusBig,
//                   topRight: AppTheme.cornerRadiusBig,
//                 ),
//                 child: const Settings(),
//               ),
//             );
//           },
//         ),
//       );
//     },
//   );
// }
//
