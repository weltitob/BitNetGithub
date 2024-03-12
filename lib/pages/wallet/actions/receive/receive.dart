import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/add_invoice.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/models/bitcoin/lnd/invoice_model.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/pages/wallet/actions/receive/receivescreen.dart';
import 'package:flutter/material.dart';

enum ReceiveType {
  Lightning,
  OnChain,
}

class Receive extends StatefulWidget {
  const Receive({super.key});

  @override
  State<Receive> createState() => ReceiveController();
}

class ReceiveController extends State<Receive> with SingleTickerProviderStateMixin {
  late String qrCodeDataStringLightning = "";
  late String qrCodeDataStringOnchain = "";
  BitcoinUnits bitcoinUnit = BitcoinUnits.SAT;
  ReceiveType receiveType = ReceiveType.Lightning;
  bool _updatingText = false;

  FocusNode myFocusNode = FocusNode();
  late TextEditingController amountController;
  TextEditingController messageController = TextEditingController();

  bool createdInvoice = false;

  final userWallet = UserWallet(
      walletAddress: "publickeyforkeysend",
      walletType: "walletType",
      walletBalance: "0",
      privateKey: "privateKey",
      userdid: "userdid");

  // A GlobalKey is used to identify this widget in the widget tree, used to access and modify its properties
  GlobalKey globalKeyQR = GlobalKey();

  void getInvoice(int amount, String? memo) async {
    bitcoinUnit == BitcoinUnits.SAT ? amount = amount : amount = CurrencyConverter.convertBitcoinToSats(amount.toDouble()).toInt();
    RestResponse callback = await addInvoice(amount, memo ?? "");
    print("Response" + callback.data.toString());
    InvoiceModel invoiceModel = InvoiceModel.fromJson(callback.data);
    print("Invoice" + invoiceModel.payment_request.toString());
    qrCodeDataStringLightning = invoiceModel.payment_request.toString();
    setState(() {

    });
  }

  void getTaprootAddress() async {
    RestResponse callback = await nextAddr();
    print("Response" + callback.data.toString());
    BitcoinAddress address = BitcoinAddress.fromJson(callback.data);
    print("Bitcoin onchain Address" + address.addr.toString());
    qrCodeDataStringOnchain = address.addr.toString();
    setState(() {

    });
  }

  void switchReceiveType(){
    setState(() {
      switch (receiveType) {
        case ReceiveType.Lightning:
          receiveType = ReceiveType.OnChain;
        case ReceiveType.OnChain:
          receiveType = ReceiveType.Lightning;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    amountController.text = "1000";
    // Listen for changes
    amountController.addListener(updateAmountDisplay);
    //probably need to check if other keysend invoice is still available and if not create a new one make the logic unflawed
    getInvoice(0, "");
    getTaprootAddress();
  }

  void updateAmountDisplay() {
    String text = amountController.text;
    double ? currentAmountDouble = double.tryParse(text);
    if (_updatingText) return; // Prevent recursion
      if (currentAmountDouble != null) {
        _updatingText = true;
        if (bitcoinUnit == BitcoinUnits.SAT && currentAmountDouble >= 100000000) {
          // Convert to BTC if in SATS and amount is >= 1 BTC
          double btcAmount = CurrencyConverter.convertSatoshiToBTC(currentAmountDouble);
          bitcoinUnit = BitcoinUnits.BTC;
          print(bitcoinUnit);
          amountController.text = btcAmount.toString(); // Update text to BTC
          setState(() {});
          // if (mounted) {
          //   setState(() {
          //     // Your state update logic here
          //   });
          // }
        } else if (currentAmountDouble < 1 && currentAmountDouble != 0 && bitcoinUnit == BitcoinUnits.BTC) {
          // Convert to SATS if in BTC and amount is < 1 BTC
          double sats = CurrencyConverter.convertBitcoinToSats(currentAmountDouble);
          bitcoinUnit = BitcoinUnits.SAT;
          print(bitcoinUnit);
          amountController.text = sats.toInt().toString(); // Update text to SATS
          setState(() {});
          // if (mounted) {
          //   setState(() {
          //     // Your state update logic here
          //   });
          // }
        }
        else{
          print("ELSE STATEMENT WAS TRIGGERED: " + bitcoinUnit.toString() + " " + currentAmountDouble.toString());
        }
        // Your conversion logic here
        _updatingText = false;
    }
  }

  @override
  void dispose() {
    amountController.removeListener(updateAmountDisplay);
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReceiveScreen(controller: this);
  }
}
