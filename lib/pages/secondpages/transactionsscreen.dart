import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/pages/secondpages/mempool/view/recentreplacements.dart';
import 'package:bitnet/pages/secondpages/mempool/view/recenttransactions.dart';
import 'package:flutter/material.dart';

class LastTransactionsScreen extends StatefulWidget {
  const LastTransactionsScreen({super.key});

  @override
  State<LastTransactionsScreen> createState() => _LastTransactionsScreenState();
}

class _LastTransactionsScreenState extends State<LastTransactionsScreen> with SingleTickerProviderStateMixin {
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
    return RoundedContainer(
      contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding),
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
    );
  }
}
