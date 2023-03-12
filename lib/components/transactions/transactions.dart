import 'dart:async';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/components/buttons/glassbutton.dart';
import 'package:nexus_wallet/components/items/transactionitem.dart';
import 'package:nexus_wallet/models/transaction.dart';
import 'package:nexus_wallet/theme.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final User? currentuser = Auth().currentUser;

  StreamController<double> _transactionStreamController = StreamController<double>();
  late StreamSubscription<double> _priceStreamSubscription;

  List<Transaction> transactions = [];

  void _getTransactions() async {

  }


  @override
  void initState() {
    _getTransactions();
    _priceStreamSubscription = _transactionStreamController.stream.listen((price) {
      setState(() {
        print('new lol');
      });
    });
    transactionCollection.doc(currentuser!.uid).collection('transactions').snapshots().listen((snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          Transaction newTransaction = Transaction.fromMap(doc as Map<String, dynamic>);
          // Add the new document ID to the list
          transactions.add(newTransaction);
        });
      });
    });
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _priceStreamSubscription.cancel();
    _transactionStreamController.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        transaction: Transaction(
                            transactionDirection: TransactionDirection.receive,
                            transactionReceiver: "uhadoihasoidahiosd",
                            transactionSender: "jioafojiadpjianodaps",
                            date: DateTime.now().toString(),
                            amount: "3402.063"),
                        context: context),
                    SizedBox(height: AppTheme.elementSpacing * 0.75),
                    TransactionItem(
                        transaction: Transaction(
                            transactionDirection: TransactionDirection.send,
                            transactionReceiver: "uhadoihasoidahiosd",
                            transactionSender: "jioafojiadpjianodaps",
                            date: "23.03.2022",
                            amount: "3402.063"),
                        context: context),
                    SizedBox(height: AppTheme.elementSpacing * 0.75),
                    TransactionItem(
                        transaction: Transaction(
                            transactionDirection: TransactionDirection.send,
                            transactionReceiver: "uhadoihasoidahiosd",
                            transactionSender: "jioafojiadpjianodaps",
                            date: "23.03.2022",
                            amount: "3402.063"),
                        context: context),
                    SizedBox(height: AppTheme.elementSpacing * 0.75),
                  ],
                ),
              ),
              TransactionItem(
                  transaction: Transaction(
                      transactionDirection: TransactionDirection.send,
                      transactionReceiver: "uhadoihasoidahiosd",
                      transactionSender: "jioafojiadpjianodaps",
                      date: "23.03.2022",
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
