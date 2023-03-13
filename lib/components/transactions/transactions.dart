import 'dart:async';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/backbone/loaders.dart';
import 'package:nexus_wallet/components/buttons/glassbutton.dart';
import 'package:nexus_wallet/components/items/transactionitem.dart';
import 'package:nexus_wallet/models/transaction.dart';
import 'package:nexus_wallet/backbone/theme.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final User? currentuser = Auth().currentUser;
  bool isLoading = true;
  late StreamSubscription<double> _transactionstreamlistener;

  List<BitcoinTransaction> transactions = [];

  void _getTransactions() async {
    try{
      QuerySnapshot snapshot = await transactionCollection
          .doc(currentuser!.uid)
          .collection('all')
          .orderBy('timestamp', descending: true)
          .get();
      transactions = snapshot.docs.map((doc) => BitcoinTransaction.fromDocument(doc)).toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      _getTransactions();
    });
    _tabController = TabController(length: 3, vsync: this);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _transactionstreamlistener.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
          height: AppTheme.cardPadding * 3,
          child: dotProgress(context));
    } return Column(
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
                        color: AppTheme.white80,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Versendet",
                    style: AppTheme.textTheme.bodyMedium!.copyWith(
                        color: AppTheme.white80,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Erhalten",
                    style: AppTheme.textTheme.bodyMedium!.copyWith(
                        color: AppTheme.white80,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        Container(
          height: AppTheme.cardPadding * 15,
          child: TabBarView(
            controller: _tabController,
            children: [
              Container(
                child: Column(
                  children: [
                    TransactionItem(
                        transaction: BitcoinTransaction(
                            transactionDirection: TransactionDirection.receive,
                            transactionReceiver: "uhadoihasoidahiosd",
                            transactionSender: "jioafojiadpjianodaps",
                            date: DateTime.now().toString(),
                            amount: "3402.063"),
                        context: context),
                    SizedBox(height: AppTheme.elementSpacing * 0.75),
                    TransactionItem(
                        transaction: BitcoinTransaction(
                            transactionDirection: TransactionDirection.send,
                            transactionReceiver: "uhadoihasoidahiosd",
                            transactionSender: "jioafojiadpjianodaps",
                            date: DateTime.now().toString(),
                            amount: "3402.063"),
                        context: context),
                    SizedBox(height: AppTheme.elementSpacing * 0.75),
                    TransactionItem(
                        transaction: BitcoinTransaction(
                            transactionDirection: TransactionDirection.send,
                            transactionReceiver: "uhadoihasoidahiosd",
                            transactionSender: "jioafojiadpjianodaps",
                            date: DateTime.now().toString(),
                            amount: "3402.063"),
                        context: context),
                    SizedBox(height: AppTheme.elementSpacing * 0.75),
                    TransactionItem(
                        transaction: BitcoinTransaction(
                            transactionDirection: TransactionDirection.send,
                            transactionReceiver: "uhadoihasoidahiosd",
                            transactionSender: "jioafojiadpjianodaps",
                            date: DateTime.now().toString(),
                            amount: "3402.063"),
                        context: context),
                  ],
                ),
              ),
              TransactionItem(
                  transaction: BitcoinTransaction(
                      transactionDirection: TransactionDirection.send,
                      transactionReceiver: "uhadoihasoidahiosd",
                      transactionSender: "jioafojiadpjianodaps",
                      date: DateTime.now().toString(),
                      amount: "3402.063"),
                  context: context),
              ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return TransactionItem(
                      transaction: transactions[index],
                      context: context
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
