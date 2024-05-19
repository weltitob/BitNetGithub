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
                          customHeight: AppTheme.cardPadding * 2,
                          customWidth: AppTheme.cardPadding * 5,
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
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          BitNetListTile(
            onTap:  () async {
              await Clipboard.setData(ClipboardData(
                  text:
                  controller.qrCodeDataStringOnchain.value));
              // Display a snackbar to indicate that the wallet address has been copied
              showOverlay(context,
                  "Wallet-Adresse in Zwischenablage kopiert");
            },
            text: 'Invoice',
            trailing: Obx(() {
              return controller.qrCodeDataStringOnchain.value.isEmpty
                  ? Text('loading...')
                  : Row(
                      children: [
                        Icon(Icons.copy_rounded, color: Theme.of(context).colorScheme.brightness == Brightness.dark ? AppTheme.white60 : AppTheme.black80,),
                        SizedBox(width: AppTheme.elementSpacing / 2),
                        Text(controller.qrCodeDataStringOnchain.value
                            .substring(0, 8)),
                        Text('....'),
                        Text(controller.qrCodeDataStringOnchain.value.substring(
                            controller.qrCodeDataStringOnchain.value.length -
                                5)),
                      ],
                    );
            }),
          ),
      BitNetListTile(
        text: 'Amount',
        trailing:
        Row(
          children: [
            Icon(Icons.edit, color: Theme.of(context).colorScheme.brightness == Brightness.dark ? AppTheme.white60 : AppTheme.black80,),
            SizedBox(width: AppTheme.elementSpacing / 2),
            Text(controller.amountController.text.isEmpty
                ? "Change Amount"
                : controller.amountController.text,),
          ],
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
