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

class RecentReplacements extends StatefulWidget {
  const RecentReplacements({super.key, required this.ownedTransactions});
  final List<BitcoinTransaction> ownedTransactions;

  @override
  State<RecentReplacements> createState() => _RecentReplacementsState();
}

class _RecentReplacementsState extends State<RecentReplacements> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(height: AppTheme.cardPadding),
        // Text(
        //   '${L10n.of(context)!.recentReplacements}'.toUpperCase(),
        //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
              // SizedBox(width: 50),
              // Expanded(
              //   flex: 2,
              //   child: Text(
              //     '${L10n.of(context)!.previousFee}',
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(width: 20),
              // Expanded(
              //   flex: 2,
              //   child: Text(
              //     L10n.of(context)!.newFee,
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(width: 0),
              Text(
                L10n.of(context)!.status,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Obx(
          () {
            return controller.transactionLoading.isTrue
                ? Center(child: dotProgress(context))
                : controller.transactionReplacements.isEmpty
                    ? const Text(
                        'Something went wrong!',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        reverse: false,
                        itemCount: controller.transactionReplacements.length,
                        itemBuilder: (context, index) {
                          BitcoinTransaction? ownedTransaction = widget.ownedTransactions.firstWhereOrNull((tx) =>
                              tx.blockHash == controller.transactionReplacements[index].txid ||
                              tx.txHash == controller.transactionReplacements[index].txid ||
                              tx.rawTxHex == controller.transactionReplacements[index].txid);

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
                                          txID: controller.transactionReplacements[index].txid.toString(),
                                        ),
                                      );
                                      controllerTransaction.txID = controller.transactionReplacements[index].txid.toString();
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
                                        '${controller.transactionReplacements[index].txid!.substring(0, 5)}...${controller.transactionReplacements[index].txid!.substring(controller.transactionReplacements[index].txid!.length - 5)}' ??
                                            '',
                                    trailing: SizedBox(
                                      width: 200,
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
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(AppTheme.elementSpacing / 2),
                                                decoration: BoxDecoration(
                                                    borderRadius: AppTheme.cardRadiusSuperSmall,
                                                    color: controller.transactionReplacements[index].fullRbf!
                                                        ? AppTheme.colorBitcoin
                                                        : AppTheme.successColor),
                                                child: Text(controller.transactionReplacements[index].fullRbf!
                                                    ? L10n.of(context)!.fullRbf
                                                    : L10n.of(context)!.rbf),
                                              ),
                                              const SizedBox(width: 10),
                                              controller.transactionReplacements[index].mined!
                                                  ? Container(
                                                      padding: const EdgeInsets.all(AppTheme.elementSpacing / 2),
                                                      decoration:
                                                          BoxDecoration(borderRadius: AppTheme.cardRadiusSuperSmall, color: Colors.green),
                                                      child: Text('${L10n.of(context)!.mined}'),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
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
                                            context: context,
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
                        },
                      );
          },
        ),
      ],
    );
  }
}
