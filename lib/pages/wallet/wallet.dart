import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_invoices.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_transactions.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    subscribeInvoicesStream().listen((restResponse) {
      LoggerService logger = Get.find();
      logger.i("Received data from Invoice-stream: $restResponse");
      ReceivedInvoice receivedInvoice =
          ReceivedInvoice.fromJson(restResponse.data);
      if (receivedInvoice.settled == true) {
        showOverlayTransaction(
            context,
            "Lightning invoice settled",
            TransactionItemData(
              amount: receivedInvoice.amtPaidSat.toString(),
              timestamp: receivedInvoice.settleDate,
              type: TransactionType.lightning,
              status: TransactionStatus.confirmed,
              direction: TransactionDirection.received,
              receiver: receivedInvoice.paymentRequest!,
              txHash: receivedInvoice.rHash!,
              fee: 0,
            ));
        //generate a new invoice for the user with 0 amount
        logger.i("Generating new empty invoice for user");

        ReceiveController().getInvoice(0, "Empty invoice");
      } else {
        logger.i(
            "Invoice received but not settled yet: ${receivedInvoice.settled}");
      }
    }, onError: (error) {
      LoggerService logger = Get.find();
      logger.e("Received error for Invoice-stream: $error");
    });

    subscribeTransactionsStream().listen((restResponse) {
      BitcoinTransaction bitcoinTransaction =
          BitcoinTransaction.fromJson(restResponse.data);
      showOverlayTransaction(
          context,
          "Onchain transaction settled",
          TransactionItemData(
            amount: bitcoinTransaction.amount.toString(),
            timestamp: bitcoinTransaction.timeStamp,
            type: TransactionType.onChain,
            status: TransactionStatus.confirmed,
            direction: TransactionDirection.received,
            receiver: bitcoinTransaction.destAddresses[0],
            txHash: bitcoinTransaction.txHash ?? 'null',
            fee: 0,
          ));
      //});
    }, onError: (error) {
      LoggerService logger = Get.find();
      logger.e("Received error for Transactions-stream: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WalletScreen();
  }

  @override
  void dispose() {
    WalletsController controller = Get.find<WalletsController>();
    controller.loadMessageError = "";
    controller.errorCount = 0;
    controller.loadedFutures = 0;

    super.dispose();
  }
}
