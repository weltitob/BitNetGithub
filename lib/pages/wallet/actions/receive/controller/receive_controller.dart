import 'dart:async';

import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/add_invoice.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/models/bitcoin/lnd/invoice_model.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ReceiveType {
  Lightning,
  OnChain,
}

class ReceiveController extends BaseController {
  RxString qrCodeDataStringLightning = "".obs;
  RxString qrCodeDataStringOnchain = "".obs;
  Rx<BitcoinUnits> bitcoinUnit = BitcoinUnits.SAT.obs;
  Rx<ReceiveType> receiveType = ReceiveType.Lightning.obs;
  //ReceiveState receiveState = ReceiveState(0);
  RxBool updatingText = false.obs;
  FocusNode myFocusNode = FocusNode();
  late TextEditingController amountController = TextEditingController();
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
      duration = duration - Duration(seconds: 1);
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

  void getInvoice(int amount, String? memo) async {
    bitcoinUnit == BitcoinUnits.SAT
        ? amount = amount
        : amount =
            CurrencyConverter.convertBitcoinToSats(amount.toDouble()).toInt();
    RestResponse callback = await addInvoice(amount, memo ?? "");
    print("Response" + callback.data.toString());
    InvoiceModel invoiceModel = InvoiceModel.fromJson(callback.data);
    print("Invoice" + invoiceModel.payment_request.toString());
    qrCodeDataStringLightning.value = invoiceModel.payment_request.toString();
  }

  void getTaprootAddress() async {
    RestResponse callback = await nextAddr();
    print("Response" + callback.data.toString());
    BitcoinAddress address = BitcoinAddress.fromJson(callback.data);
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

  void updateAmountDisplay() {
    print('update amount');
    String text = amountController.text;
    double? currentAmountDouble = double.tryParse(text);
    if (updatingText.value) return; // Prevent recursion
    if (currentAmountDouble != null) {
      updatingText.value = true;
      if (bitcoinUnit == BitcoinUnits.SAT && currentAmountDouble >= 100000000) {
        // Convert to BTC if in SATS and amount is >= 1 BTC
        double btcAmount =
            CurrencyConverter.convertSatoshiToBTC(currentAmountDouble);
        bitcoinUnit.value = BitcoinUnits.BTC;
        print(bitcoinUnit);
        amountController.text = btcAmount.toString(); // Update text to BTC
        // setState(() {});
        //receiveState.value +=1;
        // if (mounted) {
        //   setState(() {
        //     // Your state update logic here
        //   });
        // }
      } else if (currentAmountDouble < 1 &&
          currentAmountDouble != 0 &&
          bitcoinUnit == BitcoinUnits.BTC) {
        // Convert to SATS if in BTC and amount is < 1 BTC
        double sats =
            CurrencyConverter.convertBitcoinToSats(currentAmountDouble);
        bitcoinUnit.value = BitcoinUnits.SAT;
        print(bitcoinUnit);
        amountController.text = sats.toInt().toString(); // Update text to SATS
        // setState(() {});
        //receiveState.value +=1;

        // if (mounted) {
        //   setState(() {
        //     // Your state update logic here
        //   });
        // }
      } else {
        print("ELSE STATEMENT WAS TRIGGERED: " +
            bitcoinUnit.toString() +
            " " +
            currentAmountDouble.toString());
      }
      // Your conversion logic here
      updatingText.value = false;
    }
  }
}
