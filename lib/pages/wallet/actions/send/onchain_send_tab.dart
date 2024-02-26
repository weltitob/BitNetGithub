import 'package:bitnet/backbone/helper/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/swipebutton/swipeable_button_view.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:flutter/services.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

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
        showOverlay(context, "Wallet-Adresse in Zwischenablage kopiert");
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
    final chartLine = Provider.of<ChartLine?>(context, listen: true);
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null ? (controller.feesDouble / 100000000 * bitcoinPrice).toStringAsFixed(2) : "0.00";


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AmountWidget(
            enabled: controller.moneyTextFieldIsEnabled,
            amountController: controller.moneyController,
            focusNode: controller.myFocusNodeMoney,
          ),
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          Container(
            child: Text(
              "Fees ≈ ${currencyEquivalent}${getCurrency(currency)}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
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
