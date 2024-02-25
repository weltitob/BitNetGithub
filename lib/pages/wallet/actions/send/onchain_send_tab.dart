import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/components/swipebutton/swipeable_button_view.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrix/matrix.dart';

class OnChainSendTab extends StatelessWidget {
  final SendController controller;
  const OnChainSendTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: ListView(
        children: [
          Container(
            height:
            MediaQuery.of(context).size.height - AppTheme.cardPadding * 7.5,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: <Widget>[
                    userTile(context),
                    // A SizedBox widget with a height of AppTheme.cardPadding * 2
                    const SizedBox(
                      height: AppTheme.cardPadding * 6,
                    ),
                    // A Center widget with a child of bitcoinWidget()
                    Center(child: bitcoinWidget(context)),
                    const SizedBox(
                      height: AppTheme.cardPadding * 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: Text(
                        controller.description.isEmpty ? "" : ',,${controller.description}"',
                        style:
                        Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                // A Padding widget that contains a button widget
                Padding(
                    padding: EdgeInsets.only(bottom: AppTheme.cardPadding * 1),
                    child: button(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget selectNetworkButtons(
      BuildContext context,
      String text,
      String imagePath,
      bool isActive,
      ) {
    return isActive
        ? GlassContainer(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppTheme.elementSpacing * 0.75,
            vertical: AppTheme.elementSpacing * 0.5,
          ),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: AppTheme.cardPadding * 1,
                height: AppTheme.cardPadding * 1,
              ),
              Container(
                width: AppTheme.elementSpacing,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ))
        : Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppTheme.elementSpacing * 0.75,
        vertical: AppTheme.elementSpacing * 0.5,
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: AppTheme.cardPadding * 1,
            height: AppTheme.cardPadding * 1,
          ),
          Container(
            width: AppTheme.elementSpacing,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  // This widget represents a user tile with an avatar, title, subtitle, and edit button.
  Widget userTile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The ListTile widget is used to display the user tile.
        ListTile(
          // The leading widget is a circle avatar that displays an image.
          leading: Avatar(),
          // The title displays the user's name.
          title: Text(
            "Unbekannt",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          // The subtitle displays a card number.
          subtitle: cardWithNumber(context),
          // The trailing widget is an icon button that is used to edit the user's information.
          trailing: GestureDetector(
              child: const Icon(Icons.edit_rounded,
                  color: Colors.grey, size: AppTheme.cardPadding),
              onTap: () {
                Logs().w("Edit button pressed");
                controller.resetValues();
              }),
        ),
      ],
    );
  }

// A widget to display the bitcoin receiver address in a row with an icon for copying it to the clipboard
  Widget cardWithNumber(BuildContext context) {
    return GestureDetector(
      // On tap, copies the receiver address to the clipboard and displays a snackbar
      onTap: () async {
        await Clipboard.setData(
            ClipboardData(text: controller.bitcoinReceiverAdress));
        displaySnackbar(context, "Wallet-Adresse in Zwischenablage kopiert");
      },
      child: Row(
        children: [
          // Icon for copying the receiver address to clipboard
          const Icon(Icons.copy_rounded, color: Colors.grey, size: 16),
          SizedBox(
            width: AppTheme.cardPadding * 8,
            child: Text(
              // The receiver address to be displayed
              controller.bitcoinReceiverAdress,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget bitcoinWidget(BuildContext context) {
    //final userWallet = Provider.of<UserWallet>(context);
    final userWallet = UserWallet(
        walletAddress: "fakewallet",
        walletType: "walletType",
        walletBalance: "0",
        privateKey: "privateKey",
        userdid: "userdid");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Wert eingeben",
          //       style: Theme.of(context).textTheme.titleLarge,
          //     ),
          //     Text("${userWallet.walletBalance}BTC verfügbar",
          //         style: Theme.of(context).textTheme.bodyMedium),
          //   ],
          // ),
          // SizedBox(
          //   height: AppTheme.cardPadding * 1.5,
          // ),
          AmountWidget(
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    // Return a Padding widget containing a SwipeableButtonView
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SwipeableButtonView(
        // Determine if the button should be active based on whether a receiver has been selected
          isActive: controller.hasReceiver,
          // Set the text style for the button text
          buttontextstyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppTheme.white80, shadows: [AppTheme.boxShadowSmall]),
          // Set the text to display on the button
          buttonText: "JETZT SENDEN!",
          // Set the widget to display inside the button
          buttonWidget: Container(
            child: Icon(
              // Set the icon to display based on whether a receiver has been selected
              controller.hasReceiver
                  ? Icons.double_arrow_rounded
                  : Icons.lock_outline_rounded,
              color: AppTheme.white90,
              size: 33,
              shadows: [AppTheme.boxShadowProfile],
            ),
          ),
          // Set the active and disabled colors for the button
          activeColor: Colors.purple.shade800,
          disableColor: Colors.purple.shade800,
          // Determine whether the button has finished its operation
          isFinished: controller.isFinished,
          // Define the function to execute while the button is in a waiting state
          onWaitingProcess: () async {
            Logs().w("onWaitingProcess() called");
            await controller.sendBTC();
            controller.isFinished = true;
            // Wait for 2 seconds, then set isFinished to true
            // Future.delayed(const Duration(seconds: 1), () {
            //   controller.isFinished = true;
            // });
          },
          // Define the function to execute when the button is finished
          onFinish: () async {
            Logs().w("onFinish() called");
          }
        // Check if biometric authentication is available
      ),
    );
  }
}

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
//
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
