// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:flutter/material.dart';
//
// Widget buildFeesChooser(BuildContext context) {
//   // create a container with top and bottom padding
//   return Column(
//     children: [
//       Container(
//         padding: const EdgeInsets.only(top: 15.0, bottom: 10),
//         // create a row with evenly distributed children buttons
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             // create a button for "Niedrig" fees
//             glassButtonFees(
//               context,
//               "Niedrig",
//             ),
//             // create a button for "Mittel" fees
//             glassButtonFees(
//               context,
//               "Mittel",
//             ),
//             // create a button for "Hoch" fees
//             glassButtonFees(
//               context,
//               "Hoch",
//             ),
//           ],
//         ),
//       ),
//       SizedBox(
//         height: AppTheme.elementSpacing,
//       ),
//       controller.isLoadingFees // if exchange rate is still loading
//           ? dotProgress(context) // show a loading indicator
//           : Text(
//         "≈ ${controller.feesInEur.toStringAsFixed(2)}€", // show the converted value of Bitcoin to Euro with 2 decimal places
//         style: Theme.of(context)
//             .textTheme
//             .bodyLarge, // use the bodyLarge text theme style from the current theme
//       )
//     ],
//   );
// }
//
// Widget glassButtonFees(BuildContext context, String fees) {
//   // defines a function that takes a string parameter called "fees"
//   return Padding(
//     padding:
//     const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2),
//     child:
//     fees == controller.feesSelected // if the fees parameter equals the selected fees
//         ? GlassContainer(
//       // render a button with glassmorphism effect
//       borderThickness: 1.5, // remove border if not active
//       blur: 50,
//       opacity: 0.1,
//       borderRadius: AppTheme.cardRadiusCircular,
//       child: TextButton(
//         style: TextButton.styleFrom(
//             padding: EdgeInsets.zero,
//             minimumSize: const Size(50, 30),
//             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             alignment: Alignment.centerLeft),
//         onPressed: () {},
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//             vertical: AppTheme.elementSpacing * 0.5,
//             horizontal: AppTheme.elementSpacing,
//           ),
//           child: Text(fees,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleMedium!
//                   .copyWith(color: AppTheme.white90)),
//         ),
//       ),
//     )
//         : TextButton(
//       // if the fees parameter is not selected
//       style: TextButton.styleFrom(
//           padding: EdgeInsets.zero,
//           minimumSize: const Size(50, 20),
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           alignment: Alignment.centerLeft),
//       onPressed: () {
//
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           vertical: AppTheme.elementSpacing * 0.5,
//           horizontal: AppTheme.elementSpacing,
//         ),
//         child: Text(
//           fees,
//           style: Theme.of(context)
//               .textTheme
//               .titleMedium!
//               .copyWith(color: AppTheme.white60),
//         ),
//       ),
//     ),
//   );
// }

// Widget onChainFees(BuildContext context){
//   return  Padding(
//     padding: const EdgeInsets.symmetric(
//         horizontal: AppTheme.cardPadding),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // A Row widget with a Text widget, a SizedBox widget, and a GestureDetector widget
//         Row(
//           children: [
//             Text(
//               "Gebühren",
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             SizedBox(
//               width: AppTheme.elementSpacing / 2,
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Displays a snackbar message when tapped
//                 displaySnackbar(
//                     context,
//                     "Die Gebührenhöhe bestimmt über "
//                         "die Transaktionsgeschwindigkeit. "
//                         "Wenn du hohe Gebühren zahlst wird deine "
//                         "Transaktion schneller bei dem Empfänger ankommen");
//               },
//               child: Icon(
//                 Icons.info_outline_rounded,
//                 color: AppTheme.white90,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: AppTheme.cardPadding,
//         ),
//         // A function that returns a widget for choosing fees
//
//         SizedBox(
//           height: AppTheme.cardPadding * 2,
//         ),
//       ],
//     ),
//   );
// }
