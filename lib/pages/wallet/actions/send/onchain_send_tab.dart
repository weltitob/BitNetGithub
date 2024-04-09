import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
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
                    child: LongButtonWidget(
                      title: "JETZT SENDEN!",
                      onTap: () async {
                        Logs().w("onchain SendBTC getting called");
                        await controller.sendBTC();
                      },
                    )),
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
            bitcoinUnit: controller.bitcoinUnit,
            enabled: controller.moneyTextFieldIsEnabled,
            btcController: controller.moneyController,
            currController: TextEditingController(),
            focusNode: controller.myFocusNodeMoney,
            context: context,
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

}