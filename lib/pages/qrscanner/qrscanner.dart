import 'dart:convert';

import 'package:bip39/bip39.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/qr_codes/qr_bitcoinadress.dart';
import 'package:bitnet/pages/qrscanner/qrscanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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

  QRTyped determineQRType(dynamic encodedString) {
    LoggerService logger = Get.find();
    final isLightningMailValid = isLightningAdressAsMail(encodedString);
    print("isLightingMailValid: $isLightningMailValid");
    final isStringInvoice = isStringALNInvoice(encodedString);
    print("isStringInvoice: $isStringInvoice");
    final isBitcoinValid = isBitcoinWalletValid(encodedString);
    print("isBitcoinValid: $isBitcoinValid");
    final isStringPrivateData = isStringPrivateDataFunc(encodedString);
    print("isStringPrivateData: $isStringPrivateData");

    late QRTyped qrTyped;

    logger.i("Determining the QR type...");
    // Logic to determine the QR type based on the encoded string
    // Return the appropriate QRTyped enum value
    if (isLightningMailValid) {
      qrTyped = QRTyped.LightningMail;
    } else if (isStringPrivateData) {
      qrTyped = QRTyped.RestoreLogin;
    } else if (isStringInvoice) {
      qrTyped = QRTyped.Invoice;
    } else if (isBitcoinValid) {
      qrTyped = QRTyped.OnChain;
    } else {
      qrTyped = QRTyped.Unknown;
    }
    return qrTyped;
  }

  void onQRCodeScanned(dynamic encodedString, BuildContext cxt) {
    LoggerService logger = Get.find();
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
        context.pop(encodedString);

        try {} catch (e) {
          logger.e("Failed forwarding with error: $e");
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
    try {
      Map<String, dynamic> data = {};
      if (validateMnemonic(encodedString)) {
        data = {'mnemonic': encodedString};
      } else {
        data = jsonDecode(encodedString);
      }

      final privateData = PrivateData.fromJson(data);
      HDWallet hdWallet = HDWallet.fromMnemonic(privateData.mnemonic);
      print("onScannedForSignIn: $privateData");
      print("onScannedForSignIn: ${hdWallet.pubkey}");
      print("onScannedForSignIn: ${hdWallet.privkey}");

      //generate based on mnemonix the privatekeyhex the did and...#

      //generate the signature

      //call auth sign in

      final logger = Get.find<LoggerService>();

      String challengeData = "QRCode Login Challenge";

      String signatureHex = await signChallengeData(
          hdWallet.privkey, hdWallet.pubkey, challengeData);

      logger.d('Generated signature hex: $signatureHex');

      await Auth().signIn(
          ChallengeType.qrcode_login, privateData, signatureHex, context);

      setState(() {});
    } catch (e) {
      print("onScannedForSignIn: $e");
    }
  }

  void onScannedForSendingBitcoin(dynamic encodedString) async {
    final overlayController = Get.find<OverlayController>();
    final currentqr = QR_BitcoinAddress.fromJson(encodedString);

    /// a simple check if its a BTC wallet or not, regardless of its type
    final bool isValid = isBitcoinWalletValid(currentqr.bitcoinAddress);
    // print(isValid);

    // final walletType = getBitcoinWalletType(currentqr.bitcoinAddress);
    // print(walletType);

    // final walletdetails = getBitcoinWalletDetails(currentqr.bitcoinAddress);
    // print(walletdetails);

    if (isValid) {
      context.go("/wallet/send");
    } else {
      overlayController.showOverlay(L10n.of(context)!.qrCodeFormatInvalid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return QRScannerView(controller: this);
  }
}
