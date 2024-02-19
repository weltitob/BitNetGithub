import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_invoices.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_transactions.dart';
import 'package:bitnet/components/items/transactionitem.dart';
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
  List<LightningPayment> lightningPayments = [];
  List<ReceivedInvoice> lightningInvoices = [];
  List<BitcoinTransaction> onchainTransactions = [];
  //TransactionsStream transactionsStream = TransactionsStream();
  //all transactions in and out of the wallet

  // Stream Subscriptions
  StreamSubscription<List<ReceivedInvoice>>? _invoicesSubscription;
  StreamSubscription<List<BitcoinTransaction>>? _transactionsSubscription;

  void getOnchainTransactions() async {
    Logs().w("Getting onchain transactions");
    RestResponse restBitcoinTransactions = await getTransactions();
    BitcoinTransactionsList bitcoinTransactions =
        BitcoinTransactionsList.fromJson(restBitcoinTransactions.data);
    onchainTransactions = bitcoinTransactions.transactions;
  }

  //what i sent on the lightning network
  void getLightningPayments() async {
    Logs().w("Getting lightning payments");
    RestResponse restLightningPayments = await listPayments();
    LightningPaymentsList lightningPayments =
        LightningPaymentsList.fromJson(restLightningPayments.data);
    this.lightningPayments = lightningPayments.payments;
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
  }

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
  }

  void subscribeToTransactions() {
    // Assuming `subscribeTransactionsStream` is your method that returns a Stream<RestResponse>
    var subscriptionStream = subscribeTransactionsStream();

    if (subscriptionStream != null) {
      _transactionsSubscription = subscriptionStream.map((restResponse) {
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
        // Handle any errors here
        print("Error subscribing to transactions: $error");
      });
    } else {
      // Handle the case where subscribeTransactionsStream is null
      // For example, log an error, set a state indicating the error, etc.
      print(
          "subscribeTransactionsStream is null, cannot subscribe to transactions");
    }
  }

  @override
  void initState() {
    super.initState();
    print("Subscribing to transactions...");
    subscribeInvoicesStream().listen((data) {
      Logs().w("Received data: $data");
    }, onError: (error) {
      Logs().e("Received error: $error");
      // Handle error
    });
    //subscribeToInvoices();
    //subscribeToTransactions();

    print("Getting transactions...");
    getOnchainTransactions();
    getLightningPayments();
    getLightningInvoices();
  }

  @override
  void dispose() {
    _invoicesSubscription?.cancel();
    _transactionsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final userData = Provider.of<UserData>(context);
    //final userWallet = userData.mainWallet;

    //getTransactions(userWallet);
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
            // other properties
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
          // other properties
          )),
    ].toList();

// Sort the combined list by timestamp
    combinedTransactions.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    combinedTransactions = combinedTransactions.reversed.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppTheme.elementSpacing),
          child: Container(
              height: AppTheme.cardPadding * 18,
              child: ListView(children:
                combinedTransactions
              )

              //
              // StreamBuilder<List<BitcoinTransaction>>(
              //   stream: transactionsStream.getTransactionsStream(),
              //   builder: (context, snapshot) {
              //     if (!snapshot.hasData) {
              //       return SizedBox(
              //           height: AppTheme.cardPadding * 3,
              //           child: Center(child: dotProgress(context)));
              //     }
              //     List<BitcoinTransaction> all_transactions = snapshot.data!;
              //     // Filter transactions by transaction type
              //     List<BitcoinTransaction> receive_transactions = all_transactions
              //         .where((t) => t.transactionDirection == "received")
              //         .toList();
              //
              //     List<BitcoinTransaction> send_transactions = all_transactions
              //         .where((t) => t.transactionDirection == "sent")
              //         .toList();
              //     if (all_transactions.length == 0) {
              //       return searchForFilesAnimation(_searchforfilesComposition);
              //     } //else =>
              //     return TabBarView(
              //       controller: _tabController,
              //       children: [
              //         ListView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: all_transactions.length,
              //           itemBuilder: (context, index) {
              //             final _transaction = all_transactions[index];
              //             return TransactionItem(
              //                 transaction: _transaction, context: context);
              //           },
              //         ),
              //         // ListView.builder(
              //         //   physics: NeverScrollableScrollPhysics(),
              //         //   shrinkWrap: true,
              //         //   itemCount: send_transactions.length,
              //         //   itemBuilder: (context, index) {
              //         //     final _transaction = send_transactions[index];
              //         //     return TransactionItem(
              //         //         transaction: _transaction, context: context);
              //         //   },
              //         // ),
              //         // ListView.builder(
              //         //   physics: NeverScrollableScrollPhysics(),
              //         //   shrinkWrap: true,
              //         //   itemCount: receive_transactions.length,
              //         //   itemBuilder: (context, index) {
              //         //     final _transaction = receive_transactions[index];
              //         //     return TransactionItem(
              //         //         transaction: _transaction, context: context);
              //         //   },
              //         // ),
              //       ],
              //     );
              //   },
              // ),
              ),
        ),
      ],
    );
  }

  Widget searchForFilesAnimation(dynamic comp) {
    return Column(
      children: [
        SizedBox(
          height: AppTheme.cardPadding * 2,
        ),
        SizedBox(
          height: AppTheme.cardPadding * 6,
          width: AppTheme.cardPadding * 6,
          child: FutureBuilder(
            future: comp,
            builder: (context, snapshot) {
              dynamic composition = snapshot.data;
              if (composition != null) {
                return Container();
              } else {
                return Container(
                  color: Colors.transparent,
                );
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(AppTheme.cardPadding),
          child: Text(
            "Es scheint, als hättest du bisher noch keine Transaktionshistorie.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
