//recent transacctions

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key, required this.ownedTransactions});
  final List<BitcoinTransaction> ownedTransactions;
  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  final controller = Get.put(HomeController());
  //move to get?

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(
        //   height: 20,
        // ),
        // GestureDetector(
        //   onLongPress: () => Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => ViewSockets())),
        //   child: Text(
        //     '${L10n.of(context)!.recentTransactions}'.toUpperCase(),
        //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //   ),
        // ),
        const SizedBox(height: AppTheme.cardPadding),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TXID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // SizedBox(width: 20),
              Text(
                '${L10n.of(context)!.amount}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              // SizedBox(width: 20),
              //
              // SizedBox(width: 20),
              // Expanded(
              //   child: Text(
              //     L10n.of(context)!.fee,
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          ),
        ),
        Obx(() {
          return controller.transactionLoading.isTrue
              ? Center(child: dotProgress(context))
              : controller.mempoolBlocks.isEmpty
                  ? const Text(
                      'Something went wrong!',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: controller.transaction.length,
                      itemBuilder: (context, index) {
                        double btcValue = controller.transaction[index].value! / 100000000;
                        double usdValue = btcValue * usdPrice;
                        double feeSatVb = controller.transaction[index].fee! / controller.transaction[index].vsize!;
                        BitcoinTransaction? ownedTransaction = widget.ownedTransactions.firstWhereOrNull((tx) =>
                            tx.blockHash == controller.transaction[index].txid ||
                            tx.txHash == controller.transaction[index].txid ||
                            tx.rawTxHex == controller.transaction[index].txid);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: GlassContainer(
                            borderRadius: BorderRadius.all(Radius.circular(AppTheme.cardPadding * 0.5)),
                            child: Column(
                              children: [
                                BitNetListTile(
                                  onTap: () {
                                    final controllerTransaction = Get.put(
                                      TransactionController(
                                        txID: controller.transaction[index].txid.toString(),
                                      ),
                                    );
                                    controllerTransaction.txID = controller.transaction[index].txid.toString();
                                    controllerTransaction.getSingleTransaction(controllerTransaction.txID!);
                                    controllerTransaction.changeSocket();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SingleTransactionScreen(),
                                      ),
                                    );
                                  },
                                  text:
                                      '${controller.transaction[index].txid!.substring(0, 5)}...${controller.transaction[index].txid!.substring(controller.transaction[index].txid!.length - 5)}' ??
                                          '',
                                  trailing: SizedBox(
                                    width: 145,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (ownedTransaction != null) ...[
                                          Container(
                                            width: 45,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: AppTheme.colorBitcoin,
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 2),
                                            child: const Center(
                                              child: Text(
                                                'has Tx',
                                                style: TextStyle(color: Colors.white, fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                        ],
                                        Text(
                                          '${btcValue.toStringAsFixed(4)} BTC' ?? '',
                                          style: Theme.of(context).textTheme.labelMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (ownedTransaction != null) ...[
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context).brightness == Brightness.light
                                                  ? Colors.black.withAlpha(50)
                                                  : Colors.white.withAlpha(50)),
                                          borderRadius: BorderRadius.circular(AppTheme.cardPadding * 0.2)),
                                      child: TransactionItem(
                                          data: TransactionItemData(
                                            timestamp: ownedTransaction.timeStamp,
                                            status: ownedTransaction.numConfirmations > 0
                                                ? TransactionStatus.confirmed
                                                : TransactionStatus.pending,
                                            type: TransactionType.onChain,
                                            direction: ownedTransaction.amount!.contains("-")
                                                ? TransactionDirection.sent
                                                : TransactionDirection.received,
                                            receiver: ownedTransaction.amount!.contains("-")
                                                ? ownedTransaction.destAddresses.last.toString()
                                                : ownedTransaction.destAddresses.first.toString(),
                                            txHash: ownedTransaction.txHash.toString(),
                                            fee: 0,
                                            amount: ownedTransaction.amount!.contains("-")
                                                ? ownedTransaction.amount.toString()
                                                : "+" + ownedTransaction.amount.toString(),
                                          )),
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                        );
                      });
        }),
      ],
    );
  }
}
