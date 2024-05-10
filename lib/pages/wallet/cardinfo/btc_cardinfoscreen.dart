import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/models/mempool_models/outspends_model.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/address_component.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'dart:math' as math;


class BitcoinCardInformationScreen extends StatefulWidget {
  BitcoinCardInformationScreen({super.key});

  @override
  State<BitcoinCardInformationScreen> createState() => _BitcoinCardInformationScreenState();
}

class _BitcoinCardInformationScreenState extends State<BitcoinCardInformationScreen> {
  bool isShowMore = false;
  final controller = Get.put(TransactionController());

  @override
  void initState() {
    controller.getAddressComponent('bc1p5lfahjz2j3679ynqy4fu8tvteem92fuqfqfsax7vx97lyr3vhkwqlxjh5e');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          context.go("/feed");
        },
        text: "Bitcoin Card Information",
        ),
      context: context,
      body: Obx(
              () => controller.isLoadingAddress.value
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height: 200,
                      child: BalanceCardBtc()),
                  BitNetListTile(
                    text: 'Address',
                    trailing: Text('bc1qkmlp...' + '30fltzunefdjln'),
                  ),
                  BitNetListTile(
                    text: 'QRCode',
                    trailing: Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(
                            AppTheme.cardPadding / 1.25),
                        //margin: const EdgeInsets.all(AppTheme.cardPadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppTheme.cardRadiusBigger),
                        child: PrettyQrView.data(
                            data:
                            "bc1qkmlpuea96ekcjlk2wpjhsrr030fltzunefdjln",
                            decoration: const PrettyQrDecoration(
                              shape: PrettyQrSmoothSymbol(
                                roundFactor: 1,
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Received',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 12),
                        ),
                        Row(
                          children: [
                            Text(
                              '${((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Sent',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 12),
                        ),
                        Row(
                          children: [
                            Text(
                              '${((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Balance',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 12),
                        ),
                        Row(
                          children: [
                            Text(
                              '${(((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000) - ((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000)).toStringAsFixed(8)} BTC',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 12),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '\$${((((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000) - ((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000)) * controller.currentUSD.value).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.greenAccent,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Text(
                          controller.subTransactionModel.length < 10
                              ? '${controller.subTransactionModel.length}'
                              : controller.page.value ==
                              ((controller.addressComponentModel!
                                  .chainStats.txCount +
                                  controller
                                      .addressComponentModel!
                                      .mempoolStats
                                      .txCount) ~/
                                  10 +
                                  1) >
                              controller
                                  .subTransactionModel.length
                              ? (controller.addressComponentModel!
                              .chainStats.txCount +
                              controller.addressComponentModel!
                                  .mempoolStats.txCount)
                              .toString()
                              : (controller.page * 10).toString(),
                          style: Theme.of(context).textTheme.titleMedium
                        );
                      }),
                       Text(
                        ' of ',
                          style: Theme.of(context).textTheme.titleMedium
                      ),
                      Text(
                        (controller.addressComponentModel!.chainStats
                            .txCount +
                            controller.addressComponentModel!
                                .mempoolStats.txCount)
                            .toString(),
                          style: Theme.of(context).textTheme.titleMedium

                      ),
                       Text(
                        ' transactions ',
                           style: Theme.of(context).textTheme.titleMedium

                       ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Obx(() {
                    return controller.subTransactionModel.isEmpty
                        ? const Text('Loading')
                        : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                        controller.subTransactionModel.length < 10
                            ? controller.subTransactionModel.length
                            : 10,
                        itemBuilder: (context, index) {
                          final homeController =
                          Get.find<HomeController>();
                          int confirmation = 0;
                          int height = controller
                              .subTransactionModel[index]
                              .status!
                              .blockHeight ??
                              0;
                          int chainTip =
                              homeController.bitcoinData.first.height ??
                                  0;
                          confirmation =
                              math.max(1, chainTip - height + 1);
                          num bitCoin = controller
                              .subTransactionModel[index].fee! /
                              100000000;
                          String feeUsd =
                          (bitCoin * usdPrice).toStringAsFixed(2);
                          String time = controller
                              .subTransactionModel[index]
                              .status!
                              .blockTime ==
                              null
                              ? ''
                              : DateTime.fromMillisecondsSinceEpoch(
                              controller
                                  .subTransactionModel[
                              index]
                                  .status!
                                  .blockTime!
                                  .toInt() *
                                  1000)
                              .toString();
                          int value = controller.calculateAddressValue(
                              controller.subTransactionModel[index]);
                          print('difference $value');
                          if (controller.subTransactionModel[index]
                              .status!.blockTime !=
                              null) {
                            List<String> date = time.split(" ");
                            String singleDate = date[0];
                            String times = date[1];
                            List<String> splitTime = times.split(":");

                            String hour = splitTime[0];
                            String min = splitTime[1];
                            time = '$singleDate $hour:$min';
                          }
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        controller.txID = controller
                                            .subTransactionModel[index]
                                            .txid!;
                                        Get.to(
                                            const SingleTransactionScreen(),
                                            arguments: controller
                                                .subTransactionModel[
                                            index]
                                                .txid);
                                        await controller
                                            .getSingleTransaction(
                                            controller
                                                .subTransactionModel[
                                            index]
                                                .txid!);
                                      },
                                      child: Text(
                                        '${controller.subTransactionModel[index].txid!.substring(0, 15)}...${controller.subTransactionModel[index].txid!.substring(controller.subTransactionModel[index].txid!.length - 5)}' ??
                                            '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.blue,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Text(
                                    '$time' ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                    BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Inputs',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    ListView.builder(
                                        padding: EdgeInsets.zero,

                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .subTransactionModel[index]
                                            .vin!
                                            .length,
                                        itemBuilder: (context, index2) {
                                          return Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration:
                                                    BoxDecoration(
                                                      color: controller
                                                          .subTransactionModel[
                                                      index]
                                                          .vin![
                                                      index2]
                                                          .isCoinbase!
                                                          ? Colors.green
                                                          : Colors.red,
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
                                                  const SizedBox(
                                                      width: 10),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller.getAddressComponent(controller
                                                            .subTransactionModel[
                                                        index]
                                                            .vin![
                                                        index2]
                                                            .prevout!
                                                            .scriptpubkeyAddress);
                                                        controller
                                                            .addressId = controller
                                                            .subTransactionModel[
                                                        index]
                                                            .vin![
                                                        index2]
                                                            .prevout!
                                                            .scriptpubkeyAddress ??
                                                            '';
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                    AddressComponent()));
                                                      },
                                                      child: Text(
                                                        '${controller.subTransactionModel[index].vin![index2].prevout!.scriptpubkeyAddress!.substring(0, 15)} ...${controller.subTransactionModel[index].vin![index2].prevout!.scriptpubkeyAddress!.substring(controller.subTransactionModel[index].vin![index2].prevout!.scriptpubkeyAddress!.length - 5)}' ??
                                                            '',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: Colors
                                                                .blue,
                                                            fontSize:
                                                            12),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width: 30),
                                                  Obx(() {
                                                    return controller
                                                        .isShowBTC
                                                        .value
                                                        ? Text(
                                                      '${(controller.subTransactionModel[index].vin![index2].prevout!.value! / 100000000).toStringAsFixed(8)} BTC' ??
                                                          '',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          12),
                                                    )
                                                        : Text(
                                                      '\$${((controller.subTransactionModel[index].vin![index2].prevout!.value! / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}' ??
                                                          '',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color: Colors
                                                              .white,
                                                          fontSize:
                                                          12),
                                                    );
                                                  })
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: 10),
                                            ],
                                          );
                                        }),
                                    const Text(
                                      'Outputs',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                          return Column(
                                            children: [
                                              Obx(() {
                                                return controller
                                                    .isLoadingOutSpends
                                                    .value
                                                    ? const Text('Loading')
                                                    : ListView.builder(
                                                    padding: EdgeInsets.zero,

                                                    physics:
                                                    const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: controller
                                                        .subTransactionModel[
                                                    index]
                                                        .vout!
                                                        .length <
                                                        12
                                                        ? controller
                                                        .subTransactionModel[
                                                    index]
                                                        .vout!
                                                        .length
                                                        : !isShowMore
                                                        ? 12
                                                        : controller
                                                        .subTransactionModel[
                                                    index]
                                                        .vout!
                                                        .length,
                                                    itemBuilder:
                                                        (context,
                                                        index2) {
                                                      final result = OutspendsModel
                                                          .fromJson(controller
                                                          .dataOutSpents
                                                          .data[index]
                                                      [index2]);
                                                      return Column(
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                InkWell(
                                                                  onTap:
                                                                      () {
                                                                    controller.getAddressComponent(controller.subTransactionModel[index].vout![index2].scriptpubkeyAddress);
                                                                    controller.addressId =
                                                                        controller.subTransactionModel[index].vout![index2].scriptpubkeyAddress ?? '';
                                                                    Navigator.push(context,
                                                                        MaterialPageRoute(builder: (context) => AddressComponent()));
                                                                  },
                                                                  child:
                                                                  Text(
                                                                    controller.subTransactionModel[index].vout![index2].scriptpubkeyAddress == null && controller.subTransactionModel[index].vout![index2].scriptpubkeyType == "op_return"
                                                                        ? 'OP_RETURN (R)'
                                                                        : '${controller.subTransactionModel[index].vout![index2].scriptpubkeyAddress!.substring(0, 15)}...${controller.subTransactionModel[index].vout![index2].scriptpubkeyAddress!.substring(controller.subTransactionModel[index].vout![index2].scriptpubkeyAddress!.length - 5)}' ?? '',
                                                                    style: const TextStyle(
                                                                        fontWeight: FontWeight.w600,
                                                                        color: Colors.blue,
                                                                        fontSize: 12),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width:
                                                                  30),
                                                              Obx(
                                                                    () {
                                                                  return controller.isShowBTC.value
                                                                      ? Text(
                                                                    '${(controller.subTransactionModel[index].vout![index2].value! / 100000000).toStringAsFixed(8)} BTC' ?? '',
                                                                    style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 12),
                                                                  )
                                                                      : Text(
                                                                    '\$${((controller.subTransactionModel[index].vout![index2].value! / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                                                                    style: TextStyle(color: Colors.white),
                                                                  );
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                width:
                                                                10,
                                                              ),
                                                              Container(
                                                                height:
                                                                20,
                                                                width:
                                                                20,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: result.spent!
                                                                      ? Colors.red
                                                                      : !result.spent! && controller.subTransactionModel[index].vout![index2].scriptpubkeyType != "op_return"
                                                                      ? Colors.green
                                                                      : Colors.grey,
                                                                  shape:
                                                                  BoxShape.circle,
                                                                ),
                                                                child: const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .arrow_forward_outlined,
                                                                      size:
                                                                      15,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height:
                                                              10),
                                                        ],
                                                      );
                                                    });
                                              }),
                                              const SizedBox(height: 10),
                                              isShowMore ||
                                                  controller
                                                      .subTransactionModel[
                                                  index]
                                                      .vout!
                                                      .length <
                                                      12
                                                  ? const SizedBox.shrink()
                                                  : InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    isShowMore = true;
                                                  });
                                                },
                                                child: Container(
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        10,
                                                        vertical:
                                                        5),
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .blue,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5)),
                                                    child: Text(
                                                        'Show all ${controller.subTransactionModel[index].vout!.length - 12} remaining')),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          );
                                        }),
                                    Row(
                                      children: [
                                        Text(
                                          '${(controller.subTransactionModel[index].fee! / (controller.subTransactionModel[index].weight! / 4)).toStringAsFixed(1)} sat/vB -${controller.formatPrice(controller.subTransactionModel[index].fee.toString())} sat',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '\$${feeUsd}',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10,
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                                color: controller
                                                    .subTransactionModel[
                                                index]
                                                    .status!
                                                    .confirmed ??
                                                    false
                                                    ? Colors.green
                                                    : Colors.red,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(5)),
                                            child: Center(
                                              child: Text(
                                                controller
                                                    .subTransactionModel[
                                                index]
                                                    .status!
                                                    .confirmed ??
                                                    false
                                                    ? confirmation == 0
                                                    ? 'Confirmed'
                                                    : '$confirmation Confirmations'
                                                    : 'Unconfirmed',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight
                                                        .w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Obx(() {
                                            return InkWell(
                                              onTap: () async {
                                                await controller
                                                    .dollarRate();
                                                controller.isShowBTC
                                                    .value =
                                                !controller
                                                    .isShowBTC
                                                    .value;
                                              },
                                              child: Container(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: value
                                                          .isNegative
                                                          ? Colors.red
                                                          : Colors
                                                          .green,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5)),
                                                  child: controller
                                                      .isShowBTC
                                                      .value
                                                      ? Center(
                                                      child: Text(
                                                        value.isNegative
                                                            ? '${(value / 100000000).toStringAsFixed(8)} BTC'
                                                            : '+${(value / 100000000).toStringAsFixed(8)} BTC',
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ))
                                                      : Center(
                                                      child: Text(
                                                        value.isNegative
                                                            ? '\$${((value / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}'
                                                            : '+\$${((value / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ))),
                                            );
                                          }),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  NumberPaginator(
                    numberPages: (controller.addressComponentModel!
                        .chainStats.txCount +
                        controller.addressComponentModel!
                            .mempoolStats.txCount) ~/
                        10 +
                        1,
                    onPageChange: (int index) {
                      controller.changePage(index + 1);
                      controller.getSubMoreTransaction();
                    },
                    showPrevButton: false,
                    showNextButton: false,
                    nextButtonContent: const Icon(Icons.arrow_right_alt),
                  ),
                ],
              ),
            ),
          ),

      ),
    );
  }
}
