//recent transacctions

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/view/view_sockets.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

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
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TXID',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // SizedBox(width: 20),
              Text(
                '${L10n.of(context)!.amount}',
                style: TextStyle(fontWeight: FontWeight.bold),
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
              ? const Center(child: CircularProgressIndicator())
              : controller.mempoolBlocks.isEmpty
                  ? const Text(
                      'Something went wrong!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: controller.transaction.length,
                      itemBuilder: (context, index) {
                        double btcValue =
                            controller.transaction[index].value! / 100000000;
                        double usdValue = btcValue * usdPrice;
                        double feeSatVb = controller.transaction[index].fee! /
                            controller.transaction[index].vsize!;
                        return BitNetListTile(
                          onTap: () {
                            final controllerTransaction = Get.put(
                              TransactionController(
                                txID: controller.transaction[index].txid
                                    .toString(),
                              ),
                            );
                            controllerTransaction.txID = controller
                                .transaction[index].txid
                                .toString();
                            controllerTransaction.getSingleTransaction(
                                controllerTransaction.txID!);
                            controllerTransaction.changeSocket();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SingleTransactionScreen(),
                              ),
                            );
                          },
                          text: '${controller.transaction[index].txid!.substring(0, 5)}...${controller.transaction[index].txid!.substring(controller.transaction[index].txid!.length - 5)}' ?? '',
                          trailing: Text(
                            '${btcValue.toStringAsFixed(4)} BTC' ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        );
                      });
        }),
      ],
    );
  }
}
