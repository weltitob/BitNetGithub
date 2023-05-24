import 'dart:convert';
import 'dart:ui';

import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/qr_codes/qr_privatekey.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:BitNet/components/camera/qrscanneroverlay.dart';
import 'package:BitNet/components/camera/textscanneroverlay.dart';
import 'package:BitNet/components/dialogsandsheets/snackbar.dart';
import 'package:BitNet/models/qr_codes/qr_bitcoinadress.dart';
import 'package:BitNet/backbone/helper/theme.dart';

class QROtherDeviceScreen extends StatefulWidget {
  final bool isBottomButtonVisible;

  const QROtherDeviceScreen({
    Key? key,
    required this.isBottomButtonVisible,
  }) : super(key: key);

  @override
  State<QROtherDeviceScreen> createState() => _QROtherDeviceScreenState();
}

class _QROtherDeviceScreenState extends State<QROtherDeviceScreen> {
  @override
  MobileScannerController cameraController = MobileScannerController();
  bool isQRScanner = true;

  void onScannedForSignIn(dynamic encodedString) async {
    try{
      Auth().signOut();
    } catch(e){
      print("onScannedForSignIn: $e");
    }
    final privateData = QR_PrivateKey.fromJson(encodedString);
    final signedMessage = await Auth().signMessageAuth(
        privateData.did,
        privateData.privateKey
    );
    //login
    await Auth().signIn(
      privateData.did,
      signedMessage
    );
  }

  @override
  Widget build(BuildContext context) {
    return BitNetScaffold(
      backgroundColor: Colors.transparent,
      gradientColor: Colors.black,
      appBar: BitNetAppBar(
          text: "Scan QR",
          context: context,
          onTap: (){
            Navigator.of(context).pop();
          }),
      body: Stack(
        children: [
          MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) async {
                final String codeinjson = barcode.rawValue.toString();
                var encodedString = jsonDecode(codeinjson);
                onScannedForSignIn(encodedString);
              }),
          isQRScanner
              ? QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
              : TextScannerOverlay(
              overlayColour: Colors.black.withOpacity(0.5)),
          buildButtons(),
        ],
      ), context: context,
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
            ],
          )
        ],
      ),
    );
  }
}
