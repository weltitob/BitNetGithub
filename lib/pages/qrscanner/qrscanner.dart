import 'dart:convert';

import 'package:bip39/bip39.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/lnurl_channel_service.dart';
import 'package:bitnet/components/dialogsandsheets/channel_opening_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/qr_codes/qr_bitcoinadress.dart';
import 'package:bitnet/pages/qrscanner/qrscanner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:bitnet/intl/generated/l10n.dart';

enum QRTyped {
  LightningMail,
  LightningUrl,
  Invoice,
  OnChain,
  Profile,
  RestoreLogin,
  BIP21WithBolt11,
  LightningChannel,
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

    final isBip21Bolt11 = isBip21WithBolt11(encodedString);
    final isLightningMailValid = isLightningAdressAsMail(encodedString);
    final isStringInvoice = isStringALNInvoice(encodedString);
    final isBitcoinValid = isBitcoinWalletValid(encodedString);
    final isStringPrivateData = isStringPrivateDataFunc(encodedString);

    // Check for LNURL Channel request
    final isLnurlChannel = _isLnurlChannelRequest(encodedString);

    logger.i("Determining the QR type...");

    // Existing checks
    if (isBip21Bolt11) {
      return QRTyped.BIP21WithBolt11;
    } else if (isLightningMailValid) {
      return QRTyped.LightningMail;
    } else if (isStringPrivateData) {
      return QRTyped.RestoreLogin;
    } else if (isStringInvoice) {
      return QRTyped.Invoice;
    } else if (isBitcoinValid) {
      return QRTyped.OnChain;
    } else if (isLnurlChannel) {
      return QRTyped.LightningChannel;
    } else {
      return QRTyped.Unknown;
    }
  }

  bool _isLnurlChannelRequest(String encodedString) {
    try {
      // Check if it's an LNURL format (starts with lnurl)
      if (!encodedString.toLowerCase().startsWith('lnurl')) {
        return false;
      }

      // Use the service to check if it's a channel request
      final channelService = LnurlChannelService();
      return channelService.isChannelRequest(encodedString);
    } catch (e) {
      return false;
    }
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
        break;
      case QRTyped.LightningChannel:
        _handleChannelRequest(encodedString, cxt);
        break;
      case QRTyped.Unknown:
        //send to unknown qr code page which shows raw data
        //context.go("/error");
        break;
      default:
      // Handle unknown QR code
    }
  }

  void _handleChannelRequest(String lnurlString, BuildContext cxt) async {
    final logger = Get.find<LoggerService>();
    logger.i("Handling LNURL Channel request: $lnurlString");

    try {
      // Close the QR scanner
      context.pop();

      // Show channel opening bottom sheet
      await _showChannelOpeningSheet(cxt, lnurlString);
    } catch (e) {
      logger.e("Error handling channel request: $e");
      final overlayController = Get.find<OverlayController>();
      overlayController.showOverlay("Error processing channel request: $e");
    }
  }

  Future<void> _showChannelOpeningSheet(
      BuildContext context, String lnurlString) async {
    await context.showChannelOpeningSheet(
      lnurlString,
      onChannelOpened: () {
        final overlayController = Get.find<OverlayController>();
        overlayController.showOverlay("Lightning channel opened successfully!");
      },
    );
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
      // OLD: Multiple users one node approach - HDWallet-based key derivation
      // HDWallet hdWallet = HDWallet.fromMnemonic(privateData.mnemonic);
      // print("onScannedForSignIn: ${hdWallet.pubkey}");
      // print("onScannedForSignIn: ${hdWallet.privkey}");

      // NEW: One user one node approach - Lightning aezeed format
      String did = RecoveryIdentity.generateRecoveryDid(privateData.mnemonic);
      print("onScannedForSignIn: $privateData");
      print("onScannedForSignIn DID: $did");

      //generate based on mnemonix the privatekeyhex the did and...#

      //generate the signature

      //call auth sign in

      final logger = Get.find<LoggerService>();

      String challengeData = "QRCode Login Challenge";

      // OLD: Multiple users one node approach - HDWallet key signing
      // String signatureHex = await signChallengeData(hdWallet.privkey, hdWallet.pubkey, challengeData);

      // NEW: Lightning approach - Signing functionality needs reimplementation for Lightning
      // TODO: Implement Lightning-based challenge signing when needed
      String signatureHex = "placeholder_signature"; // Temporary placeholder

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
