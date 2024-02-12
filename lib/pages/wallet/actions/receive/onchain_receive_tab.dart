import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matrix/matrix.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class OnChainReceiveTab extends StatefulWidget {
  const OnChainReceiveTab({super.key});

  @override
  State<OnChainReceiveTab> createState() => _OnChainReceiveTabState();
}

class _OnChainReceiveTabState extends State<OnChainReceiveTab> {
  // Get the current user's wallet from a provider
  //final userWallet = Provider.of<UserWallet>(context);
  final userWallet = UserWallet(walletAddress: "fakewallet",
      walletType: "walletType", walletBalance: "0", privateKey: "privateKey", userdid: "userdid");

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
                "On-Chain Bitcoinaddress",
                style: Theme.of(context).textTheme.headline5,
              ),
              RoundedButtonWidget(
                  size: AppTheme.cardPadding * 1.5,
                  buttonType: ButtonType.transparent,
                  iconData: FontAwesomeIcons.refresh, onTap: (){
                Logs().w("Refresh button pressed: New Bitcoin Adress should be generated // not implemented yet");
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
                          padding: const EdgeInsets.all(AppTheme.cardPadding / 2),
                          // The Qr code is generated using the pretty_qr package with an image, size, and error correction level
                          child: PrettyQr(
                            image: const AssetImage(
                                'assets/images/bitcoin.png'),
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
                      height: AppTheme.cardPadding * 1.5,
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
            height: AppTheme.cardPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Add a button to copy the wallet address to the clipboard
              LongButtonWidget(
                customHeight: AppTheme.cardPadding * 2,
                customWidth: AppTheme.cardPadding * 6,
                buttonType: ButtonType.transparent,
                title: "Kopieren",
                leadingIcon: Icon(
                  Icons.copy_rounded,
                  size: AppTheme.cardPadding,
                  color: AppTheme.white90,
                ),
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: userWallet.walletAddress));
                  // Display a snackbar to indicate that the wallet address has been copied
                  displaySnackbar(
                      context, "Wallet-Adresse in Zwischenablage kopiert");
                },
              ),
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
          // Add some space between the rows
          const SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
        ],
      ),
    );
  }
}
