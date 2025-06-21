import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/camera/textscanneroverlay.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

    final overlayController = Get.find<OverlayController>();

    return PopScope(
      canPop: true, // Allow normal back navigation
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
              onDetect: (barcode, args) {
                if (barcode.rawValue != null) {
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
                          child: !(controller.cameraController.torchEnabled ?? false)
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
                                ImagePickerCombinedBottomSheet(
                                  context, 
                                  includeNFTs: false,
                                  onImageTap: (album, img, pair) async {
                                    if (img != null) {
                                      String? fileUrl = (await img.loadFile())!.path;
                                      String? fileDir = (await img.loadFile())!.parent.uri.toFilePath();
                                      bool scanSuccess = await controller.cameraController.analyzeImage(fileUrl);
                                      if (scanSuccess) {
                                        // The barcode will be processed by the controller's onDetect callback
                                        debugPrint('Image analyzed successfully');
                                        context.pop();
                                      } else {
                                        overlayController.showOverlay(L10n.of(context)!.noCodeFoundOverlayError, color: AppTheme.errorColor);
                                      }
                                    }
                                  }
                                );
                              } else {
                                overlayController.showOverlay(L10n.of(context)!.pleaseGiveAccess);
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