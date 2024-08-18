import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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
        // const SizedBox(height: AppTheme.cardPadding),
        // Text(
        //   '${L10n.of(context)!.recentReplacements}'.toUpperCase(),
        //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Obx(
          () {
            return controller.transactionLoading.isTrue
                ?  Center(child: dotProgress(context))
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
                          return
                            BitNetListTile(
                              onTap: () {
                                final controllerTransaction = Get.put(
                                  TransactionController(
                                    txID: controller
                                        .transactionReplacements[index].txid
                                        .toString(),
                                  ),
                                );
                                controllerTransaction.txID = controller
                                    .transactionReplacements[index].txid
                                    .toString();
                                controllerTransaction
                                    .getSingleTransaction(
                                        controllerTransaction.txID!);
                                controllerTransaction.changeSocket();
                                // Get.to(()=>SingleTransactionScreen());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SingleTransactionScreen()),
                                );
                              },
                              text: '${controller.transactionReplacements[index].txid!.substring(0, 5)}...${controller.transactionReplacements[index].txid!.substring(controller.transactionReplacements[index].txid!.length - 5)}' ??
                                  '',
                              trailing: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(AppTheme.elementSpacing /2),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            AppTheme.cardRadiusSuperSmall,
                                        color: controller
                                                .transactionReplacements[
                                                    index]
                                                .fullRbf!
                                            ? AppTheme.colorBitcoin
                                            : AppTheme.successColor),
                                    child: Text(controller
                                            .transactionReplacements[index]
                                            .fullRbf!
                                        ? L10n.of(context)!.fullRbf
                                        : L10n.of(context)!.rbf),
                                  ),
                                  const SizedBox(width: 10),
                                  controller.transactionReplacements[index]
                                          .mined!
                                      ? Container(
                                          padding: const EdgeInsets.all(AppTheme.elementSpacing / 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  AppTheme.cardRadiusSuperSmall,
                                              color: Colors.green),
                                          child: Text('${L10n.of(context)!.mined}'),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            );
                          //   Row(
                          //   children: [
                          //     Expanded(
                          //       flex: 2,
                          //       child: InkWell(
                          //         onTap: () {
                          //           print(controller
                          //               .transactionReplacements[index].txid);
                          //           final controllerTransaction = Get.put(
                          //             TransactionController(
                          //               txID: controller
                          //                   .transactionReplacements[index]
                          //                   .txid
                          //                   .toString(),
                          //             ),
                          //           );
                          //           controllerTransaction.txID = controller
                          //               .transactionReplacements[index].txid
                          //               .toString();
                          //           controllerTransaction
                          //               .getSingleTransaction(
                          //                   controllerTransaction.txID!);
                          //           controllerTransaction.changeSocket();
                          //           // Get.to(()=>SingleTransactionScreen());
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     SingleTransactionScreen()),
                          //           );
                          //         },
                          //         child: Text(
                          //           '${controller.transactionReplacements[index].txid!.substring(0, 5)}...${controller.transactionReplacements[index].txid!.substring(controller.transactionReplacements[index].txid!.length - 5)}' ??
                          //               '',
                          //           overflow: TextOverflow.ellipsis,
                          //           style: const TextStyle(
                          //               color: Colors.blue,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ),
                          //     //  const SizedBox(width: 10),
                          //     // Expanded(
                          //     //   flex: 2,
                          //     //   child: Text(
                          //     //       '${prevSatVb.toStringAsFixed(1)} sat/vB' ??
                          //     //           ''),
                          //     // ),
                          //     // const SizedBox(width: 10),
                          //     // Expanded(
                          //     //   flex: 1,
                          //     //   child: Text(
                          //     //       '${feeSatVb.toStringAsFixed(1)} sat/vB' ??
                          //     //           ''),
                          //     // ),
                          //     const SizedBox(width: 10),
                          //     Row(
                          //       children: [
                          //         Container(
                          //           padding: const EdgeInsets.all(8),
                          //           decoration: BoxDecoration(
                          //               borderRadius:
                          //                   BorderRadius.circular(5),
                          //               color: controller
                          //                       .transactionReplacements[
                          //                           index]
                          //                       .fullRbf!
                          //                   ? Colors.lightBlueAccent
                          //                   : Colors.green),
                          //           child: Text(controller
                          //                   .transactionReplacements[index]
                          //                   .fullRbf!
                          //               ? L10n.of(context)!.fullRbf
                          //               : L10n.of(context)!.rbf),
                          //         ),
                          //         const SizedBox(width: 10),
                          //         controller.transactionReplacements[index]
                          //                 .mined!
                          //             ? Container(
                          //                 padding: const EdgeInsets.all(8),
                          //                 decoration: BoxDecoration(
                          //                     borderRadius:
                          //                         BorderRadius.circular(5),
                          //                     color: Colors.green),
                          //                 child: Text('${L10n.of(context)!.mined}'),
                          //               )
                          //             : SizedBox.shrink(),
                          //       ],
                          //     ),
                          //   ],
                          // );
                        },
                      );
          },
        ),
      ],
    );
  }
}
