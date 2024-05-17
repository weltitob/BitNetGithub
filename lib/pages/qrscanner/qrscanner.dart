import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/url_launcher.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/qr_codes/qr_bitcoinadress.dart';
import 'package:bitnet/pages/qrscanner/qrscanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile_scanner/mobile_scanner.dart';


enum QRTyped {
  LightningMail,
  LightningUrl,
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
    print("isLightingMailValid: $isLightningMailValid");
    final isStringInvoice = isStringALNInvoice(encodedString);
    print("isStringInvoice: $isStringInvoice");
    final isBitcoinValid = isBitcoinWalletValid(encodedString);
    print("isBitcoinValid: $isBitcoinValid");
   
    late QRTyped qrTyped;

    Logs().w("Determining the QR type...");
    // Logic to determine the QR type based on the encoded string
    // Return the appropriate QRTyped enum value
    if(isLightningMailValid){
      qrTyped = QRTyped.LightningMail;
    }
    
    else if (isStringInvoice){
      qrTyped = QRTyped.Invoice;
    }
    else if (isBitcoinValid){
      qrTyped = QRTyped.OnChain;
    }
    else{
      qrTyped = QRTyped.Unknown;
    }
    return qrTyped;
  }


  void onQRCodeScanned(dynamic encodedString, BuildContext cxt) {
    // Logic to determine the type of QR code
    QRTyped type = determineQRType(encodedString);

    switch (type) {
      case QRTyped.LightningMail:
      // Handle LightningMail QR code
        break;
      case QRTyped.OnChain:
       // Navigator.push(cxt, MaterialPageRoute(builder: (context)=>Send()));
        //cxt.go("/wallet/send?walletAdress=$encodedString");
        context.pop(encodedString);
        break;
      case QRTyped.Invoice:
        print("INVIUCE DETECTED!");
        Logs().w("Invoice was detected will forward to Send screen...");
        Logs().w(GoRouter.of(cxt).routerDelegate.currentConfiguration.fullPath);
        context.pop(encodedString);
      

        //have to parse or give the page everything I know about the invoice
        try {
          //cxt.go(Uri(path: '/wallet/send', queryParameters: {'invoice': encodedString}).toString());

          //Navigator.pushReplacement(cxt, MaterialPageRoute(builder: (context)=>Send()));
        // cxt.go("/wallet/send");
        } catch (e) {
          Logs().e("Failed forwarding with error: $e");
        }
        break;
      case QRTyped.Profile:
      // Handle Profile QR code
        break;
      case QRTyped.RestoreLogin:
        onScannedForSignIn(encodedString);
      case QRTyped.Unknown:
        //send to unknown qr code page which shows raw data
        //context.go("/error");
        break;
      default:
      // Handle unknown QR code
    }
  }


  void onScannedForSignIn(dynamic encodedString) async {
    try{
      final privateData = PrivateData.fromJson(encodedString);

      final signedMessage = await Auth().signMessageAuth(
          privateData.did,
          privateData.privateKey
      );
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
      context.go("/wallet/send");
    } else {
      showOverlay(context, "Der eingescannte QR-Code hat kein zugelassenes Format");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QRScannerView(controller: this);
  }
}
