import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/url_launcher.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/qr_codes/qr_bitcoinadress.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/qrscanner/qrscanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => QRScannerController();
}

class QRScannerController extends State<QrScanner> {

  MobileScannerController cameraController = MobileScannerController();
  bool isQRScanner = true;
  bool isLoading = false;


  void _onQRViewCreatedMatrix(dynamic scanData) async {
    //if matrix shit is scanned
    UrlLauncher(context, scanData.code).openMatrixToUrl();
  }




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

    final currentqr = QR_BitcoinAddress.fromJson(encodedString);

    /// a simple check if its a BTC wallet or not, regardless of its type
    final bool isValid = isBitcoinWalletValid(currentqr.bitcoinAddress);
    print(isValid);

    final walletType = getBitcoinWalletType(currentqr.bitcoinAddress);
    print(walletType);

    final walletdetails = getBitcoinWalletDetails(currentqr.bitcoinAddress);
    print(walletdetails);

    if(isValid){
      VRouter.of(context).to("wallet/send");
    } else {
      displaySnackbar(context, "Der eingescannte QR-Code hat kein zugelassenes Format");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QRScannerView(controller: this);
  }
}
