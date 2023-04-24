import 'dart:convert';
import 'dart:ui';

import 'package:BitNet/models/userdata.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:BitNet/components/camera/qrscanneroverlay.dart';
import 'package:BitNet/components/buttons/roundedbutton.dart';
import 'package:BitNet/components/camera/textscanneroverlay.dart';
import 'package:BitNet/components/dialogsandsheets/snackbar.dart';
import 'package:BitNet/models/qrcodebitcoin.dart';
import 'package:BitNet/models/userwallet.dart';
import 'package:BitNet/pages/actions/sendscreen.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';

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
    final userData = Provider.of<UserData>(context);

    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
              allowDuplicates: false,
              controller: cameraController,
              onDetect: (barcode, args) async {
                final String codeinjson = barcode.rawValue.toString();
                var encodedString = jsonDecode(codeinjson);
                final currentqr = QRCodeBitcoin.fromJson(encodedString);

                /// a simple check if its a BTC wallet or not, regardless of its type
                final bool isValid = isBitcoinWalletValid(currentqr.bitcoinAddress);
                print(isValid);

                /// a bit more complicated check which can return the type of
                /// BTC wallet and return SegWit (Bech32), Regular, or None if
                /// the string is not a BTC address
                final walletType = getBitcoinWalletType(currentqr.bitcoinAddress);
                print(walletType);

                /// Detailed check, for those who need to get more details
                /// of the wallet. Returns the address type, the network, and
                /// the wallet type along with its address.
                /// It always returns BitcoinWalletDetails object. To check if it's
                /// valid or not use bitcoinWalletDetails.isValid getter
                /// IMPORTANT The BitcoinWalletDetails class overrides an
                /// equality operators so two BitcoinWalletDetails objects can be
                /// compared simply like this bwd1 == bwd2
                final walletdetails = getBitcoinWalletDetails(currentqr.bitcoinAddress);
                print(walletdetails);

                if(isValid){
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SendBTCScreen(
                          bitcoinReceiverAdress: currentqr.bitcoinAddress,
                          bitcoinSenderAdress: userData.mainWallet.walletAddress,),
                  ));
                } else {
                  print("Error beim einscannen des QR Codes");
                  displaySnackbar(context, "Der eingescannte QR-Code hat kein zugelassenes Format");
                }
              }),
          isQRScanner
              ? QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
              : TextScannerOverlay(
                  overlayColour: Colors.black.withOpacity(0.5)),
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
