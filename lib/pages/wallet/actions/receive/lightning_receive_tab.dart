import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/createinvoicebottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      child: Column(
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
              showOverlay(context, "Wallet-Adresse in Zwischenablage kopiert");
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
                            child: PrettyQrView.data(
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
                                )),
                          ),
                        ),
                      ),
                      LongButtonWidget(
                        customWidth: AppTheme.cardPadding * 6,
                        title: 'Share',
                        leadingIcon: Icon(Icons.share_rounded),
                        onTap: () {
                          // Share the wallet address
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
          BitNetListTile(
            text: 'Invoice',
            trailing: Obx(() {
              return controller.qrCodeDataStringLightning.value.isEmpty
                  ? Text('')
                  : Row(
                      children: [
                        Text(controller.qrCodeDataStringLightning.value
                            .substring(0, 8)),
                        Text('....'),
                        Text(controller.qrCodeDataStringLightning.value
                            .substring(controller
                                    .qrCodeDataStringLightning.value.length -
                                5)),
                        SizedBox(width: 10.0),
                        RoundedButtonWidget(
                          size: AppTheme.cardPadding * 1.5,
                          iconData: FontAwesomeIcons.copy,
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text: controller
                                    .qrCodeDataStringLightning.value));
                            // Display a snackbar to indicate that the wallet address has been copied
                            showOverlay(context,
                                "Wallet-Adresse in Zwischenablage kopiert");
                          },
                          buttonType: ButtonType.transparent,
                        ),
                      ],
                    );
            }),
          ),
          StatefulBuilder(builder: (context, setState) {
            return BitNetListTile(
              text: 'Amount',
              trailing: LongButtonWidget(
                customHeight: AppTheme.cardPadding * 2,
                customWidth: AppTheme.cardPadding * 7,
                buttonType: ButtonType.transparent,
                title: controller.amountController.text.isEmpty
                    ? "Change Amount"
                    : controller.amountController.text,
                onTap: () async {
                  bool res = await BitNetBottomSheet(
                    context: context,
                    //also add a help button as an action at the right once bitnetbottomsheet is fixed
                    title: "Change Amount",
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: CreateInvoice(),
                  );
                  if (res) {
                    setState(() {});
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
