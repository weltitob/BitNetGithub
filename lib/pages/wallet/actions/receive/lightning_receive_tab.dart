import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/wallet/actions/receive/createinvoicebottomsheet.dart';
import 'package:bitnet/pages/wallet/actions/receive/receive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class LightningReceiveTab extends StatelessWidget {
  final ReceiveController controller;
  const LightningReceiveTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        // The contents of the screen are centered vertically
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lightning",
                style: Theme.of(context).textTheme.headline5,
              ),

              Row(
                children: [
                  RoundedButtonWidget(
                      size: AppTheme.cardPadding * 1.5,
                      buttonType: ButtonType.transparent,
                      iconData: controller.createdInvoice
                          ? FontAwesomeIcons.cancel
                          : FontAwesomeIcons.refresh,
                      onTap: () {
                        Logs().w(
                            "Refresh button pressed: New Bitcoin Adress should be generated // not implemented yet");
                      }),
                  SizedBox(width: AppTheme.elementSpacing,),
                  LongButtonWidget(
                      buttonType: ButtonType.transparent,
                      customHeight: AppTheme.cardPadding * 1.5,
                      customWidth: AppTheme.cardPadding * 3,
                      title: "23:04", onTap: (){})
                ],
              )
            ],
          ),
          // SizedBox to add some spacing
          const SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(
                  ClipboardData(text: controller.qrCodeDataStringLightning));
              // Display a snackbar to indicate that the wallet address has been copied
              showOverlay(
                  context, "Wallet-Adresse in Zwischenablage kopiert");
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
                        foregroundPainter: Theme.of(context).brightness == Brightness.light ? BorderPainterBlack() : BorderPainter(),
                        child: Container(
                          margin: const EdgeInsets.all(AppTheme.cardPadding),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: AppTheme.cardRadiusBigger),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(AppTheme.cardPadding / 1.25),
                            // The Qr code is generated using the pretty_qr package with an image, size, and error correction level
                            child: PrettyQrView.data(
                              data: "lightning: ${controller.qrCodeDataStringLightning}",
                              decoration: const PrettyQrDecoration(
                                shape: PrettyQrSmoothSymbol(
                                  roundFactor: 1,
                                ),
                                image: PrettyQrDecorationImage(
                                  image: const AssetImage('assets/images/lightning.png'),
                                ),)),
                            ),
                          ),
                        ),
                      // SizedBox to add some spacing
                    ],
                  ),
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () async {
          //     await Clipboard.setData(
          //         ClipboardData(text: controller.qrCodeDataStringLightning));
          //     // Display a snackbar to indicate that the wallet address has been copied
          //     showOverlay(
          //         context, "Wallet-Adresse in Zwischenablage kopiert");
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // Add an icon to copy the wallet address to the clipboard
          //       Icon(
          //         Icons.copy_rounded,
          //         size: 18,
          //         color: Theme.of(context).brightness == Brightness.light ? AppTheme.black60 : AppTheme.white60,
          //       ),
          //       const SizedBox(
          //         width: AppTheme.elementSpacing * 0.25,
          //       ),
          //       // Display the user's wallet address
          //       Container(
          //         width: AppTheme.cardPadding * 10,
          //         child: Text(
          //           "${controller.qrCodeDataStringLightning}",
          //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //
          //           ),
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Add some space between the rows
          const SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
          if (!controller.createdInvoice) Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: AppTheme.elementSpacing / 2,
                    ),
                    LongButtonWidget(
                      customHeight: AppTheme.cardPadding * 2,
                      customWidth: AppTheme.cardPadding * 8,
                      buttonType: ButtonType.transparent,
                      title: "Change amount",
                      leadingIcon: Icon(
                        FontAwesomeIcons.edit,
                        size: AppTheme.cardPadding,
                        color: AppTheme.white90,
                      ),
                      onTap: () {
                        BitNetBottomSheet(
                          context: context,
                          //also add a help button as an action at the right once bitnetbottomsheet is fixed
                          title: "Change Amount",
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: CreateInvoice(
                            controller: controller,
                          ),
                        );
                      },
                    ),
                    RoundedButtonWidget(iconData: Icons.share_rounded,
                      onTap: () {
                        // Share the wallet address
                        Share.share('${controller.qrCodeDataStringLightning}');
                      },
                      buttonType: ButtonType.transparent,),
                    RoundedButtonWidget(iconData: FontAwesomeIcons.copy, onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: controller.qrCodeDataStringLightning));
                      // Display a snackbar to indicate that the wallet address has been copied
                      showOverlay(
                          context, "Wallet-Adresse in Zwischenablage kopiert");
                    }, buttonType: ButtonType.transparent,),
                    SizedBox(
                      width: AppTheme.elementSpacing / 2,
                    ),
                  ],
                ) else Container()
        ],
      ),
    );
  }
}
