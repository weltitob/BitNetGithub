import 'dart:async';
import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/add_invoice.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/models/bitcoin/lnd/invoice_model.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum ReceiveType {
  Combined_b11_taproot,
  Lightning_b11,
  Lightning_lnurl,
  OnChain_taproot,
  OnChain_segwit,
  TokenTaprootAsset,
}

class ReceiveController extends BaseController {
  ValueNotifier<String> btcControllerNotifier = ValueNotifier('');
  RxBool isUnlocked = true.obs; // Added here

  RxString qrCodeDataStringLightning = "".obs;
  RxString qrCodeDataStringOnchain = "".obs;
  Rx<BitcoinUnits> bitcoinUnit = BitcoinUnits.SAT.obs;

  Rx<ReceiveType> receiveType = ReceiveType.Combined_b11_taproot.obs;

  //ReceiveState receiveState = ReceiveState(0);
  RxBool updatingText = false.obs;
  FocusNode myFocusNode = FocusNode();

  TextEditingController satController = TextEditingController(text: '0');
  TextEditingController btcController = TextEditingController(text: '0');

  TextEditingController satControllerOnChain = TextEditingController(text: '0');
  TextEditingController btcControllerOnChain = TextEditingController(text: '0');

  late TextEditingController currController;
  TextEditingController messageController = TextEditingController();
  late Duration duration;
  late Timer timer;
  RxString min = ''.obs;
  RxString sec = ''.obs;
  RxBool createdInvoice = false.obs;
  final userWallet = UserWallet(
      walletAddress: "publickeyforkeysend",
      walletType: "walletType",
      walletBalance: "0",
      privateKey: "privateKey",
      userdid: "userdid");

  // A GlobalKey is used to identify this widget in the widget tree, used to access and modify its properties
  GlobalKey globalKeyQR = GlobalKey();

  void updateTimer(Timer timer) {
    if (duration.inSeconds > 0) {
      duration = duration - const Duration(seconds: 1);
      min.value = (duration.inMinutes % 60).toString().padLeft(2, '0');
      sec.value = (duration.inSeconds % 60).toString().padLeft(2, '0');
      print(duration);
    } else {
      timer.cancel();
    }
  }

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void updateBtcText(String value) {
    logger.i("Updating btcController.text to: $value");
    btcController.text = value;
  }

  void getInvoice(int amount, String? memo) async {
    logger.i("Getting invoice: $amount");
    bitcoinUnit == BitcoinUnits.SAT
        ? amount = amount
        : amount =
            CurrencyConverter.convertBitcoinToSats(amount.toDouble()).toInt();
    try{
      List<String> addresses = await Get.find<WalletsController>().getOnchainAddresses();
      final btcAddress = addresses[0];
      logger.i("BTC Address: $btcAddress");

      final preimage = generatePreimage();
      RestResponse callback = await addInvoice(amount, memo ?? "", btcAddress, preimage);
      logger.i("Response addInvoice" + callback.data.toString());
      InvoiceModel invoiceModel = InvoiceModel.fromJson(callback.data);
      logger.i("Invoice: " + invoiceModel.payment_request.toString());
      qrCodeDataStringLightning.value = invoiceModel.payment_request.toString();

      try {
        // Update Firebase with new invoice
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final userId = currentUser.uid;

          // Reference to the "allInvoices" collection
          final invoiceRef = FirebaseFirestore.instance
              .collection("allInvoices")
              .doc(invoiceModel.payment_request.toString());

          // Example data to store
          final base64preimage = base64Encode(preimage);
          logger.i("Base64 preimage for firebase...: $base64preimage");

          final data = {
            "userId": userId,
            "preimage": base64preimage,
            "fallbackAddress": btcAddress,
            "createdAt": FieldValue.serverTimestamp(),
            "invoice": invoiceModel.toMap(),
          };

          // Set or update the document
          await invoiceRef.set(data, SetOptions(merge: true));
          logger.i("Invoice saved to Firestore with ID: ${invoiceModel
              .payment_request}");
        }
      } catch (e){
        logger.e("Error saving invoice to Firestore: $e");
      }

    } catch(e){
      logger.e("Error getting invoice: $e");
    }
  }

  void getBtcAddress() async {
    logger.i("Getting BTC Address");
    String addr = await nextAddr(Auth().currentUser!.uid);
    BitcoinAddress address = BitcoinAddress.fromJson({'addr': addr});
    Get.find<WalletsController>().btcAddresses.add(address.addr);
    LocalStorage.instance.setStringList(
        Get.find<WalletsController>().btcAddresses,
        "btc_addresses:${FirebaseAuth.instance.currentUser!.uid}");
    logger.i("Bitcoin onchain Address" + address.addr.toString());
    qrCodeDataStringOnchain.value = address.addr.toString();
  }

  // /// Sets the receive type explicitly to the provided type.
  setReceiveType(ReceiveType type) {
    receiveType.value = type;
    logger.i("Set new receive type: $type");
  }


  @override
  void onInit() {
    super.onInit();
    duration = const Duration(seconds: 0);
    //ONCHAIN
  }

  @override
  void dispose() {
    super.dispose();
  }
}
