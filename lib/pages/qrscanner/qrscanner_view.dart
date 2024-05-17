import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../components/appstandards/BitNetAppBar.dart';
import '../../components/appstandards/BitNetScaffold.dart';

import 'package:flutter/services.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/camera/textscanneroverlay.dart';

class QRScannerView extends StatelessWidget {
  final QRScannerController controller;

  const QRScannerView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // context.pop();
        return true;
      },
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        removeGradientColor: true,
        backgroundColor: Colors.transparent,
        gradientColor: Colors.black,
        appBar: bitnetAppBar(
            text: "Scan QR",
            context: context,
            onTap: () {
              context.pop();
            }),
        body: Stack(
          children: [
            MobileScanner(
              //allowDuplicates: false,
              controller: controller.cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                  //final String code = barcode.rawValue.toString();
                  //var encodedString = jsonDecode(codeinjson);
                  controller.onQRCodeScanned(barcode.rawValue!, context);
                  //check what type we scanned somehow and then call the according functions
                  //controller.onScannedForSignIn(encodedString);
                }
              },
            ),
            controller.isQRScanner
                ? QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
                : TextScannerOverlay(
                    overlayColour: Colors.black.withOpacity(0.5)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.cardPadding * 8),
                child: GlassContainer(
                  width: AppTheme.cardPadding * 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: ValueListenableBuilder(
                            valueListenable: controller
                                .cameraController.cameraFacingState,
                            builder: (context, state, child) {
                              switch (state) {
                                case CameraFacing.front:
                                  return const Icon(
                                      Icons.camera_front);
                                case CameraFacing.back:
                                  return const Icon(
                                      Icons.camera_rear);
                              }
                            },
                          ),
                          onTap: () => controller.cameraController
                              .switchCamera(),
                        ),
                        const SizedBox(
                          height: AppTheme.cardPadding * 0.75,
                        ),
                        GestureDetector(
                          child: ValueListenableBuilder(
                            valueListenable: controller
                                .cameraController.torchState,
                            builder: (context, state, child) {
                              switch (state) {
                                case TorchState.off:
                                  return Icon(
                                    Icons.flash_off,
                                    color: AppTheme.white90,
                                  );
                                case TorchState.on:
                                  return Icon(
                                    Icons.flash_on,
                                    color: AppTheme.white90,
                                  );
                              }
                            },
                          ),
                          onTap: () => controller.cameraController
                              .toggleTorch(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            )
          ],
        ),
        context: context,
      ),
    );
  }
}
