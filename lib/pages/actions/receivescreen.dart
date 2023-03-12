import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexus_wallet/components/buttons/glassbutton.dart';
import 'package:nexus_wallet/components/camera/qrscanneroverlay.dart';
import 'package:nexus_wallet/components/snackbar/snackbar.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  GlobalKey globalKeyQR = GlobalKey();
  final String _walletAdress = "1Lbcfr7sAHTD9CgdQo3HTMTkV8LK4ZnX71";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        elevation: 0,
        title: Text("Bitcoin erhalten",
            style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: AppTheme.colorBackground,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
              Color(0xFF522F77),
              AppTheme.colorBackground,
            ])),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Meine Bitcoinadresse",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: AppTheme.cardPadding * 3,
              ),
              SizedBox(
                child: Center(
                  child: RepaintBoundary(
                    key: globalKeyQR,
                    child: Column(
                      children: [
                        CustomPaint(
                          foregroundPainter: BorderPainter(),
                          child: Container(
                            margin: const EdgeInsets.all(AppTheme.cardPadding),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: AppTheme.cardRadiusSmall),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: PrettyQr(
                                image: const AssetImage(
                                    'assets/images/bitcoin.png'),
                                typeNumber: 3,
                                size: 200,
                                data: _walletAdress,
                                errorCorrectLevel: QrErrorCorrectLevel.M,
                                roundEdges: true,
                              ),
                            ),
                          ),
                        ),
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
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: _walletAdress));
                      // copied successfully
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
                  Text(
                    "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  glassButton(
                    text: "Kopieren",
                    iconData: Icons.copy_rounded,
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: _walletAdress));
                      // copied successfully
                      displaySnackbar(
                          context, "Wallet-Adresse in Zwischenablage kopiert");
                    },
                  ),
                  glassButton(
                    text: "Teilen",
                    iconData: Icons.share_rounded,
                    onTap: () {
                      Share.share('$_walletAdress');
                    },
                  ),
                ],
              ),
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
