import 'dart:async';

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
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ReceiveType {
  Lightning,
  OnChain,
}

class ReceiveController extends BaseController {
  RxBool isUnlocked = true.obs; // Added here

  RxString qrCodeDataStringLightning = "".obs;
  RxString qrCodeDataStringOnchain = "".obs;
  Rx<BitcoinUnits> bitcoinUnit = BitcoinUnits.SAT.obs;
  Rx<ReceiveType> receiveType = ReceiveType.Lightning.obs;
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
    bitcoinUnit == BitcoinUnits.SAT
        ? amount = amount
        : amount =
            CurrencyConverter.convertBitcoinToSats(amount.toDouble()).toInt();
    List<String> addresses =
        await Get.find<WalletsController>().getOnchainAddresses();
    RestResponse callback = await addInvoice(amount, memo ?? "", addresses[0]);
    print("Response" + callback.data.toString());
    InvoiceModel invoiceModel = InvoiceModel.fromJson(callback.data);
    print("Invoice" + invoiceModel.payment_request.toString());
    qrCodeDataStringLightning.value = invoiceModel.payment_request.toString();
  }

  void getBtcAddress() async {
    String addr = await nextAddr(Auth().currentUser!.uid);
    print("Response" + addr);
    BitcoinAddress address = BitcoinAddress.fromJson({'addr': addr});
    Get.find<WalletsController>().btcAddresses.add(address.addr);
    LocalStorage.instance.setStringList(
        Get.find<WalletsController>().btcAddresses,
        "btc_addresses:${FirebaseAuth.instance.currentUser!.uid}");
    print("Bitcoin onchain Address" + address.addr.toString());
    qrCodeDataStringOnchain.value = address.addr.toString();
  }

  void switchReceiveType() {
    // setState(() {
    switch (receiveType.value) {
      case ReceiveType.Lightning:
        receiveType.value = ReceiveType.OnChain;
      case ReceiveType.OnChain:
        receiveType.value = ReceiveType.Lightning;
    }
    // });
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
