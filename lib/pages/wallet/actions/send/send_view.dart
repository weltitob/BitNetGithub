import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/appbaractions.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';

/// In your SendsController, add something like:
/// RxString bip21Mode = "onchain".obs;
/// (Possible values: "onchain" or "lightning")

class SendBTCScreen extends GetWidget<SendsController> {
  const SendBTCScreen({Key? key}) : super(key: key);

  // Helper getters to handle Bip21 case
  TextEditingController get satController =>
      controller.sendType == SendType.Bip21
          ? controller.bip21InvoiceSatController
          : controller.satController;

  TextEditingController get btcController =>
      controller.sendType == SendType.Bip21
          ? controller.bip21InvoiceBtcController
          : controller.btcController;

  TextEditingController get currencyController =>
      controller.sendType == SendType.Bip21
          ? controller.bip21InvoiceCurrencyController
          : controller.currencyController;

  String get bitcoinReceiverAddress =>
      controller.sendType == SendType.Bip21
          ? controller.bip21InvoiceAddress
          : controller.bitcoinReceiverAdress;

  GlobalKey<FormState> get formKey =>
      controller.sendType == SendType.Bip21
          ? controller.bip21InvoiceFormKey
          : controller.formKey;

  bool get isLightningPayment =>
      controller.sendType == SendType.Invoice ||
          controller.sendType == SendType.LightningUrl;

