import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitnet/components/buttons/glassbutton.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

// This class is a StatefulWidget which displays a screen where a user can receive bitcoin
class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  // A GlobalKey is used to identify this widget in the widget tree, used to access and modify its properties
  GlobalKey globalKeyQR = GlobalKey();

  // This method builds the UI for the ReceiveScreen
  @override
  Widget build(BuildContext context) {
    // Get the current user's wallet from a provider
    //final userWallet = Provider.of<UserWallet>(context);
    final userWallet = UserWallet(walletAddress: "fakewallet",
        walletType: "walletType", walletBalance: "0", privateKey: "privateKey", userdid: "userdid");

    return Scaffold(
      // The screen background color
      backgroundColor: AppTheme.colorBackground,
      appBar: AppBar(
        // The back button on the app bar navigates to the previous screen
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        // The app bar does not have a shadow
        elevation: 0,
        // The app bar's title is "Bitcoin erhalten"
        title: Text("Bitcoin erhalten",
            style: Theme.of(context).textTheme.titleLarge),
        // The app bar's background color is the same as the screen background color
        backgroundColor: AppTheme.colorBackground,
      ),
      // The screen's body
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // The screen background is a gradient
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
              Color(0xFF522F77),
              AppTheme.colorBackground,
                ])),
        // Padding around the screen's contents
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            // The contents of the screen are centered vertically
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text "Meine Bitcoinadresse" displayed with headline5 style
              Text(
                "Meine Bitcoinadresse",
                style: Theme.of(context).textTheme.headline5,
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
                height: AppTheme.cardPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Add a button to copy the wallet address to the clipboard
                  LongButtonWidget(
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
        ),
      ),
    );
  }
}
