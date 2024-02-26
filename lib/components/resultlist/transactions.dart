import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_invoices.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_transactions.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:matrix/matrix.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {

  bool transactionsLoaded = false;
  List<LightningPayment> lightningPayments = [];
  List<ReceivedInvoice> lightningInvoices = [];
  List<BitcoinTransaction> onchainTransactions = [];

  StreamSubscription<List<ReceivedInvoice>>? _invoicesSubscription;
  StreamSubscription<List<BitcoinTransaction>>? _transactionsSubscription;

  void getOnchainTransactions() async {
    Logs().w("Getting onchain transactions");
    RestResponse restBitcoinTransactions = await getTransactions();
    BitcoinTransactionsList bitcoinTransactions =
        BitcoinTransactionsList.fromJson(restBitcoinTransactions.data);
    onchainTransactions = bitcoinTransactions.transactions;
    setState(() {});
  }

  //what i sent on the lightning network
  void getLightningPayments() async {
    Logs().w("Getting lightning payments");
    RestResponse restLightningPayments = await listPayments();
    LightningPaymentsList lightningPayments =
        LightningPaymentsList.fromJson(restLightningPayments.data);
    this.lightningPayments = lightningPayments.payments;
    setState(() {});
  }

  //what I received on the lightning network
  void getLightningInvoices() async {
    Logs().w("Getting lightning invoices");
    RestResponse restLightningInvoices = await listInvoices();
    ReceivedInvoicesList lightningInvoices =
        ReceivedInvoicesList.fromJson(restLightningInvoices.data);
    List<ReceivedInvoice> settledInvoices =
        lightningInvoices.invoices.where((invoice) => invoice.settled).toList();
    this.lightningInvoices = settledInvoices;
    setState(() {});
  }

  // Subscriptions

  void subscribeToInvoices() {
    _invoicesSubscription = subscribeInvoicesStream().map((restResponse) {
      ReceivedInvoicesList receivedInvoicesList =
          ReceivedInvoicesList.fromJson(restResponse.data);

      List<ReceivedInvoice> settledInvoices = receivedInvoicesList.invoices
          .where((invoice) => invoice.settled)
          .toList();

      return settledInvoices;
    }).listen((invoices) {
      setState(() {
        Logs().w("Updating lightning invoices...");
        lightningInvoices = invoices;
      });
    }, onError: (error) {
      // Handle any errors here
      print("Error subscribing to invoices: $error");
    });
    setState(() {});
  }

  void subscribeToTransactions() {
    // Assuming `subscribeTransactionsStream` is your method that returns a Stream<RestResponse>
    _transactionsSubscription =
        subscribeTransactionsStream().map((restResponse) {
      // Parse the `restResponse.data` to extract `List<BitcoinTransaction>`
      BitcoinTransactionsList bitcoinTransactionsList =
          BitcoinTransactionsList.fromJson(restResponse.data);
      return bitcoinTransactionsList.transactions;
    }).listen((transactions) {
      setState(() {
        Logs().w("Updating onChain transactions...");
        onchainTransactions = transactions;
      });
    }, onError: (error) {
      Logs().e("Error subscribing to transactions: $error");
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      transactionsLoaded = false;
    });
    subscribeInvoicesStream().listen((data) {
      Logs().w("Invoice-stream received data: $data");
    }, onError: (error) {
      Logs().e("Received error for Invoice-stream: $error");
    });

    subscribeTransactionsStream().listen((data) {
      Logs().w("Transactions-stream received data: $data");
    }, onError: (error) {
      Logs().e("Received error for Transactions-stream: $error");
    });
    getOnchainTransactions();
    getLightningPayments();
    getLightningInvoices();
    setState(() {
      transactionsLoaded = true;
    });
  }

  @override
  void dispose() {
    _invoicesSubscription?.cancel();
    _transactionsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var combinedTransactions = [
      ...lightningInvoices.map((transaction) => TransactionItem(
            timestamp: transaction.settleDate,
            context: context,
            type: TransactionType.lightning,
            direction: TransactionDirection.received,
            receiver: transaction.paymentRequest.toString(),
            txHash: transaction.value.toString(),
            amount: "+" + transaction.amtPaid.toString(),
            status: TransactionStatus.failed,
            // other properties
          )),
      ...lightningPayments.map((transaction) => TransactionItem(
            timestamp: transaction.creationDate,
            context: context,
            type: TransactionType.lightning,
            direction: TransactionDirection.sent,
            receiver: transaction.paymentHash.toString(),
            txHash: transaction.paymentHash.toString(),
            amount: "-" + transaction.valueSat.toString(),
            status: transaction.status == "SUCCEEDED"
                ? TransactionStatus.confirmed
                : TransactionStatus.pending,
          )),
      ...onchainTransactions.map((transaction) => TransactionItem(
          timestamp: transaction.timeStamp,
          status: TransactionStatus.pending,
          type: TransactionType.onChain,
          direction: transaction.amount.contains("-")
              ? TransactionDirection.sent
              : TransactionDirection.received,
          context: context,
          receiver: transaction.amount.contains("-")
              ? transaction.destAddresses.last.toString()
              : transaction.destAddresses.first.toString(),
          txHash: transaction.txHash.toString(),
          amount: transaction.amount.contains("-")
              ? transaction.amount.toString()
              : "+" + transaction.amount.toString()
          )),
    ].toList();

    combinedTransactions.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    combinedTransactions = combinedTransactions.reversed.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppTheme.elementSpacing),
          child: transactionsLoaded
              ? Container(
                  height: AppTheme.cardPadding * 18,
                  child: ListView(children: combinedTransactions))
              : Container(
                  height: AppTheme.cardPadding * 18,
                  child: dotProgress(context),
                ),
        ),
      ],
    );
  }
}
