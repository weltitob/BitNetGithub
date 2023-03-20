import 'dart:async';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/gettransactions.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/backbone/loaders.dart';
import 'package:nexus_wallet/components/items/transactionitem.dart';
import 'package:nexus_wallet/models/transaction.dart';
import 'package:nexus_wallet/backbone/theme.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final Future<LottieComposition> _searchforfilesComposition;
  final User? currentuser = Auth().currentUser;
  bool _visible = false;

  Stream<List<BitcoinTransaction>> getTransactionsStream() {
    // Create a stream that listens to changes in the transactions collection
    return transactionCollection
        .doc(currentuser!.uid)
        .collection('all')
        .orderBy('timestampSent', descending: true)
        .snapshots()
        .map((snapshot) {
      // Convert each document in the snapshot to a Transaction object
      return snapshot.docs
          .map((doc) => BitcoinTransaction.fromDocument(doc))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchforfilesComposition = loadComposition('assets/lottiefiles/search_for_files.json');
    updatevisibility();
    _tabController = TabController(length: 3, vsync: this);
  }

  void updatevisibility() async {
    await _searchforfilesComposition;
    var timer = Timer(Duration(milliseconds: 50),
            () {
          setState(() {
            _visible = true;
          });
        }
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userWallet = Provider.of<UserWallet>(context);
    getTransactions(userWallet);

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
        Container(
          height: AppTheme.cardPadding * 15,
          child: StreamBuilder<List<BitcoinTransaction>>(
            stream: getTransactionsStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(
                    height: AppTheme.cardPadding * 3,
                    child: Center(child: dotProgress(context)));
              }
              List<BitcoinTransaction> all_transactions = snapshot.data!;
              // Filter transactions by transaction type
              List<BitcoinTransaction> receive_transactions = all_transactions.where((t)
              => t.transactionDirection == "received").toList();

              List<BitcoinTransaction> send_transactions = all_transactions.where((t)
              => t.transactionDirection == "sent").toList();
              if(all_transactions.length == 0){
                return searchForFilesAnimation(_searchforfilesComposition);
              } //else =>
              return TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: all_transactions.length,
                    itemBuilder: (context, index) {
                      final _transaction = all_transactions[index];
                      return TransactionItem(
                          transaction: _transaction, context: context);
                    },
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: send_transactions.length,
                    itemBuilder: (context, index) {
                      final _transaction = send_transactions[index];
                      return TransactionItem(
                          transaction: _transaction, context: context);
                    },
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: receive_transactions.length,
                    itemBuilder: (context, index) {
                      final _transaction = receive_transactions[index];
                      return TransactionItem(
                          transaction: _transaction, context: context);
                    },
                  ),
                 ],
              );
            },
          ),
        ),
      ],
    );
  }


  Widget searchForFilesAnimation(dynamic comp) {
    return  Column(
      children: [
        SizedBox(height: AppTheme.cardPadding * 2,),
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
          child: Text("Es scheint, als hättest du bisher noch keine Transaktionshistorie.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,),
        ),
      ],
    );
  }

}
