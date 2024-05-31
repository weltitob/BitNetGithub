import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/secondpages/mempool/view/recentreplacements.dart';
import 'package:bitnet/pages/secondpages/mempool/view/recenttransactions.dart';
import 'package:flutter/material.dart';

class LastTransactions extends StatefulWidget {
  const LastTransactions({super.key});

  @override
  State<LastTransactions> createState() => _LastTransactionsState();
}

class _LastTransactionsState extends State<LastTransactions> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 600,
      width: 900,
      //contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding * 2.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Recent Transactions'),
                Tab(text: 'Recent Replacements'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(child: RecentTransactions()),
                  SingleChildScrollView(child: RecentReplacements()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
