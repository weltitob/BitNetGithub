import 'package:bitnet/pages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentReplacements extends StatefulWidget {
  const RecentReplacements({super.key});

  @override
  State<RecentReplacements> createState() => _RecentReplacementsState();
}

class _RecentReplacementsState extends State<RecentReplacements> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'Recent replacements'.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'TXID',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                flex: 2,
                child: Text(
                  'Previous fee',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: Text(
                  'New Fee',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 0),
              Expanded(
                child: Text(
                  'Status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Obx(
              () {
            return controller.transactionLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : controller.transactionReplacements.isEmpty
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
              reverse: false,
              itemCount: controller.transaction.length,
              itemBuilder: (context, index) {
                double feeSatVb = controller
                    .transactionReplacements[index].newFee! /
                    controller
                        .transactionReplacements[index].newVsize!;
                double prevSatVb = controller
                    .transactionReplacements[index].oldFee! /
                    controller
                        .transactionReplacements[index].oldVsize!;
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
                                    .transactionReplacements[index]
                                    .txid
                                    .toString());
                            // final controllerTransaction =
                            //     Get.put(
                            //         TransactionController());
                            // Future.delayed(
                            //         const Duration(
                            //             seconds:
                            //                 5))
                            //     .then((value) =>
                            //         controllerTransaction
                            //                 .replaced =
                            //             true);
                            // controllerTransaction.getSingleTransactionCache(controller
                            // .transactionReplacements[
                            //     index]
                            // .txid
                            // .toString());
                            // controllerTransaction
                            //     .replaced = true;
                            // controllerTransaction
                            //     .getTrans(controller
                            //         .transactionReplacements[
                            //             index]
                            //         .txid
                            //         .toString());
                            // controllerTransaction
                            //         .hideUnconfirmed =
                            //     false;
                          },
                          child: Text(
                            '${controller.transactionReplacements[index].txid!.substring(0, 5)}...${controller.transactionReplacements[index].txid!.substring(controller.transactionReplacements[index].txid!.length - 5)}' ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      //  const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Text(
                            '${prevSatVb.toStringAsFixed(1)} sat/vB' ??
                                ''),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                            '${feeSatVb.toStringAsFixed(1)} sat/vB' ??
                                ''),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(5),
                                color: controller
                                    .transactionReplacements[
                                index]
                                    .fullRbf!
                                    ? Colors.lightBlueAccent
                                    : Colors.green),
                            child: Text(controller
                                .transactionReplacements[index]
                                .fullRbf!
                                ? 'Full RBF'
                                : 'RBF'),
                          ),
                          const SizedBox(width: 10),
                          controller.transactionReplacements[index]
                              .mined!
                              ? Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(5),
                                color: Colors.green),
                            child: Text('Mined '),
                          )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
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
