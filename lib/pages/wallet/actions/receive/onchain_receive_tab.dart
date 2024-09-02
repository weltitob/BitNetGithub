import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/createinvoicebottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class OnChainReceiveTab extends StatefulWidget {
  const OnChainReceiveTab({super.key});

  @override
  State<OnChainReceiveTab> createState() => _OnChainReceiveTabState();
}

class _OnChainReceiveTabState extends State<OnChainReceiveTab> with AutomaticKeepAliveClientMixin {
  // Get the current user's wallet from a provider
  final GlobalKey globalKeyQR = GlobalKey();
  ValueNotifier<String> btcControllerNotifier = ValueNotifier('');
  @override
  void initState() {
    final controller = Get.find<ReceiveController>();

    btcControllerNotifier = ValueNotifier(controller.btcController.text);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = Get.find<ReceiveController>();

    btcControllerNotifier = ValueNotifier(controller.btcController.text);
  }

  @override
  void dispose() {
    btcControllerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = Get.find<ReceiveController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // The contents of the screen are centered vertically
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppTheme.cardPadding * 2,
            ),
            Obx(() {
              controller.qrCodeDataStringOnchain.value;
              return GestureDetector(
                onTap: () async {
                  double? invoiceAmount = double.tryParse(controller.btcController.text);
                  if (invoiceAmount != null && invoiceAmount > 0) {
                    await Clipboard.setData(
                        ClipboardData(text: 'bitcoin:${controller.qrCodeDataStringOnchain.value}?amount=${invoiceAmount}'));
                  } else {
                    await Clipboard.setData(ClipboardData(text: controller.qrCodeDataStringOnchain.value));
                  }
                  // Display a snackbar to indicate that the wallet address has been copied
                  showOverlay(context, L10n.of(context)!.walletAddressCopied);
                },
                child: SizedBox(
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: btcControllerNotifier,
                      builder: (ctx, notifier, _) => RepaintBoundary(
                        // The Qr code is generated from this widget's global key
                        key: globalKeyQR,
                        child: Column(
                          children: [
                            // Custom border painted around the Qr code
                            CustomPaint(
                              foregroundPainter: Theme.of(context).brightness == Brightness.light ? BorderPainterBlack() : BorderPainter(),
                              child: Container(
                                margin: const EdgeInsets.all(AppTheme.cardPadding),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: AppTheme.cardRadiusBigger),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppTheme.cardPadding / 1.25),
                                  // The Qr code is generated using the pretty_qr package with an image, size, and error correction level
                                  child: PrettyQrView.data(
                                      data: "bitcoin:${controller.qrCodeDataStringOnchain}" +
                                          ((double.tryParse(controller.btcController.text) != null &&
                                                  double.tryParse(controller.btcController.text) != 0)
                                              ? '?amount=${double.parse(controller.btcController.text)}'
                                              : ''),
                                      decoration: const PrettyQrDecoration(
                                        shape: PrettyQrSmoothSymbol(
                                          roundFactor: 1,
                                        ),
                                        image: PrettyQrDecorationImage(
                                          image: const AssetImage('assets/images/bitcoin.png'),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            LongButtonWidget(
                              customHeight: AppTheme.cardPadding * 2,
                              customWidth: AppTheme.cardPadding * 5,
                              title: L10n.of(context)!.share,
                              leadingIcon: const Icon(Icons.share_rounded),
                              onTap: () {
                                // Share the wallet address
                                double? invoiceAmount = double.tryParse(controller.btcController.text);
                                if (invoiceAmount != null && invoiceAmount > 0) {
                                  Share.share('bitcoin:${controller.qrCodeDataStringOnchain.value}?amount=${invoiceAmount}');
                                } else {
                                  Share.share(controller.qrCodeDataStringOnchain.value);
                                }
                              },
                              buttonType: ButtonType.transparent,
                            ),
                            // SizedBox to add some spacing
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
            BitNetListTile(
              onTap: () async {
                double? invoiceAmount = double.tryParse(controller.btcController.text);
                if (invoiceAmount != null && invoiceAmount > 0) {
                  await Clipboard.setData(
                      ClipboardData(text: 'bitcoin:${controller.qrCodeDataStringOnchain.value}?amount=${invoiceAmount}'));
                } else {
                  await Clipboard.setData(ClipboardData(text: controller.qrCodeDataStringOnchain.value));
                }

                // Display a snackbar to indicate that the wallet address has been copied
                showOverlay(context, L10n.of(context)!.walletAddressCopied);
              },
              text: L10n.of(context)!.invoice,
              trailing: Obx(() {
                final qrCodeData = controller.qrCodeDataStringOnchain.value;
                if (qrCodeData.isEmpty || qrCodeData == '' || qrCodeData == 'null') {
                  return Text('${L10n.of(context)!.loading}...');
                } else {
                  final start = qrCodeData.length >= 8 ? qrCodeData.substring(0, 8) : qrCodeData;
                  final end = qrCodeData.length > 8 ? qrCodeData.substring(qrCodeData.length - 5) : '';
                  return Row(
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        color: Theme.of(context).colorScheme.brightness == Brightness.dark ? AppTheme.white60 : AppTheme.black80,
                      ),
                      const SizedBox(width: AppTheme.elementSpacing / 2),
                      Text(start),
                      if (qrCodeData.length > 8) const Text('....'),
                      Text(end),
                    ],
                  );
                }
              }),
            ),
            StatefulBuilder(builder: (context, setState) {
              return BitNetListTile(
                onTap: () async {
                  await BitNetBottomSheet(
                    context: context,
                    //also add a help button as an action at the right once bitnetbottomsheet is fixed
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: bitnetScaffold(
                      extendBodyBehindAppBar: true,
                      appBar: bitnetAppBar(
                        hasBackButton: false,
                        buttonType: ButtonType.transparent,
                        text: "Change Amount",
                        context: context,
                      ),
                      body: SingleChildScrollView(
                          child: CreateInvoice(
                        onChain: true,
                      )),
                      context: context,
                    ),
                  );

                  setState(() {});
                  btcControllerNotifier.value = controller.btcController.text;
                },
                text: L10n.of(context)!.amount,
                trailing: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.brightness == Brightness.dark ? AppTheme.white60 : AppTheme.black80,
                    ),
                    const SizedBox(width: AppTheme.elementSpacing / 2),
                    Text(
                      controller.satController.text == "0" || controller.satController.text.isEmpty
                          ? "Change Amount"
                          : controller.satController.text,
                    ),
                    controller.satController.text == "0" || controller.satController.text.isEmpty
                        ? const SizedBox()
                        : Icon(
                            getCurrencyIcon(
                              BitcoinUnits.SAT.name,
                            ),
                            color: Theme.of(context).brightness == Brightness.light ? AppTheme.black70 : AppTheme.white90,
                          )
                  ],
                ),
              );
            }),
            const SizedBox(
              height: AppTheme.cardPadding * 2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
