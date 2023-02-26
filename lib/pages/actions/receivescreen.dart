import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/buttons/glassbutton.dart';
import 'package:nexus_wallet/components/cameraqr.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {

  GlobalKey globalKeyQR = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Send Bitcoin", style: Theme.of(context).textTheme.titleLarge),
            Text("BTC available",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
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
                ]
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Bitcoinadress",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5,
              ),
              const SizedBox(
                height: AppTheme.cardPadding * 2,
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
                        .bodyMedium,
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