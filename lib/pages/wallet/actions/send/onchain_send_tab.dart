import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class OnChainSendTab extends GetWidget<SendsController> {
  const OnChainSendTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoggerService logger = Get.find();
    return Form(
      key: controller.formKey,
      child: Stack(
        children: [
          ListView(
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
                          child: Obx(
                            () => Text(
                              controller.description.value.isEmpty
                                  ? ""
                                  : ',,${controller.description}"',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // A Padding widget that contains a button widget
                  ],
                ),
              ),
            ],
          ),
          BottomCenterButton(
            buttonTitle: L10n.of(context)!.sendNow,
            buttonState: ButtonState.idle,
            onButtonTap: () async {
              await controller.sendBTC(context);
            },
          )
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
    LoggerService logger = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The ListTile widget is used to display the user tile.
        ListTile(
          // The leading widget is a circle avatar that displays an image.
          leading: Avatar(),
          // The title displays the user's name.
          title: Text(
            L10n.of(context)!.unknown,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          // The subtitle displays a card number.
          subtitle: cardWithNumber(context),
          // The trailing widget is an icon button that is used to edit the user's information.
          trailing: GestureDetector(
              child: const Icon(Icons.edit_rounded,
                  color: Colors.grey, size: AppTheme.cardPadding),
              onTap: () {
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
        showOverlay(context, L10n.of(context)!.walletAddressCopied);
      },
      child: Row(
        children: [
          // Icon for copying the receiver address to
          const Icon(Icons.copy_rounded, color: Colors.grey, size: 16),
          SizedBox(
            width: AppTheme.cardPadding * 8,
            child: Text(
              // The receiver address to be displayed
              controller.bitcoinReceiverAdress,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget bitcoinWidget(BuildContext context) {
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    // final currencyEquivalent = bitcoinPrice != null
    //     ? (controller.feesDouble / 100000000 * bitcoinPrice).toStringAsFixed(2)
    //     : "0.00";
    controller.currencyController.text = bitcoinPrice != null ? CurrencyConverter.convertCurrency(
        "SATS",
        double.parse(controller.satController.text),
        currency,
        bitcoinPrice) : "0.0";
    return Obx(() {
      Get.find<WalletsController>().chartLines.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AmountWidget(
                bitcoinUnit: controller.bitcoinUnit,
                enabled: () =>
                    double.parse(controller.currencyController.text) == 0,
                satController: controller.satController,
                btcController: controller.btcController,
                currController: controller.currencyController,
                focusNode: controller.myFocusNodeMoney,
                context: context,
                autoConvert: true,
                                swapped: Get.find<WalletsController>().reversed.value,
),
          ],
        ),
      );
    });
  }
}
