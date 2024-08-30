import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/camera/textscanneroverlay.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../components/appstandards/BitNetAppBar.dart';
import '../../components/appstandards/BitNetScaffold.dart';

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
            text: L10n.of(context)!.qrCode,
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
                : TextScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.cardPadding * 8),
                child: GlassContainer(
                  width: AppTheme.cardPadding * 6.5.w,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 1.5, vertical: AppTheme.elementSpacing / 1.25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: controller.cameraController.facing == CameraFacing.front
                              ? const Icon(Icons.camera_front)
                              : const Icon(Icons.camera_rear),
                          onTap: () => controller.cameraController.switchCamera(),
                        ),
                        GestureDetector(
                          child: !controller.cameraController.torchEnabled
                              ? Icon(
                                  Icons.flash_off,
                                  color: Theme.of(context).brightness == Brightness.light ? AppTheme.black90 : AppTheme.white90,
                                )
                              : Icon(
                                  Icons.flash_on,
                                  color: Theme.of(context).brightness == Brightness.light ? AppTheme.black90 : AppTheme.white90,
                                ),
                          onTap: () => controller.cameraController.toggleTorch(),
                        ),
                        GestureDetector(
                            onTap: () async {
                              final PermissionState ps = await PhotoManager.requestPermissionExtend();
                              if (ps.isAuth || ps.hasAccess) {
                                ImagePickerBottomSheet(context, onImageTap: (album, img) async {
                                  String? fileUrl = (await img.loadFile())!.path;
                                  String? fileDir = (await img.loadFile())!.parent.uri.toFilePath();
                                  BarcodeCapture? capture = await controller.cameraController.analyzeImage(fileUrl);
                                  if (capture != null) {
                                    List<Barcode> codes = capture.barcodes;
                                    for (Barcode code in codes) {
                                      debugPrint('Barcode found! ${code.rawValue}');
                                      context.pop();
                                      controller.onQRCodeScanned(code.rawValue!, context);
                                    }
                                  } else {
                                    showOverlay(context, L10n.of(context)!.noCodeFoundOverlayError, color: AppTheme.errorColor);
                                  }
                                });
                              } else {
                                showOverlay(context, L10n.of(context)!.pleaseGiveAccess);
                              }
                            },
                            child: const Icon(Icons.image))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Row(
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
