import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_wallet/components/balancecard.dart';
import 'package:nexus_wallet/components/cameraqr.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/components/qrscanner.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {

  GlobalKey globalKeyQR = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
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
                ]
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.cardPadding * 3,),
              Text(
                "My Bitcoinadress",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
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
                                data: 'test',
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
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              Text(
                "Scan QR-Code",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
              const SizedBox(
                height: AppTheme.elementSpacing * 0.75,
              ),
              Center(
                child: GestureDetector(
                    onTap: () =>
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                            const QRCodeScanner(),
                          ),
                        ),
                    child: avatarGlow(context, Icons.circle, "cam")
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget avatarGlow(BuildContext context, IconData icon, String text) {
    return Center(
      child: AvatarGlow(
        glowColor: darken(Colors.orange, 20),
        endRadius: 60.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 200),
        repeat: true,
        showTwoGlows: true,
        child:
        CustomPaint(
          foregroundPainter: BorderPainterSmall(),
          child: Container(
            margin: const EdgeInsets.all(AppTheme.elementSpacing),
            child: Icon(
              icon,
              size: AppTheme.cardPadding * 1.5,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}