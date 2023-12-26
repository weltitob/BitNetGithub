import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/view/view_sockets.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onLongPress: () => Get.to(() => const ViewSockets()),
            child: Text(
              'Recent transactions'.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'TXID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'Amount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'USD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'Fee',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              Get.to(const SingleTransactionScreen(),
                                  arguments: controller
                                      .transaction[index].txid
                                      .toString());
                              final controllerTransaction =
                              Get.put(TransactionController());
                              controllerTransaction.getTransLatest(
                                  controller.transaction[index].txid
                                      .toString());
                            },
                            child: Text(
                              '${controller.transaction[index].txid!.substring(0, 5)}...${controller.transaction[index].txid!.substring(controller.transaction[index].txid!.length - 5)}' ??
                                  '',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: Text(
                                '${btcValue.toStringAsFixed(4)} BTC' ??
                                    '')),
                        const SizedBox(width: 20),
                        Expanded(
                            child: Text(
                                '\$${formatPriceDecimal(usdValue)}' ??
                                    '')),
                        const SizedBox(width: 20),
                        Expanded(
                            child: Text(
                                '\$${(feeSatVb / 100000000 * 140 * controller.currentUSD.value).toStringAsFixed(2)}' ??
                                    '')),
                      ],
                    ),
                  );
                });
          }),
        ],
      );
  }
}
