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
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LightningSendTab extends GetWidget<SendsController> {
  const LightningSendTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Form(
      key: controller.formKey,
      child: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - AppTheme.cardPadding * 7.5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        userTile(context),
                        // A SizedBox widget with a height of AppTheme.cardPadding * 2
                        const SizedBox(
                          height: AppTheme.cardPadding * 6,
                        ),
                        // A Center widget with a child of bitcoinWidget()
                        Center(child: bitcoinWidget(context)),
                        const SizedBox(
                          height: AppTheme.cardPadding * 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                          child: Obx(
                            () => Text(
                              controller.description.value.isEmpty ? "" : ',,${controller.description}"',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Obx(
                    //   () => Text(
                    //     controller.amountWidgetOverBound.value
                    //         ? L10n.of(context)!.youAreOverLimit
                    //         : controller.amountWidgetUnderBound.value
                    //             ? L10n.of(context)!.youAreUnderLimit
                    //             : "",
                    //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // A Padding widget that contains a button widget
                    // Padding(
                    //   padding: EdgeInsets.only(bottom: AppTheme.cardPadding * 1),
                    //   child: Obx(
                    //     () => LongButtonWidget(
                    //       title: L10n.of(context)!.sendNow,
                    //       buttonType: (!controller.amountWidgetOverBound.value &&
                    //               !controller.amountWidgetUnderBound.value)
                    //           ? ButtonType.solid
                    //           : ButtonType.transparent,
                    //       onTap: (!controller.amountWidgetOverBound.value &&
                    //               !controller.amountWidgetUnderBound.value)
                    //           ? () async {
                    //               logger.i("lightning SendBTC getting called");
                    //               await controller.sendBTC(context);
                    //             }
                    //           : null,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          // Wrap the BottomCenterButton in Obx to make it reactive
          Obx(() => BottomCenterButton(
            buttonTitle: L10n.of(context)!.sendNow,
            buttonState: controller.loadingSending.value
                ? ButtonState.loading
                : ButtonState.idle,
            onButtonTap: () async {
              if(controller.loadingSending == false) {
                controller.toggleButtonState();
                await controller.sendBTC(context);
                controller.isFinished.listen((isFinished) {
                  if (isFinished) {
                    controller.toggleButtonState();
                  }
                });
              }
              // controller.toggleButtonState();
            },
          )
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
            margin: const EdgeInsets.symmetric(
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
            margin: const EdgeInsets.symmetric(
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

  Widget userTile(BuildContext context) {
    LoggerService logger = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          // The leading widget is a circle avatar that displays an image.
          leading: const Avatar(
            isNft: false,
          ),
          // The title displays the user's name.
          title: Text(
            L10n.of(context)!.unknown,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          // The subtitle displays a card number.
          subtitle: cardWithNumber(context),
          // The trailing widget is an icon button that is used to edit the user's information.
          trailing: GestureDetector(
              child: const Icon(Icons.edit_rounded, color: Colors.grey, size: AppTheme.cardPadding),
              onTap: () {
                logger.i("Edit button pressed");
                controller.resetValues();
              }),
        ),
      ],
    );
  }

// A widget to display the bitcoin receiver address in a row with an icon for copying it to the clipboard
  Widget cardWithNumber(BuildContext context) {
    final overlayController = Get.find<OverlayController>();

    return GestureDetector(
      // On tap, copies the receiver address to the clipboard and displays a snackbar
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: controller.bitcoinReceiverAdress));
        overlayController.showOverlay(L10n.of(context)!.walletAddressCopied);
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
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget bitcoinWidget(BuildContext context) {
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";
    if (!Get.isRegistered<WalletsController>()) {
      Get.put(WalletsController());
    }
    final chartLine = Get.find<WalletsController>().chartLines.value;

    final bitcoinPrice = chartLine?.price;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountWidget(
              ctrler: controller,
              bitcoinUnit: controller.bitcoinUnit,
              init: (controller.sendType == SendType.LightningUrl || controller.sendType == SendType.Invoice)
                  ? () {
                      //IZAK: bitcoin price might be null on init, potential fix would be not allowing user to Send when
                      //btc price is unknown, currently temporary fix of letting currencyController text be "0.0"
                      String currencyEquivalent = bitcoinPrice != null
                          ? CurrencyConverter.convertCurrency("SATS", double.parse(controller.satController.text), currency!, bitcoinPrice,
                              fixed: false)
                          : "0.0";

                      controller.currencyController.text = double.parse(currencyEquivalent).toStringAsFixed(2);

                      if (controller.bitcoinUnit == BitcoinUnits.BTC) {
                        controller.btcController.text =
                            CurrencyConverter.convertSatoshiToBTC(double.parse(controller.satController.text)).toString();
                      }
                    }
                  : null,
              enabled: () => double.parse(controller.satController.text) == 0 || controller.sendType == SendType.LightningUrl,
              btcController: controller.btcController,
              satController: controller.satController,
              currController: controller.currencyController,
              focusNode: controller.myFocusNodeMoney,
              context: context,
              swapped: Get.find<WalletsController>().reversed.value,
              lowerBound: controller.lowerBound,
              upperBound: controller.upperBound,
              boundType: controller.boundType,
              autoConvert: !(controller.sendType == SendType.LightningUrl),
              preventConversion: () => controller.sendType == SendType.Invoice && double.parse(controller.satController.text) != 0)
        ],
      ),
    );
  }
}
