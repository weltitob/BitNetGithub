import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class OnChainReceiveTab extends GetWidget<ReceiveController> {
  OnChainReceiveTab({super.key});

  // Get the current user's wallet from a provider
  final GlobalKey globalKeyQR = GlobalKey();

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
          Obx(() {
            return GestureDetector(
              onTap: () async {
                await Clipboard.setData(ClipboardData(
                    text: controller.qrCodeDataStringOnchain.value));
                // Display a snackbar to indicate that the wallet address has been copied
                showOverlay(
                    context, "Wallet-Adresse in Zwischenablage kopiert");
              },
              child: SizedBox(
                child: Center(
                  child: RepaintBoundary(
                    // The Qr code is generated from this widget's global key
                    key: globalKeyQR,
                    child: Column(
                      children: [
                        // Custom border painted around the Qr code
                        CustomPaint(
                          foregroundPainter: BorderPainter(),
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
                                      "bitcoin: ${controller.qrCodeDataStringOnchain}",
                                  decoration: const PrettyQrDecoration(
                                    shape: PrettyQrSmoothSymbol(
                                      roundFactor: 1,
                                    ),
                                    image: PrettyQrDecorationImage(
                                      image: const AssetImage(
                                          'assets/images/bitcoin.png'),
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
                                '${controller.qrCodeDataStringOnchain}');
                          },
                          buttonType: ButtonType.transparent,
                        ),
                        // SizedBox to add some spacing
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          BitNetListTile(
            text: 'Invoice',
            trailing: Obx(() {
              return controller.qrCodeDataStringOnchain.value.isEmpty
                  ? Text('')
                  : Row(
                      children: [
                        Text(controller.qrCodeDataStringOnchain.value
                            .substring(0, 8)),
                        Text('....'),
                        Text(controller.qrCodeDataStringOnchain.value.substring(
                            controller.qrCodeDataStringOnchain.value.length -
                                5)),
                        SizedBox(width: 10.0),
                        RoundedButtonWidget(
                          size: AppTheme.cardPadding * 1.5,
                          iconData: FontAwesomeIcons.copy,
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text:
                                    controller.qrCodeDataStringOnchain.value));
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
          BitNetListTile(
            text: 'Amount',
            trailing: LongButtonWidget(
              customHeight: AppTheme.cardPadding * 2,
              customWidth: AppTheme.cardPadding * 7,
              buttonType: ButtonType.transparent,
              title: controller.amountController.text.isEmpty
                  ? "Change Amount"
                  : controller.amountController.text,
              onTap: () {},
            ),
          ),
          const SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
        ],
      ),
    );
  }
}
