import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/pages/secondpages/mempool/view/recentreplacements.dart';
import 'package:bitnet/pages/secondpages/mempool/view/recenttransactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class LastTransactions extends StatefulWidget {
  const LastTransactions({super.key, required this.ownedTransactions});
  final List<BitcoinTransaction> ownedTransactions;
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
    return Container();


    //   GlassContainer(
    //   height: 600,
    //   width: 900,
    //   //contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding * 2.5),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
    //     child: Column(
    //       children: [
    //         TabBar(
    //           controller: _tabController,
    //           tabs: [
    //             Tab(text: L10n.of(context)!.recentTransactions),
    //             Tab(text: L10n.of(context)!.recentReplacements),
    //           ],
    //         ),
    //         Expanded(
    //           child: TabBarView(
    //             controller: _tabController,
    //             children: [
    //               SingleChildScrollView(child: RecentTransactions(ownedTransactions: widget.ownedTransactions)),
    //               SingleChildScrollView(child: RecentReplacements(ownedTransactions: widget.ownedTransactions)),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
