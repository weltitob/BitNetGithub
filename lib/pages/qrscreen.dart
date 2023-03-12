import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nexus_wallet/components/camera/qrscanneroverlay.dart';
import 'package:nexus_wallet/components/buttons/roundedbutton.dart';
import 'package:nexus_wallet/components/camera/textscanneroverlay.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRScreen extends StatefulWidget {
  final bool isBottomButtonVisible;

  const QRScreen({
    Key? key,
    required this.isBottomButtonVisible,
  }) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  @override
  MobileScannerController cameraController = MobileScannerController();
  bool isQRScanner = true;

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
          isQRScanner ? QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)) :
              TextScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 80,
          left: AppTheme.cardPadding,
          bottom: 40,
          right: AppTheme.cardPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
                child: ClipRRect(
                  borderRadius: AppTheme.cardRadiusSmall,
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: AppTheme.cardRadiusSmall,
                          color: AppTheme.glassMorphColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              child: ValueListenableBuilder(
                                valueListenable:
                                    cameraController.cameraFacingState,
                                builder: (context, state, child) {
                                  switch (state as CameraFacing) {
                                    case CameraFacing.front:
                                      return const Icon(Icons.camera_front);
                                    case CameraFacing.back:
                                      return const Icon(Icons.camera_rear);
                                  }
                                },
                              ),
                              onTap: () => cameraController.switchCamera(),
                            ),
                            const SizedBox(
                              height: AppTheme.cardPadding * 0.75,
                            ),
                            GestureDetector(
                              child: ValueListenableBuilder(
                                valueListenable: cameraController.torchState,
                                builder: (context, state, child) {
                                  switch (state as TorchState) {
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
                              onTap: () => cameraController.toggleTorch(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: widget.isBottomButtonVisible,
                child: RoundedButtonWidget(
                  iconData: Icons.arrow_back_rounded,
                  onTap: () => Navigator.pop(context),
                  isGlassmorph: true,
                ),
              ),
              const SizedBox(
                width: AppTheme.cardPadding,
              ),
              Container(
                width: AppTheme.cardPadding * 3.5,
                height: AppTheme.cardPadding * 3.5,
                decoration: BoxDecoration(
                    borderRadius: AppTheme.cardRadiusBigger,
                    border: Border.all(width: 5, color: AppTheme.white90)),
              ),
              const SizedBox(
                width: AppTheme.cardPadding,
              ),
              Visibility(
                visible: widget.isBottomButtonVisible,
                child: RoundedButtonWidget(
                  iconData: Icons.text_fields_rounded,
                  onTap: () => setState(() {}),
                  isGlassmorph: true,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
