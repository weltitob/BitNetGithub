import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/url_launcher.dart';
import 'package:bitnet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/qr_codes/qr_bitcoinadress.dart';
import 'package:bitnet/pages/qrscanner/qrscanner_view.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vrouter/vrouter.dart';

enum QRTyped {
  LightningMail,
  Invoice,
  OnChain,
  Profile,
  RestoreLogin,
  Unknown,
}

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

  QRTyped determineQRType(dynamic encodedString) {

    final isLightningMailValid = isLightningAdressAsMail(encodedString);
    final isStringInvoice = isStringALNInvoice(encodedString);
    final isBitcoinValid = isBitcoinWalletValid(encodedString);

    Logs().w("Determining the QR type...");
    // Logic to determine the QR type based on the encoded string
    // Return the appropriate QRTyped enum value
    return QRTyped.Invoice;
  }


  void onQRCodeScanned(dynamic encodedString) {
    // Logic to determine the type of QR code
    QRTyped type = determineQRType(encodedString);

    switch (type) {
      case QRTyped.LightningMail:
      // Handle LightningMail QR code
        break;
      case QRTyped.OnChain:
      // Handle OnChain QR code
        break;
      case QRTyped.Invoice:
        Logs().w("Invoice was detected will forward to Send screen...");
        //have to parse or give the page everything I know about the invoice
        try {
          VRouter.of(context).to("/wallet/send?invoice=$encodedString");
          //VRouter.of(context).to("/wallet/receive");
        } catch (e) {
          Logs().e("Failed forwarding with error: $e");
        }
        break;
      case QRTyped.Profile:
      // Handle Profile QR code
        break;
      case QRTyped.RestoreLogin:
      // Handle LightningMail QR code
        break;
      case QRTyped.Unknown:
      // Handle LightningMail QR code
        break;
      default:
      // Handle unknown QR code
    }
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
      VRouter.of(context).to("/wallet/send");
    } else {
      displaySnackbar(context, "Der eingescannte QR-Code hat kein zugelassenes Format");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QRScannerView(controller: this);
  }
}
