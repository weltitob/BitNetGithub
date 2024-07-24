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

class LightningReceiveTab extends GetWidget<ReceiveController> {
  const LightningReceiveTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //mainAxisSize: MainAxisSize.min,
          // The contents of the screen are centered vertically
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppTheme.cardPadding * 2,
            ),
            GestureDetector(
              onTap: () async {
                await Clipboard.setData(ClipboardData(
                    text: controller.qrCodeDataStringLightning.value));
                // Display a snackbar to indicate that the wallet address has been copied
                showOverlay(context, L10n.of(context)!.walletAddressCopied);
              },
              child: SizedBox(
                child: Center(
                  child: RepaintBoundary(
                    // The Qr code is generated from this widget's global key
                    key: controller.globalKeyQR,
                    child: Column(
                      children: [
                        // Custom border painted around the Qr code
                        CustomPaint(
                          foregroundPainter:
                              Theme.of(context).brightness == Brightness.light
                                  ? BorderPainterBlack()
                                  : BorderPainter(),
                          child: Container(
                            margin: const EdgeInsets.all(AppTheme.cardPadding),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: AppTheme.cardRadiusBigger),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  AppTheme.cardPadding / 1.25),
                              // The Qr code is generated using the pretty_qr package with an image, size, and error correction level
                              child: Obx(() => PrettyQrView.data(
                                  data:
                                      "lightning: ${controller.qrCodeDataStringLightning}",
                                  decoration: const PrettyQrDecoration(
                                    shape: PrettyQrSmoothSymbol(
                                      roundFactor: 1,
                                    ),
                                    image: PrettyQrDecorationImage(
                                      image: const AssetImage(
                                          'assets/images/lightning.png'),
                                    ),
                                  ))),
                            ),
                          ),
                        ),
                        LongButtonWidget(
                          customHeight: AppTheme.cardPadding * 2,
                          customWidth: AppTheme.cardPadding * 5,
                          title: L10n.of(context)!.share,
                          leadingIcon: Icon(Icons.share_rounded),
                          onTap: () {
                            Share.share(
                                '${controller.qrCodeDataStringLightning}');
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
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            BitNetListTile(
              onTap: () async {
                await Clipboard.setData(ClipboardData(
                    text: controller.qrCodeDataStringLightning.value));
                // Display a snackbar to indicate that the wallet address has been copied
                showOverlay(context, L10n.of(context)!.walletAddressCopied);
              },
              text: L10n.of(context)!.invoice,
              trailing: Obx(() {
                final qrCodeData = controller.qrCodeDataStringLightning.value;
                if (qrCodeData.isEmpty ||
                    qrCodeData == '' ||
                    qrCodeData == 'null') {
                  return Text('${L10n.of(context)!.loading}...');
                } else {
                  final start = qrCodeData.length >= 8
                      ? qrCodeData.substring(0, 8)
                      : qrCodeData;
                  final end = qrCodeData.length > 8
                      ? qrCodeData.substring(qrCodeData.length - 5)
                      : '';
                  return Row(
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        color: Theme.of(context).colorScheme.brightness ==
                                Brightness.dark
                            ? AppTheme.white60
                            : AppTheme.black80,
                      ),
                      SizedBox(width: AppTheme.elementSpacing / 2),
                      Text(start),
                      if (qrCodeData.length > 8) Text('....'),
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
                        text: "${L10n.of(context)!.changeAmount}",
                        context: context,
                      ),
                      body: SingleChildScrollView(child: CreateInvoice()),
                      context: context,
                    ),
                  );

                  setState(() {});
                },
                text: L10n.of(context)!.amount,
                trailing: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.dark
                          ? AppTheme.white60
                          : AppTheme.black80,
                    ),
                    SizedBox(width: AppTheme.elementSpacing / 2),
                    Text(
                      controller.satController.text == "0" ||
                              controller.satController.text.isEmpty
                          ? L10n.of(context)!.changeAmount
                          : controller.satController.text,
                    ),
                    controller.satController.text == "0" ||
                            controller.satController.text.isEmpty
                        ? SizedBox()
                        : Icon(
                            getCurrencyIcon(
                              BitcoinUnits.SAT.name,
                            ),
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppTheme.black70
                                    : AppTheme.white90,
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
}
