import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/add_invoice.dart';
import 'package:bitnet/models/bitcoin/lnd/invoice_model.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/pages/wallet/actions/receive/receivescreen.dart';
import 'package:flutter/material.dart';

class Receive extends StatefulWidget {
  const Receive({super.key});

  @override
  State<Receive> createState() => ReceiveController();
}

class ReceiveController extends State<Receive> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late String qrCodeDataString = "";


  bool createdInvoice = false;

  final userWallet = UserWallet(
      walletAddress: "publickeyforkeysend",
      walletType: "walletType",
      walletBalance: "0",
      privateKey: "privateKey",
      userdid: "userdid");

  // A GlobalKey is used to identify this widget in the widget tree, used to access and modify its properties
  GlobalKey globalKeyQR = GlobalKey();

  void getInvoice(int amount) async {
    RestResponse callback = await addInvoice(amount);
    print("Response" + callback.data.toString());
    InvoiceModel invoiceModel = InvoiceModel.fromJson(callback.data);
    print("Invoice" + invoiceModel.payment_request.toString());
    qrCodeDataString = invoiceModel.payment_request.toString();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    //probably need to check if other keysend invoice is still available and if not create a new one make the logic unflawed
    getInvoice(0);
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReceiveScreen(controller: this);
  }
}
