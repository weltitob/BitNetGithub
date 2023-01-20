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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.copy_rounded,
                              size: 18,
                              color: AppTheme.white60,
                            ),
                            const SizedBox(
                              width: AppTheme.elementSpacing * 0.25,),
                            Text(
                              "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: AppTheme.cardPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            glassButton("Copy", Icons.copy_rounded, () => null),
                            glassButton(
                                "Share", Icons.share_rounded, () => null),
                            glassButton("Keys", Icons.key_rounded, () => null)
                          ],
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

  Widget glassButton(String text, IconData iconData, Function() function) {
    return Glassmorphism(
      blur: 20,
      opacity: 0.1,
      radius: 50.0,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft),
        onPressed: () {
          // handle push to HomeScreen
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppTheme.elementSpacing * 0.5,
            horizontal: AppTheme.elementSpacing,
          ),
          child: Row(
            children: [
              Icon(iconData, color: AppTheme.white80, size: 22,),
              const SizedBox(width: AppTheme.elementSpacing / 2,),
              Text(
                text,
                style:
                AppTheme.textTheme.caption!.copyWith
                  (color: AppTheme.white80, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}