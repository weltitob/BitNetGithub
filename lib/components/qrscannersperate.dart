import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nexus_wallet/components/cameraqr.dart';
import 'package:nexus_wallet/components/roundedbutton.dart';
import 'package:nexus_wallet/theme.dart';


class QRCodeScannerSeperate extends StatefulWidget {
  const QRCodeScannerSeperate({Key? key}) : super(key: key);

  @override
  State<QRCodeScannerSeperate> createState() => _QRCodeScannerSeperateState();
}

class _QRCodeScannerSeperateState extends State<QRCodeScannerSeperate> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) {
                final String? code = barcode.rawValue;
                debugPrint('Barcode found! $code');
              }),
          const QRScannerOverlay(overlayColour: AppTheme.colorBackground),
        ],
      ),
    );
  }
}



