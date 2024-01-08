import 'package:animations/animations.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/pages/wallet/actions/receive/createinvoicebottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matrix/matrix.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class LightningReceiveTab extends StatefulWidget {
  const LightningReceiveTab({super.key});

  @override
  State<LightningReceiveTab> createState() => _LightningReceiveTabState();
}

class _LightningReceiveTabState extends State<LightningReceiveTab> {

  bool createdInvoice = false;

  final userWallet = UserWallet(
      walletAddress: "publickeyforkeysend",
      walletType: "walletType",
      walletBalance: "0",
      privateKey: "privateKey",
      userdid: "userdid");

  // A GlobalKey is used to identify this widget in the widget tree, used to access and modify its properties
  GlobalKey globalKeyQR = GlobalKey();

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
                "Keysend Lightningaddress",
                style: Theme.of(context).textTheme.headline5,
              ),
              RoundedButtonWidget(
                  size: AppTheme.cardPadding * 1.5,
                  buttonType: ButtonType.transparent,
                  iconData: createdInvoice
                      ? FontAwesomeIcons.cancel
                      : FontAwesomeIcons.refresh,
                  onTap: () {
                    Logs().w(
                        "Refresh button pressed: New Bitcoin Adress should be generated // not implemented yet");
                  })
            ],
          ),
          // SizedBox to add some spacing
          const SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
          SizedBox(
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
                            borderRadius: AppTheme.cardRadiusSmall),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppTheme.cardPadding / 2),
                          // The Qr code is generated using the pretty_qr package with an image, size, and error correction level
                          child: PrettyQr(
                            image:
                                const AssetImage('assets/images/lightning.png'),
                            typeNumber: null,
                            size: qrCodeSize(context),
                            data: "bitcoin: ${userWallet.walletAddress}",
                            errorCorrectLevel: QrErrorCorrectLevel.M,
                            roundEdges: true,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox to add some spacing
                    const SizedBox(
                      height: AppTheme.cardPadding,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add an icon to copy the wallet address to the clipboard
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: userWallet.walletAddress));
                  // Display a snackbar to indicate that the wallet address has been copied
                  displaySnackbar(
                      context, "Wallet-Adresse in Zwischenablage kopiert");
                },
                child: Icon(
                  Icons.copy_rounded,
                  size: 18,
                  color: AppTheme.white60,
                ),
              ),
              const SizedBox(
                width: AppTheme.elementSpacing * 0.25,
              ),
              // Display the user's wallet address
              Text(
                "${userWallet.walletAddress}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          // Add some space between the rows
          const SizedBox(
            height: AppTheme.cardPadding * 1.5,
          ),
          !createdInvoice
              ? Row(
                  children: [
                    Expanded(child: MyDivider()),
                    SizedBox(
                      width: AppTheme.elementSpacing / 2,
                    ),
                    LongButtonWidget(
                      customHeight: AppTheme.cardPadding * 2,
                      customWidth: AppTheme.cardPadding * 8,
                      buttonType: ButtonType.transparent,
                      title: "Create invoice",
                      leadingIcon: Icon(
                        FontAwesomeIcons.getPocket,
                        size: AppTheme.cardPadding,
                        color: AppTheme.white90,
                      ),
                      onTap: () {
                        // Share the wallet address
                        print("bottom sheet der invoice createn lässt...");
                        //createdInvoice = true;
                        showModalBottomSheet(
                          //height: MediaQuery.of(context).size.height * 0.8,
                          context: context,
                          builder: (context) => CreateInvoice(),
                        );
                      },
                    ),
                    SizedBox(
                      width: AppTheme.elementSpacing / 2,
                    ),
                    Expanded(child: MyDivider()),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Add a button to copy the wallet address to the clipboard
                    LongButtonWidget(
                      customHeight: AppTheme.cardPadding * 2,
                      customWidth: AppTheme.cardPadding * 6,
                      buttonType: ButtonType.transparent,
                      title: "Teilen",
                      leadingIcon: Icon(
                        Icons.share_rounded,
                        size: AppTheme.cardPadding,
                        color: AppTheme.white90,
                      ),
                      onTap: () {
                        // Share the wallet address
                        Share.share('${userWallet.walletAddress}');
                      },
                    ),
                    // Add a button to share the wallet address
                  ],
                ),
        ],
      ),
    );
  }
}
