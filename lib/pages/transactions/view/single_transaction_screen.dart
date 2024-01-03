// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:math';

import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/address_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SingleTransactionScreen extends StatelessWidget {
  const SingleTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    final controllerHome = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            controller.timer?.cancel();
            controller.timerLatest?.cancel();
            channel.sink.add('{"track-rbf-summary":true}');
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? const Center(child: CircularProgressIndicator())
            : controller.transactionModel == null
                ? Center(child: Text('Something went wrong'))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     children: [
                          //       SizedBox(
                          //         width: Get.width / 2.1,
                          //         child: Obx(() {
                          //           return controllerHome.socketLoading.isTrue
                          //               ? const SizedBox()
                          //               : controllerHome.mempoolBlocks.isEmpty
                          //                   ? const Text(
                          //                       'Something went wrong!',
                          //                       style: TextStyle(
                          //                           color: Colors.white,
                          //                           fontWeight: FontWeight.w700,
                          //                           fontSize: 22),
                          //                     )
                          //                   : SizedBox(
                          //                       height: 270,
                          //                       child: ListView.builder(
                          //                           shrinkWrap: true,
                          //                           reverse: true,
                          //                           scrollDirection:
                          //                               Axis.horizontal,
                          //                           itemCount: controllerHome
                          //                               .mempoolBlocks.length,
                          //                           itemBuilder: (context, index) {
                          //                             var min = (index + 1) *
                          //                                 (controllerHome
                          //                                         .da!.timeAvg! /
                          //                                     60000);
                          //                             return GestureDetector(
                          //                               onTap: () {
                          //                                 controller
                          //                                     .selectedCardIndex
                          //                                     .value = index;
                          //                               },
                          //                               child: SocketDataWidget(
                          //                                 mempoolBlocks:
                          //                                     controllerHome
                          //                                             .mempoolBlocks[
                          //                                         index],
                          //                                 mins: min
                          //                                     .toStringAsFixed(0),
                          //                                 index: index,
                          //                                 singleTx: true,
                          //                               ),
                          //                             );
                          //                           }),
                          //                     );
                          //         }),
                          //       ),
                          //       Container(
                          //         height: 250,
                          //         width: 1.5,
                          //         color: Colors.grey,
                          //       ),
                          //       SizedBox(
                          //         width: Get.width / 1.9,
                          //         child: Obx(() {
                          //           return controller.isLoading.isTrue
                          //               ? const Center(
                          //                   child: CircularProgressIndicator())
                          //               : controllerHome.bitcoinData.isEmpty
                          //                   ? const Text(
                          //                       'Something went wrong!',
                          //                       style: TextStyle(
                          //                           color: Colors.white,
                          //                           fontWeight: FontWeight.w700,
                          //                           fontSize: 22),
                          //                     )
                          //                   : SizedBox(
                          //                       height: 300,
                          //                       child: ListView.builder(
                          //                           shrinkWrap: true,
                          //                           scrollDirection:
                          //                               Axis.horizontal,
                          //                           itemCount: controllerHome
                          //                               .bitcoinData.length,
                          //                           itemBuilder: (context, index) {
                          //                             //so here are these are been in ou
                          //                             double size = controllerHome
                          //                                     .bitcoinData[index]
                          //                                     .size! /
                          //                                 1000000;
                          //                             return GestureDetector(
                          //                               onTap: () {
                          //                                 controller
                          //                                     .selectedCardIndex
                          //                                     .value = index;
                          //                               },
                          //                               child: DataWidget(
                          //                                 blockData: controllerHome
                          //                                     .bitcoinData[index],
                          //                                 size: size,
                          //                                 time: controllerHome.formatTimeAgo(
                          //                                     DateTime.fromMillisecondsSinceEpoch(
                          //                                         (controllerHome
                          //                                                 .bitcoinData[
                          //                                                     index]
                          //                                                 .timestamp! *
                          //                                             1000))),
                          //                                 index: index,
                          //                                 singleTx: true,
                          //                               ),
                          //                             );
                          //                           }),
                          //                     );
                          //         }),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          controller.homeController.isRbfTransaction.value
                              ? Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade400,
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'This transaction has been replaced by:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          controllerHome.replacedTx.value,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.white,
                                              decorationThickness: 2),
                                        ),
                                      ]),
                                )
                              : SizedBox(),

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Transaction',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: controller.transactionModel ==
                                                null
                                            ? Colors.red
                                            : controller.transactionModel!
                                                    .status!.confirmed!
                                                ? Colors.green
                                                : controllerHome.isRbfTransaction
                                                            .value ==
                                                        true
                                                    ? Colors.orange
                                                    : Colors.red,
                                      ),
                                      child: Center(
                                          child: Text(
                                    controllerHome.isRbfTransaction
                                                            .value ==
                                                        true?'Replaced':    '${controller.confirmations == 0 ? '' : controller.confirmations} ' +
                                            controller.statusTransaction.value,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(controller.txID.value,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue)),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                            text: controller.txID.value,
                                          ));
                                          Get.snackbar(
                                              'Copied', controller.txID.value);
                                        },
                                        icon: const Icon(Icons.copy))
                                  ],
                                ),
                                controller.confirmationStatus.value
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Timestamp'),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000))}'
                                                    ' (${controller.timeST.value})',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  // const SizedBox(width: 10),
                                                  // Text(),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     const Text('Confirmed'),
                                          //     Row(
                                          //       children: [
                                          //         Text(
                                          //           controller.formatTimeAgo(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000 )),
                                          //           style:
                                          //               TextStyle(fontSize: 12),
                                          //         ),
                                          //         // const SizedBox(width: 10),
                                          //         // Text(),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('First seen'),
                                          Text(controller.timeST.value)
                                        ],
                                      ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Fee'),
                                    Row(
                                      children: [
                                        Text(
                                            '${controller.transactionModel == null ? '' : controller.formatPrice(controller.transactionModel?.fee)} sat '),
                                        Text(
                                          '\$ ${controller.usdValue.value.toStringAsFixed(2)}  ',
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                // controller.confirmationStatus.value
                                //     ? Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Text('Confirmed'),
                                //               Text(
                                //                   '${controller.timeST.value }'),
                                //         ],
                                //       )
                                //     : SizedBox(),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                controller.confirmationStatus.value
                                    ? SizedBox()
                                    // : controller.replaced
                                    //     ? SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('ETA'),
                                          Row(
                                            children: [
                                              Text(controllerHome
                                                          .txPosition.value >=
                                                      7
                                                  ? 'In Several hours or more'
                                                  : 'In ~ ${controllerHome.txPosition.value + 1 * 10} minutes'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                    color: Colors.purple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    'Accelerate',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(flex: 4, child: Text('Features')),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (controller.segwitEnabled.value)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 2,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: controller
                                                                .realizedSegwitGains !=
                                                            0 &&
                                                        controller
                                                                .potentialSegwitGains !=
                                                            0
                                                    ? Colors.orange
                                                    : controller.potentialP2shSegwitGains !=
                                                            0
                                                        ? Colors.red
                                                        : Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                'SegWit',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    decorationColor:
                                                        Colors.white,
                                                    decoration: controller
                                                                .potentialP2shSegwitGains !=
                                                            0
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none),
                                              ),
                                            ),
                                          if (controller.taprootEnabled.value)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color:
                                                    controller.isTaproot.value
                                                        ? Colors.green
                                                        : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                'Taproot',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    decorationColor:
                                                        Colors.white,
                                                    decoration: controller
                                                            .isTaproot.value
                                                        ? TextDecoration.none
                                                        : TextDecoration
                                                            .lineThrough),
                                              ),
                                            ),
                                          if (controller.rbfEnabled.value)
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 2, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: controller
                                                          .isRbfTransaction
                                                          .value
                                                      ? Colors.green
                                                      : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  'RBF',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decorationColor:
                                                          Colors.white,
                                                      decoration: controller
                                                              .isRbfTransaction
                                                              .value
                                                          ? TextDecoration.none
                                                          : TextDecoration
                                                              .lineThrough),
                                                )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Fee rate'),
                                    Row(
                                      children: [
                                        Text(
                                            '${(controller.feeRate * 4).toStringAsFixed(1)} sat/vB'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        controller.confirmationStatus.value
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: controller.feeRating
                                                              .value ==
                                                          1
                                                      ? Colors.green
                                                      : controller.feeRating
                                                                  .value ==
                                                              2
                                                          ? Colors.orange
                                                          : Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    controller.feeRating
                                                                .value ==
                                                            1
                                                        ? 'Optimal'
                                                        : 'Overpaid ${controller.overpaidTimes ?? 1}x',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Inputs & Outputs',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.toggleExpansion();
                                            },
                                            child: !controller.showDetail.value
                                                ? const Text(
                                                    'Show Detail',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )
                                                : const Text(
                                                    'Hide Detail',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )),
                                      ],
                                    ),
                                    controller.showDetail.value
                                        ? Column(
                                            children: [
                                              const Text(
                                                'Inputs\n',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .transactionModel
                                                    ?.vin
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  double value = (controller
                                                          .transactionModel!
                                                          .vin![index]
                                                          .prevout!
                                                          .value!) /
                                                      100000000;
                                                  controller.input.value =
                                                      double.parse(value
                                                          .toStringAsFixed(8));
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: index.isOdd
                                                            ? Colors.grey
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: controller
                                                                .outputIconColor(),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: const Center(
                                                              child: Icon(
                                                            Icons
                                                                .arrow_forward_outlined,
                                                            size: 15,
                                                          )),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Flexible(
                                                                flex: 3,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    controller.getAddressComponent(controller
                                                                        .transactionModel!
                                                                        .vin?[
                                                                            index]
                                                                        .prevout!
                                                                        .scriptpubkeyAddress);
                                                                    controller
                                                                        .addressId = controller
                                                                            .transactionModel!
                                                                            .vin?[index]
                                                                            .prevout!
                                                                            .scriptpubkeyAddress ??
                                                                        '';
                                                                    Get.to(() =>
                                                                        AddressComponent());
                                                                  },
                                                                  child: Text(
                                                                    '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring(0, 10)}'
                                                                    '... '
                                                                    '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring((controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.length)! - 5)}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ),
                                                                )),
                                                            Flexible(
                                                              flex: 2,
                                                              child: Container(
                                                                color:
                                                                    Colors.grey,
                                                                child: controller
                                                                        .isShowBTC
                                                                        .value
                                                                    ? Text(
                                                                        '${controller.isShowBTC.value ? controller.inPutBTC(index) : controller.inPutDollar(index)} BTC')
                                                                    : Text(
                                                                        '\$ ${controller.inPutDollar(index)} '),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        SizedBox(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Expanded(
                                                                child: Text(
                                                                    'Witness'),
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  children: [
                                                                    ListView
                                                                        .builder(
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount: controller
                                                                          .transactionModel!
                                                                          .vin?[
                                                                              index]
                                                                          .witness
                                                                          ?.length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              ind) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              bottom: 10),
                                                                          child: Text(controller.transactionModel?.vin != null
                                                                              ? '${controller.transactionModel?.vin?[index].witness?[ind]}'
                                                                              : ''),
                                                                        );
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                                'nSequence'),
                                                            Text(
                                                                '0x${controller.transactionModel?.vin?[index].sequence?.toRadixString(16)}')
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                                'Previous output script'),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                                child: Text(
                                                                    '${controller.transactionModel?.vin?[index].prevout?.scriptpubkeyAsm}'))
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                                'Previous output type'),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                                child: Text(
                                                                    '${controller.transactionModel?.vin?[index].prevout?.scriptpubkeyType}'))
                                                          ],
                                                        ),
                                                        const Divider(
                                                          height: 10,
                                                          color: Colors.black87,
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                'Outputs\n',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .transactionModel
                                                    ?.vout
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  double value = (controller
                                                          .transactionModel!
                                                          .vout![index]
                                                          .value!) /
                                                      100000000;
                                                  controller.output.value =
                                                      double.parse(value
                                                          .toStringAsFixed(8));
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: index.isEven
                                                            ? Colors.grey
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: controller
                                                                  .outputIconColor(),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_outlined,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Flexible(
                                                                  flex: 3,
                                                                  child: Text(
                                                                    controller
                                                                            .transactionModel!
                                                                            .vout?[index]
                                                                            .scriptpubkeyAddress
                                                                            .toString() ??
                                                                        '',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  )),
                                                              Flexible(
                                                                flex: 2,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  child: controller
                                                                          .isShowBTC
                                                                          .value
                                                                      ? Text(
                                                                          '${controller.isShowBTC.value ? controller.outPutBTC(index) : controller.outPutDollar(index)} BTC')
                                                                      : Text(
                                                                          '\$ ${controller.outPutDollar(index)} '),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                  'ScriptPubKey (ASM)	'),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Flexible(
                                                                  child: Text(
                                                                      '${controller.transactionModel?.vout?[index].scriptpubkeyAsm}'))
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                  'ScriptPubKey (HEX)	'),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Flexible(
                                                                  child: Text(
                                                                      '${controller.transactionModel?.vout?[index].scriptpubkey}'))
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                  'Type'),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Flexible(
                                                                  child: Text(
                                                                      '${controller.transactionModel?.vout?[index].scriptpubkeyType}'))
                                                            ],
                                                          ),
                                                          const Divider(
                                                            height: 10,
                                                            color:
                                                                Colors.black87,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                              .isShowBTC.value =
                                                          !controller
                                                              .isShowBTC.value;
                                                      controller.dollarRate();
                                                      controller
                                                          .outPutDollars();
                                                    },
                                                    child: controller
                                                            .isShowBTC.value
                                                        ? Text(
                                                            "${controller.totalOutPutBTC.value.toStringAsFixed(8)} BTC")
                                                        : Text(
                                                            ' \$ ${controller.formatPrice(controller.totalOutPutDollar.value.toStringAsFixed(0))}  ')),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              const Text(
                                                'Inputs\n',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .transactionModel
                                                    ?.vin
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  double value = (controller
                                                          .transactionModel!
                                                          .vin![index]
                                                          .prevout!
                                                          .value!) /
                                                      100000000;
                                                  controller.input.value =
                                                      double.parse(value
                                                          .toStringAsFixed(8));
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: index.isOdd
                                                            ? Colors.grey
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: controller
                                                                  .inputIconColor(),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Center(
                                                                child: Icon(
                                                              Icons
                                                                  .arrow_forward_outlined,
                                                              size: 15,
                                                            )),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Flexible(
                                                                flex: 2,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    controller.getAddressComponent(controller
                                                                        .transactionModel!
                                                                        .vin?[
                                                                            index]
                                                                        .prevout!
                                                                        .scriptpubkeyAddress);
                                                                    controller
                                                                        .addressId = controller
                                                                            .transactionModel!
                                                                            .vin?[index]
                                                                            .prevout!
                                                                            .scriptpubkeyAddress ??
                                                                        '';
                                                                    Get.to(() =>
                                                                        AddressComponent());
                                                                  },
                                                                  child: Text(
                                                                    '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring(0, 10)}'
                                                                    '... '
                                                                    '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring((controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.length)! - 5)}',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .blue,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              controller
                                                                      .isShowBTC
                                                                      .value
                                                                  ? Text(
                                                                      '${controller.inPutBTC(index)} BTC')
                                                                  : Text(
                                                                      '\$ ${controller.inPutDollar(index)} ')
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              const Text(
                                                'Outputs\n',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .transactionModel
                                                    ?.vout
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  double value = (controller
                                                          .transactionModel!
                                                          .vout![index]
                                                          .value!) /
                                                      100000000;

                                                  controller.output.value =
                                                      double.parse(
                                                    value.toStringAsFixed(8),
                                                  );
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: index.isEven
                                                            ? Colors.grey
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: controller
                                                                  .outputIconColor(),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Center(
                                                                child: Icon(
                                                              Icons
                                                                  .arrow_forward_outlined,
                                                              size: 15,
                                                            )),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Flexible(
                                                                  flex: 2,
                                                                  child: Text(
                                                                    controller
                                                                            .transactionModel!
                                                                            .vout?[index]
                                                                            .scriptpubkeyAddress
                                                                            .toString() ??
                                                                        '',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  )),
                                                              Flexible(
                                                                flex: 2,
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .grey,
                                                                  child: controller
                                                                          .isShowBTC
                                                                          .value
                                                                      ? Text(
                                                                          '${controller.isShowBTC.value ? controller.outPutBTC(index) : controller.outPutDollar(index)} BTC')
                                                                      : Text(
                                                                          '\$ ${controller.outPutDollar(index)} '),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                              .isShowBTC.value =
                                                          !controller
                                                              .isShowBTC.value;
                                                      controller.dollarRate();
                                                      controller
                                                          .outPutDollars();
                                                    },
                                                    child: controller
                                                            .isShowBTC.value
                                                        ? Text(
                                                            "${controller.totalOutPutBTC.value.toStringAsFixed(8)} BTC")
                                                        : Text(
                                                            ' \$${controller.formatPrice(int.parse(controller.totalOutPutDollar.value.toStringAsFixed(0)))}')),
                                              )
                                            ],
                                          )
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Details',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Size',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${controller.transactionModel?.size.toString()}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              Transform.translate(
                                                offset: const Offset(0, 3),
                                                child: const Text(
                                                  ' B',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Version',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "${controller.transactionModel?.version.toString()}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Virtual size',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                (controller.transactionModel!
                                                            .weight! /
                                                        4)
                                                    .toStringAsFixed(0),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              Transform.translate(
                                                offset: const Offset(0, 3),
                                                child: const Text(
                                                  ' vB',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Adjusted size',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${max<int>(int.parse((controller.transactionModel!.weight! / 4).toStringAsFixed(0)), controller.transactionModel!.sigops!)}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              Transform.translate(
                                                offset: const Offset(0, 3),
                                                child: const Text(
                                                  ' vB',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Sigops',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                (controller.transactionModel!
                                                        .sigops)!
                                                    .toStringAsFixed(0),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Locktime',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            controller.formatPrice(int.parse(
                                                controller
                                                    .transactionModel!.locktime
                                                    .toString())),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Weight',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                controller.transactionModel!
                                                            .weight! <
                                                        1000
                                                    ? controller.formatPrice(
                                                        int.parse(controller
                                                            .transactionModel!
                                                            .weight
                                                            .toString()))
                                                    : (controller
                                                                .transactionModel!
                                                                .weight! /
                                                            1000)
                                                        .toStringAsFixed(1),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              Transform.translate(
                                                offset: const Offset(0, 3),
                                                child: const Text(
                                                  ' WU',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Transsaction hex',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                controller.transactionHex();
                                              },
                                              child: const Icon(
                                                Icons.open_in_new,
                                                color: Colors.blue,
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Visibility(
                                        visible: controller.getHexValue.value,
                                        child: Text(controller.hexValue.value
                                            .toString()))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
      }),
    );
  }
}
