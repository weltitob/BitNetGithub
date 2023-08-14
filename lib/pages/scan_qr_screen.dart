import 'dart:convert';
import 'dart:ui';

import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/auth/storePrivateData.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/models/keys/privatedata.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:BitNet/pages/profile/actions/sendscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:BitNet/components/camera/qrscanneroverlay.dart';
import 'package:BitNet/components/camera/textscanneroverlay.dart';
import 'package:BitNet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:BitNet/models/qr_codes/qr_bitcoinadress.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
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

  MobileScannerController cameraController = MobileScannerController();
  bool isQRScanner = true;
  bool isLoading = false;

  //so unterscheiden was es ist:
  //bitcoin: >> Transaktion
  //did: >> Nutzerprofil teilen
  //mnemonic: >> Den privatekey teilen
  //invoice: ... usw (da halt standards folgen)

  void onScannedForSignIn(dynamic encodedString) async {
    try{
      //Auth().signOut();

      final privateData = PrivateData.fromJson(encodedString);

      final signedMessage = await Auth().signMessageAuth(
          privateData.did,
          privateData.privateKey
      );
      //login

      // Call the function to store Private data in secure storage
      await storePrivateData(privateData);

      await Auth().signIn(
          privateData.did,
          signedMessage,
          context
      );

      setState(() {});
    } catch(e){
      print("onScannedForSignIn: $e");
    }
  }

  void onScannedForSendingBitcoin(dynamic encodedString) async {

    final userData = Provider.of<UserData>(context);

    final currentqr = QR_BitcoinAddress.fromJson(encodedString);

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
                //check what type we scanned somehow and then call the according functions

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
