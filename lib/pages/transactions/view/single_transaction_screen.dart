//single transaction

// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:math';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
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
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          controller.timer?.cancel();
          controller.timerLatest?.cancel();
          controller.timerTime?.cancel();
          channel.sink.add('{"track-rbf-summary":true}');
          channel.sink.add('{"track-tx":"stop"}');
          channel.sink
              .add('{"action":"want","data":["blocks","mempool-blocks"]}');

          Navigator.pop(context);
          controller.homeController.isRbfTransaction.value = false;
          // controller.txID = '';
          print('arrow pop');
        },
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          // if (didPop) {
          controller.timer?.cancel();
          controller.timerLatest?.cancel();
          controller.timerTime?.cancel();
          channel.sink.add('{"track-rbf-summary":true}');
          channel.sink.add('{"track-tx":"stop"}');
          channel.sink
              .add('{"action":"want","data":["blocks","mempool-blocks"]}');
          controller.homeController.isRbfTransaction.value = false;
        },
        child: Obx(() {
          return controller.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.transactionModel == null
                  ? Center(child: Text('Something went wrong'))
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: AppTheme.cardPadding * 2),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                            GestureDetector(
                                              onTap: () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                  text: controllerHome
                                                      .replacedTx.value,
                                                ));
                                                Get.snackbar(
                                                    'Copied', controller.txID!);
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 300,
                                                    child: Text(
                                                      controllerHome
                                                          .replacedTx.value,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          decorationColor:
                                                              Colors.white,
                                                          decorationThickness:
                                                              2),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.copy,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
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
                                        Expanded(
                                          child: Text(
                                            'Transaction',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: controller
                                                        .transactionModel ==
                                                    null
                                                ? Colors.red
                                                : controller.transactionModel!
                                                        .status!.confirmed!
                                                    ? Colors.green
                                                    : controllerHome
                                                                .isRbfTransaction
                                                                .value ==
                                                            true
                                                        ? Colors.orange
                                                        : Colors.red,
                                          ),
                                          child: Center(
                                            child: Text(
                                              controllerHome.isRbfTransaction
                                                          .value ==
                                                      true
                                                  ? 'Replaced'
                                                  : '${controller.confirmations == 0 ? '' : controller.confirmations} ' +
                                                      controller
                                                          .statusTransaction
                                                          .value,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(controller.txID!,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue)),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              await Clipboard.setData(
                                                  ClipboardData(
                                                text: controller.txID!,
                                              ));
                                              Get.snackbar(
                                                  'Copied', controller.txID!);
                                            },
                                            icon: const Icon(Icons.copy))
                                      ],
                                    ),
                                    controllerHome.txConfirmed.value
                                        ? Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Timestamp',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000))}'
                                                          ' (${controller.formatTimeAgo(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000))})',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('Confirmed',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'After ' +
                                                              DateTime
                                                                  .fromMillisecondsSinceEpoch(
                                                                (controller
                                                                            .transactionModel!
                                                                            .status!
                                                                            .blockTime! *
                                                                        1000) -
                                                                    (controller
                                                                            .txTime! *
                                                                        1000),
                                                              ).minute.toString() +
                                                              ' minutes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'First seen',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                controller.timeST.value,
                                                style: TextStyle(
                                                    color: Colors.white),
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
                                        const Text(
                                          'Fee',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${controller.transactionModel == null ? '' : controller.formatPrice(controller.transactionModel!.fee.toString())} sat ',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
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
                                    controllerHome.txConfirmed.value
                                        ? SizedBox()
                                        // : controller.replaced
                                        //     ? SizedBox()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'ETA',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    controllerHome.txPosition
                                                                .value >=
                                                            7
                                                        ? 'In Several hours (or more)'
                                                        : 'In ~ ${controllerHome.txPosition.value + 1 * 10} minutes',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.purple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Center(
                                                      child: Text(
                                                        'Accelerate',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                        Expanded(
                                            flex: 4,
                                            child: Text(
                                              'Features',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        Expanded(
                                          flex: 4,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (controller
                                                  .segwitEnabled.value)
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                                  margin: const EdgeInsets
                                                      .symmetric(
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
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    'SegWit',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decorationColor:
                                                            Colors.white,
                                                        decoration: controller
                                                                    .potentialP2shSegwitGains !=
                                                                0
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : TextDecoration
                                                                .none),
                                                  ),
                                                ),
                                              if (controller
                                                  .taprootEnabled.value)
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4,
                                                      vertical: 2),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                            .isTaproot.value
                                                        ? Colors.green
                                                        : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    'Taproot',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decorationColor:
                                                            Colors.white,
                                                        decoration: controller
                                                                .isTaproot.value
                                                            ? TextDecoration
                                                                .none
                                                            : TextDecoration
                                                                .lineThrough),
                                                  ),
                                                ),
                                              if (controller.rbfEnabled.value)
                                                Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: controller
                                                              .isRbfTransaction
                                                              .value
                                                          ? Colors.green
                                                          : Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
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
                                                              ? TextDecoration
                                                                  .none
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Fee rate',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${(controller.feeRate * 4).toStringAsFixed(1)} sat/vB',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            controllerHome.txConfirmed.value
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: controller
                                                                  .feeRating
                                                                  .value ==
                                                              1
                                                          ? Colors.green
                                                          : controller.feeRating
                                                                      .value ==
                                                                  2
                                                              ? Colors.orange
                                                              : Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
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
                                                                FontWeight
                                                                    .bold),
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
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'Effective Fee rate',
                                    //       style: TextStyle(color: Colors.white),
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         Text(
                                    //           '${(controller.feeRate * 4).toStringAsFixed(1)} sat/vB',
                                    //           style: TextStyle(
                                    //               color: Colors.white),
                                    //         ),
                                    //         SizedBox(
                                    //           width: 10,
                                    //         ),

                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Inputs & Outputs',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  controller.toggleExpansion();
                                                },
                                                child: !controller
                                                        .showDetail.value
                                                    ? const Text(
                                                        'Show Detail',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      )
                                                    : const Text(
                                                        'Hide Detail',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      )),
                                          ],
                                        ),
                                        controller.showDetail.value
                                            ? Column(
                                                children: [
                                                  const Text(
                                                    'Inputs\n',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                  ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .transactionModel
                                                        ?.vin
                                                        ?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      double value = (controller
                                                              .transactionModel!
                                                              .vin![index]
                                                              .prevout!
                                                              .value!) /
                                                          100000000;
                                                      controller.input.value =
                                                          double.parse(value
                                                              .toStringAsFixed(
                                                                  8));
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: index.isOdd
                                                                ? Colors.grey
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
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
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Icon(
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
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              AddressComponent(),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress == null &&
                                                                              controller.transactionModel!.vin?[index].prevout?.scriptpubkeyType == "op_return"
                                                                          ? 'OP_RETURN (R)'
                                                                          : '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring(0, 10)}'
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
                                                                Flexible(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            4,
                                                                        vertical:
                                                                            4),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child: controller
                                                                            .isShowBTC
                                                                            .value
                                                                        ? Text(
                                                                            '${controller.isShowBTC.value ? controller.inPutBTC(index) : controller.inPutDollar(index)} BTC',
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          )
                                                                        : Text(
                                                                            '\$ ${controller.inPutDollar(index)} ',
                                                                            style:
                                                                                TextStyle(color: Colors.black)),
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
                                                                        'Witness',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey)),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        ListView
                                                                            .builder(
                                                                          physics:
                                                                              const NeverScrollableScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: controller
                                                                              .transactionModel!
                                                                              .vin?[index]
                                                                              .witness
                                                                              ?.length,
                                                                          itemBuilder:
                                                                              (context, ind) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.only(bottom: 10),
                                                                              child: Text(controller.transactionModel?.vin != null ? '${controller.transactionModel?.vin?[index].witness?[ind]}' : '', style: TextStyle(color: Colors.grey)),
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
                                                                    'nSequence',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey)),
                                                                Text(
                                                                    '0x${controller.transactionModel?.vin?[index].sequence?.toRadixString(16)}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey))
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
                                                                    'Previous output script',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey)),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                        '${controller.transactionModel?.vin?[index].prevout?.scriptpubkeyAsm}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey)))
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
                                                                    'Previous output type',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey)),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                        '${controller.transactionModel?.vin?[index].prevout?.scriptpubkeyType}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey)))
                                                              ],
                                                            ),
                                                            const Divider(
                                                              height: 10,
                                                              color: Colors
                                                                  .black87,
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
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .transactionModel
                                                        ?.vout
                                                        ?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      double value = (controller
                                                              .transactionModel!
                                                              .vout![index]
                                                              .value!) /
                                                          100000000;
                                                      controller.output.value =
                                                          double.parse(value
                                                              .toStringAsFixed(
                                                                  8));
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            color: index.isEven
                                                                ? Colors.grey
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                                  color: controller.dataOutSpents1.data[0][index]
                                                                              [
                                                                              'spent'] ==
                                                                          false
                                                                      ? Colors
                                                                          .green
                                                                      : controller.dataOutSpents1.data[0][index]['spent'] ==
                                                                              true
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .grey
                                                                              .shade600,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    const Center(
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
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller.getAddressComponent(controller
                                                                            .transactionModel!
                                                                            .vout?[index]
                                                                            .scriptpubkeyAddress
                                                                            .toString());
                                                                        controller
                                                                            .addressId = controller.transactionModel!.vout?[index].scriptpubkeyAddress
                                                                                .toString() ??
                                                                            '';
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => AddressComponent()));
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        controller.transactionModel!.vout?[index].scriptpubkeyAddress == null && controller.transactionModel!.vout?[index].scriptpubkeyType == "op_return"
                                                                            ? 'OP_RETURN (R)'
                                                                            : controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ??
                                                                                '',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      child: controller
                                                                              .isShowBTC
                                                                              .value
                                                                          ? Text(
                                                                              '${controller.isShowBTC.value ? controller.outPutBTC(index) : controller.outPutDollar(index)} BTC',
                                                                              style: TextStyle(color: Colors.black))
                                                                          : Text('\$ ${controller.outPutDollar(index)} ', style: TextStyle(color: Colors.black)),
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
                                                                      'ScriptPubKey (ASM)	',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black)),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Flexible(
                                                                      child: Text(
                                                                          '${controller.transactionModel?.vout?[index].scriptpubkeyAsm}',
                                                                          style:
                                                                              TextStyle(color: Colors.black)))
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
                                                                      'ScriptPubKey (HEX)	',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black)),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Flexible(
                                                                      child: Text(
                                                                          '${controller.transactionModel?.vout?[index].scriptpubkey}',
                                                                          style:
                                                                              TextStyle(color: Colors.black)))
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
                                                                      'Type',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black)),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Flexible(
                                                                      child: Text(
                                                                          '${controller.transactionModel?.vout?[index].scriptpubkeyType}',
                                                                          style:
                                                                              TextStyle(color: Colors.black)))
                                                                ],
                                                              ),
                                                              const Divider(
                                                                height: 10,
                                                                color: Colors
                                                                    .black87,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          controller.isShowBTC
                                                                  .value =
                                                              !controller
                                                                  .isShowBTC
                                                                  .value;
                                                          controller
                                                              .dollarRate();
                                                          controller
                                                              .outPutDollars();
                                                        },
                                                        child: controller
                                                                .isShowBTC.value
                                                            ? Text(
                                                                "${controller.totalOutPutBTC.value.toStringAsFixed(8)} BTC",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white))
                                                            : Text(
                                                                ' \$ ${controller.totalOutPutDollar.value.toStringAsFixed(2)}  ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white))),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  const Text(
                                                    'Inputs\n',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .transactionModel
                                                        ?.vin
                                                        ?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      double value = (controller
                                                              .transactionModel!
                                                              .vin![index]
                                                              .prevout!
                                                              .value!) /
                                                          100000000;
                                                      controller.input.value =
                                                          double.parse(value
                                                              .toStringAsFixed(
                                                                  8));
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5),
                                                        decoration: BoxDecoration(
                                                            color: index.isOdd
                                                                ? Colors.grey
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                                  color: Colors
                                                                      .red,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Icon(
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
                                                                      onTap:
                                                                          () {
                                                                        controller.getAddressComponent(controller
                                                                            .transactionModel!
                                                                            .vin?[index]
                                                                            .prevout!
                                                                            .scriptpubkeyAddress);
                                                                        controller
                                                                            .addressId = controller
                                                                                .transactionModel!.vin?[index].prevout!.scriptpubkeyAddress ??
                                                                            '';
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => AddressComponent()));

                                                                        // Get.to(() =>
                                                                        //     AddressComponent());
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress == null &&
                                                                                controller.transactionModel!.vin?[index].prevout?.scriptpubkeyType == "op_return"
                                                                            ? 'OP_RETURN (R)'
                                                                            : '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring(0, 10)}'
                                                                                '... '
                                                                                '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring((controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.length)! - 5)}',
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.blue,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  controller
                                                                          .isShowBTC
                                                                          .value
                                                                      ? Text(
                                                                          '${controller.inPutBTC(index)} BTC',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        )
                                                                      : Text(
                                                                          '\$ ${controller.inPutDollar(index)} ',
                                                                          style:
                                                                              TextStyle(color: Colors.black))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                    'Outputs\n',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .transactionModel
                                                        ?.vout
                                                        ?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      double value = (controller
                                                              .transactionModel!
                                                              .vout![index]
                                                              .value!) /
                                                          100000000;

                                                      controller.output.value =
                                                          double.parse(
                                                        value
                                                            .toStringAsFixed(8),
                                                      );
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            color: index.isEven
                                                                ? Colors.grey
                                                                : Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                                  color: controller.dataOutSpents1.data[0][index]
                                                                              [
                                                                              'spent'] ==
                                                                          false
                                                                      ? Colors
                                                                          .green
                                                                      : controller.dataOutSpents1.data[0][index]['spent'] ==
                                                                              true
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .grey
                                                                              .shade600,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_forward_outlined,
                                                                    size: 15,
                                                                  ),
                                                                ),
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
                                                                      onTap:
                                                                          () {
                                                                        controller.getAddressComponent(controller
                                                                            .transactionModel!
                                                                            .vout?[index]
                                                                            .scriptpubkeyAddress
                                                                            .toString());
                                                                        controller
                                                                            .addressId = controller.transactionModel!.vout?[index].scriptpubkeyAddress
                                                                                .toString() ??
                                                                            '';
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                AddressComponent(),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        controller.transactionModel!.vout?[index].scriptpubkeyAddress == null && controller.transactionModel!.vout?[index].scriptpubkeyType == "op_return"
                                                                            ? 'OP_RETURN (R)'
                                                                            : controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ??
                                                                                '',
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              4,
                                                                          vertical:
                                                                              2),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .grey,
                                                                          borderRadius:
                                                                              BorderRadius.circular(3)),
                                                                      child: controller
                                                                              .isShowBTC
                                                                              .value
                                                                          ? Text(
                                                                              '${controller.isShowBTC.value ? controller.outPutBTC(index) : controller.outPutDollar(index)} BTC',
                                                                              style: TextStyle(color: Colors.black))
                                                                          : Text('\$ ${controller.outPutDollar(index)} ', style: TextStyle(color: Colors.black)),
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
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          controller.isShowBTC
                                                                  .value =
                                                              !controller
                                                                  .isShowBTC
                                                                  .value;
                                                          controller
                                                              .dollarRate();
                                                          controller
                                                              .outPutDollars();
                                                        },
                                                        child: controller
                                                                .isShowBTC.value
                                                            ? Text(
                                                                "${controller.totalOutPutBTC.value.toStringAsFixed(8)} BTC",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white))
                                                            : Text(
                                                                ' \$${controller.formatPrice(controller.totalOutPutDollar.value.toStringAsFixed(0))}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white))),
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
                                              color: Colors.white,
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
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                    (controller
                                                            .transactionModel!
                                                            .sigops)!
                                                        .toStringAsFixed(0),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                controller.formatPrice(
                                                    controller.transactionModel!
                                                        .locktime
                                                        .toString()),
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
                                                            controller
                                                                .transactionModel!
                                                                .weight
                                                                .toString())
                                                        : (controller
                                                                    .transactionModel!
                                                                    .weight! /
                                                                1000)
                                                            .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 80,
                                        ),
                                        Visibility(
                                            visible:
                                                controller.getHexValue.value,
                                            child: Text(controller
                                                .hexValue.value
                                                .toString()))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
        }),
      ),
    );
  }
}
