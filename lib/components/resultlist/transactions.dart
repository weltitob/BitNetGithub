import 'dart:async';

import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:matrix/matrix.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final Future<LottieComposition> _searchforfilesComposition;
  bool _visible = false;
  List<LightningPayment> lightningPayments = [];
  List<ReceivedInvoice> lightningInvoices = [];
  List<BitcoinTransaction> onchainTransactions = [];
  //TransactionsStream transactionsStream = TransactionsStream();
  //all transactions in and out of the wallet

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
    // Angenommen, 'restLightningInvoices.data' ist das JSON-Objekt, das Sie erhalten haben.
    ReceivedInvoicesList lightningInvoices =
        ReceivedInvoicesList.fromJson(restLightningInvoices.data);
    // Filtern Sie die Rechnungen, um nur diejenigen zu behalten, die beglichen wurden.
    List<ReceivedInvoice> settledInvoices =
        lightningInvoices.invoices.where((invoice) => invoice.settled).toList();
    // Zuweisung der gefilterten Liste zu Ihrer Klassenvariable oder einem anderen Container
    this.lightningInvoices = settledInvoices;
  }

  @override
  void initState() {
    super.initState();
    _searchforfilesComposition =
        loadComposition('assets/lottiefiles/search_for_files.json');
    updatevisibility();
    _tabController = TabController(length: 3, vsync: this);
    getOnchainTransactions();
    getLightningPayments();
    getLightningInvoices();
  }

  void updatevisibility() async {
    await _searchforfilesComposition;
    var timer = Timer(Duration(milliseconds: 50), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final userData = Provider.of<UserData>(context);
    //final userWallet = userData.mainWallet;

    //getTransactions(userWallet);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: ButtonsTabBar(
              contentPadding: const EdgeInsets.symmetric(
                vertical: AppTheme.elementSpacing * 0.5,
                horizontal: AppTheme.elementSpacing,
              ),
              borderWidth: 1.5,
              unselectedBorderColor: Colors.transparent,
              borderColor: Colors.white.withOpacity(0.2),
              radius: 100,
              physics: ClampingScrollPhysics(),
              controller: _tabController,
              // give the indicator a decoration (color and border radius)
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              unselectedDecoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              tabs: [
                Tab(
                  child: Text(
                    "Alle",
                    style: AppTheme.textTheme.bodyMedium!.copyWith(
                        color: AppTheme.white80, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Versendet",
                    style: AppTheme.textTheme.bodyMedium!.copyWith(
                        color: AppTheme.white80, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Erhalten",
                    style: AppTheme.textTheme.bodyMedium!.copyWith(
                        color: AppTheme.white80, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: AppTheme.elementSpacing),
          child: Container(
              height: AppTheme.cardPadding * 18,
              child: ListView(children: [
                ...lightningInvoices
                    .map((transaction) => TransactionItem(
                          timestamp: transaction.settleDate,
                          context: context,
                          type: TransactionType.lightning,
                          direction: TransactionDirection.received,
                          receiver: transaction.paymentRequest.toString(),
                          txHash: transaction.value.toString(),
                          amount: "+" + transaction.amtPaid.toString(),
                          status: TransactionStatus.failed,
                          //received: transaction.status == "SUCCEEDED",
                        ))
                    .toList(),
                ...lightningPayments
                    .map((transaction) => TransactionItem(
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
                          //received: transaction.status == "SUCCEEDED",
                        ))
                    .toList(),
                ...onchainTransactions
                    .map((transaction) => TransactionItem(
                        timestamp: transaction.timeStamp,
                        status: TransactionStatus.pending,
                        type: TransactionType.onChain,
                        direction: transaction.amount.contains("-")
                            ? TransactionDirection.sent
                            : TransactionDirection.received,
                        context: context,
                        receiver: transaction.destAddresses.toString(),
                        txHash: transaction.txHash.toString(),
                        amount: transaction.amount.contains("-")
                            ? transaction.amount.toString()
                            : "+" + transaction.amount.toString()))
                    .toList(),
              ])

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
                return FittedBox(
                  fit: BoxFit.fitHeight,
                  child: AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 1000),
                    child: Lottie(composition: composition),
                  ),
                );
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