  bool get isOnChainPayment =>
      controller.sendType == SendType.OnChain;

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.colorBackground,
      appBar: bitnetAppBar(
        onTap: () {
          controller.usersQuery.value = '';
          controller.resetValues();
          controller.handleSearch('');
        },
        customTitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(L10n.of(context)!.sendBitcoin,
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        context: context,
        actions: [
          GestureDetector(
            onTap: () {},
            child: AppBarActionButton(
              iconData: isLightningPayment
                  ? FontAwesomeIcons.boltLightning
                  : FontAwesomeIcons.bitcoin,
            ),
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          controller.resetValues();
        },
        child: Column(
          children: [
            Obx(() => Expanded(
              child: controller.initializedValues.value
                  ? _buildSendContent(context)
                  : dotProgress(context),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSendContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: Form(
        key: formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildUserTile(context),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height -
                            AppTheme.cardPadding * 7.5,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: AppTheme.cardPadding * 4),
                                Center(child: _buildBitcoinWidget(context)),
                                const SizedBox(
                                    height: AppTheme.cardPadding * 2),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.cardPadding),
                                  child: Obx(
                                        () => Text(
                                      controller.description.value.isEmpty
                                          ? ""
                                          : ',,${controller.description}"',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                // Always show the network selection tile for Bip21.
                                if (controller.sendType == SendType.Bip21) ...[
                                  _buildNetworkSelectionTile(context),
                                  Obx(() {
                                    // If bip21Mode is onchain, show fees
                                    return controller.bip21Mode.value == "onchain"
                                        ? _buildFeesWidget(context)
                                        : Container();
                                  }),
                                ] else if (isOnChainPayment)
                                  _buildFeesWidget(context),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100) // space for bottom button
                    ],
                  ),
                ],
              ),
            ),
            // Send button
            Obx(() => BottomCenterButton(
              buttonTitle: L10n.of(context)!.sendNow,
              buttonState: controller.loadingSending.value
                  ? ButtonState.loading
                  : ButtonState.idle,
              onButtonTap: () async {
                if (!controller.loadingSending.value) {
                  controller.toggleButtonState();
                  await controller.sendBTC(context);
                  controller.isFinished.listen((isFinished) {
                    if (isFinished) {
                      controller.toggleButtonState();
                    }
                  });
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTile(BuildContext context, {bool isLightning = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Avatar(isNft: false),
          title: Text(
            L10n.of(context)!.unknown,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          // For Bip21, show the lightning address if mode is lightning; otherwise, show the default address.
          subtitle: _buildCardWithNumber(context, isLightning: isLightning),
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

  Widget _buildCardWithNumber(BuildContext context, {bool isLightning = false}) {
    final overlayController = Get.find<OverlayController>();
    final address = (controller.sendType == SendType.Bip21 &&
        controller.bip21Mode.value == "lightning" &&
        controller.bip21InvoiceAddress.isNotEmpty)
        ? controller.bip21InvoiceAddress
        : controller.bitcoinReceiverAdress;

    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: address));
        overlayController.showOverlay(L10n.of(context)!.walletAddressCopied);
      },
      child: Row(
        children: [
          const Icon(Icons.copy_rounded, color: Colors.grey, size: 16),
          SizedBox(
            width: AppTheme.cardPadding * 8,
            child: Text(
              address,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBitcoinWidget(BuildContext context, {bool isLightning = false}) {
    if (!Get.isRegistered<WalletsController>()) {
      Get.put(WalletsController());
    }

    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency ?? "USD";
    final bitcoinPrice = chartLine?.price;

    final TextEditingController usedSatController =
    isLightning && controller.sendType == SendType.Bip21
        ? controller.bip21InvoiceSatController
        : controller.satController;

    final TextEditingController usedBtcController =
    isLightning && controller.sendType == SendType.Bip21
        ? controller.bip21InvoiceBtcController
        : controller.btcController;

    final TextEditingController usedCurrencyController =
    isLightning && controller.sendType == SendType.Bip21
        ? controller.bip21InvoiceCurrencyController
        : controller.currencyController;

    if (!isLightning) {
      usedCurrencyController.text = bitcoinPrice != null
          ? CurrencyConverter.convertCurrency("SATS",
          double.parse(usedSatController.text), currency, bitcoinPrice)
          : "0.0";
    }

    return Obx(() {
      Get.find<WalletsController>().chartLines.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AmountWidget(
              ctrler: isLightning ? controller : null,
              bitcoinUnit: controller.bitcoinUnit,
              init: (isLightning &&
                  (controller.sendType == SendType.LightningUrl ||
                      controller.sendType == SendType.Invoice ||
                      controller.sendType == SendType.Bip21))
                  ? () {
                String currencyEquivalent = bitcoinPrice != null
                    ? CurrencyConverter.convertCurrency(
                    "SATS",
                    double.parse(usedSatController.text),
                    currency,
                    bitcoinPrice,
                    fixed: false)
                    : "0.0";
                usedCurrencyController.text =
                    double.parse(currencyEquivalent).toStringAsFixed(2);
                if (controller.bitcoinUnit == BitcoinUnits.BTC) {
                  usedBtcController.text =
                      CurrencyConverter.convertSatoshiToBTC(
                          double.parse(usedSatController.text))
                          .toString();
                }
              }
                  : null,
              enabled: () => isLightning
                  ? (double.parse(usedSatController.text) == 0 ||
                  controller.sendType == SendType.LightningUrl)
                  : true,
              btcController: usedBtcController,
              satController: usedSatController,
              currController: usedCurrencyController,
              focusNode: controller.myFocusNodeMoney,
              context: context,
              swapped: Get.find<WalletsController>().reversed.value,
              lowerBound: isLightning ? controller.lowerBound : null,
              upperBound: isLightning ? controller.upperBound : null,
              boundType: isLightning ? controller.boundType : null,
              autoConvert: isLightning
                  ? !(controller.sendType == SendType.LightningUrl)
                  : true,
              preventConversion: isLightning
                  ? () => (controller.sendType == SendType.Invoice ||
                  controller.sendType == SendType.Bip21) &&
                  double.parse(usedSatController.text) != 0
                  : null,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFeesWidget(BuildContext context) {
    if (controller.feesDouble == null) return Container();

    String currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency ?? "USD";
    final chartLine = Get.find<WalletsController>().chartLines.value;
    final bitcoinPrice = chartLine?.price;

    String inCurrency = CurrencyConverter.convertCurrency(
        "SATS", controller.feesDouble!, currency, bitcoinPrice);
    String inCurrencyBitNetFee = CurrencyConverter.convertCurrency(
        "SATS", controller.feesDouble! / 2, currency, bitcoinPrice);

    return Column(
      children: [
        Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding / 2),
            child: BitNetListTile(
              text: L10n.of(context)!.networkFee,
              trailing: Text(
                currency == "SATS"
                    ? controller.feesDouble.toString()
                    : (inCurrency + getCurrency(currency)),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )),
        Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding / 2),
            child: BitNetListTile(
              text: L10n.of(context)!.bitnetUsageFee,
              trailing: Text(
                currency == "SATS"
                    ? (controller.feesDouble! * 0.5).toString()
                    : (inCurrencyBitNetFee + getCurrency(currency)),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // NETWORK SELECTION HELPERS (for Bip21)
  // ---------------------------------------------------------------------------
  Widget _buildNetworkSelectionTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
      child: BitNetListTile(
        text: "Network",
        margin: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2),
        trailing: Obx(() {
          return Container(
            constraints: BoxConstraints(maxWidth: AppTheme.cardPadding * 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LongButtonWidget(
                  buttonType: ButtonType.transparent,
                  title: getNetworkTypeLabel(),
                  leadingIcon: getNetworkTypeIcon(),
                  onTap: () {
                    showNetworkTypeSheet(context);
                  },
                  customWidth: AppTheme.cardPadding * 6,
                  customHeight: AppTheme.cardPadding * 1.5,
                ),
              ],
            ),
          );
        }),
        onTap: () {
          showNetworkTypeSheet(context);
        },
      ),
    );
  }

  String getNetworkTypeLabel() {
    if (controller.sendType == SendType.Invoice ||
        controller.sendType == SendType.LightningUrl) {
      return 'Lightning';
    } else if (controller.sendType == SendType.OnChain) {
      return 'Onchain';
    } else if (controller.sendType == SendType.Bip21) {
      // Use the reactive bip21Mode to determine the label
      return controller.bip21Mode.value == "lightning"
          ? 'Lightning'
          : 'Onchain';
    } else {
      return 'Unknown';
    }
  }

  Widget getNetworkTypeIcon() {
    if (controller.sendType == SendType.Invoice ||
        controller.sendType == SendType.LightningUrl) {
      return const Icon(FontAwesomeIcons.bolt, size: AppTheme.cardPadding * 0.75);
    } else if (controller.sendType == SendType.OnChain) {
      return const Icon(FontAwesomeIcons.chain, size: AppTheme.cardPadding * 0.75);
    } else if (controller.sendType == SendType.Bip21) {
      return controller.bip21Mode.value == "lightning"
          ? const Icon(FontAwesomeIcons.bolt, size: AppTheme.cardPadding * 0.75)
          : const Icon(FontAwesomeIcons.chain, size: AppTheme.cardPadding * 0.75);
    } else {
      return const Icon(FontAwesomeIcons.questionCircle, size: AppTheme.cardPadding * 0.75);
    }
  }

  bool isBip21WithLightning(String address) {
    return address.contains('lightning=');
  }

  Future<void> showNetworkTypeSheet(BuildContext context) async {
    await BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.3,
      child: bitnetScaffold(
        appBar: bitnetAppBar(
          hasBackButton: false,
          buttonType: ButtonType.transparent,
          text: "Select Network Type",
          context: context,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 1.5),
          child: Column(
            children: [
              // Lightning option: update only the bip21Mode for dynamic switching
              if (controller.sendType == SendType.Bip21)
                BitNetListTile(
                  margin: EdgeInsets.zero,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 0.5,
                      vertical: AppTheme.elementSpacing * 0.5),
                  text: "Lightning",
                  selected: controller.sendType == SendType.Bip21 &&
                      controller.bip21Mode.value == "lightning",
                  trailing: Text(
                    "Fast & Low fees",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  leading: Icon(FontAwesomeIcons.bolt, size: AppTheme.cardPadding * 0.75),
                  onTap: () {
                    if (controller.sendType == SendType.Bip21 &&
                        controller.bitcoinReceiverAdress.isNotEmpty) {
                      final uri = Uri.parse(controller.bitcoinReceiverAdress);
                      final lightning = uri.queryParameters['lightning'] ?? '';
                      if (lightning.isNotEmpty) {
                        controller.bip21Mode.value = "lightning";
                        controller.giveValuesToInvoice(lightning);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                ),
              SizedBox(height: AppTheme.elementSpacing * 0.5),
              // Onchain option: update only the bip21Mode
              if (controller.sendType == SendType.Bip21)
                BitNetListTile(
                  margin: EdgeInsets.zero,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 0.5,
                      vertical: AppTheme.elementSpacing * 0.5),
                  text: "Onchain",
                  selected: controller.sendType == SendType.Bip21 &&
                      controller.bip21Mode.value == "onchain",
                  leading: Icon(FontAwesomeIcons.chain, size: AppTheme.cardPadding * 0.75),
                  onTap: () {
                    if (controller.sendType == SendType.Bip21 &&
                        controller.bitcoinReceiverAdress.isNotEmpty) {
                      final uri = Uri.parse(controller.bitcoinReceiverAdress);
                      controller.bip21Mode.value = "onchain";
                      controller.giveValuesToOnchainSend(uri.path);
                    }
                    Navigator.of(context).pop();
                  },
                  trailing: Text(
                    "Secure & Slow",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              // Combined option (if applicable)
              if (controller.sendType == SendType.Bip21 &&
                  isBip21WithLightning(controller.bitcoinReceiverAdress))
                BitNetListTile(
                  margin: EdgeInsets.zero,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 0.5,
                      vertical: AppTheme.elementSpacing * 0.5),
                  text: "Combined",
                  selected: false,
                  leading: Icon(FontAwesomeIcons.bitcoin, size: AppTheme.cardPadding * 0.75),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  trailing: Text(
                    "Onchain & Lightning",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
            ],
          ),
        ),
        context: context,
      ),
    );
  }
}
