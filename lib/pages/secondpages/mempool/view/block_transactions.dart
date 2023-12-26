import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/bitnetAppBar.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';

class BlockTransactions extends StatefulWidget {
  const BlockTransactions({super.key});

  @override
  State<BlockTransactions> createState() => _BlockTransactionsState();
}

class _BlockTransactionsState extends State<BlockTransactions> {
  final controller = Get.put(HomeController());
  final NumberPaginatorController _controller = NumberPaginatorController();
  int _currentPage = 0;
  String selectedOption = 'Transaction';
  final TextFieldController = TextEditingController();
  handleSearch(String query) {}

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      appBar: bitnetAppBar(
        text: 'Block Transactions',
        context: context,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchFieldWidget(
              onChanged: (value) {
                controller.isLoadingTx.value = true;
                if (value.isEmpty) {
                  controller.txDetails =
                      controller.txDetailsReset;
                } else {
                  controller.txDetails.clear;
                  controller.txDetails = controller
                      .txDetailsFound
                      .where((element) =>
                  element.txid == value)
                      .toList();
                }
                controller.isLoadingTx.value = false;
              },
              hintText: '${controller.bitcoinData[controller.indexBlock.value].txCount} transactions',
              handleSearch: handleSearch,
              isSearchEnabled: true,
            ),
            NumberPaginator(
              numberPages: controller
                  .bitcoinData[
              controller.indexBlock.value]
                  .txCount! ~/
                  25,
              onPageChange: (int index) {
                setState(() {
                  _currentPage = index;
                  controller.txDetailsF(
                      controller
                          .bitcoinData[
                      controller.indexBlock.value]
                          .id!,
                      index * 25);
                });
              },
              showPrevButton: true,
              showNextButton: true,
              nextButtonContent:
              const Icon(Icons.arrow_right_alt,
              color: Colors.white,),
            ),
            controller.isLoadingTx.value
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : controller.txDetails.isEmpty
                ? const SizedBox()
                : ListView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                itemCount:
                controller.txDetails.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets
                            .symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        margin: const EdgeInsets
                            .symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(children: [
                          GestureDetector(
                            onTap: () async {
                              await Clipboard
                                  .setData(
                                  ClipboardData(
                                    text: controller
                                        .txDetails[
                                    index]
                                        .txid,
                                  ));
                              Get.snackbar(
                                  'Copied',
                                  controller
                                      .txDetails[
                                  index]
                                      .txid);
                            },
                            child: Row(
                              children: [
                                Text(
                                  controller
                                      .txDetails
                                      .isEmpty
                                      ? ''
                                      : '${controller.txDetails[index].txid.substring(0, 10)}...${controller.txDetails[index].txid.substring(controller.txDetails[index].txid.length - 10)}',
                                  style: TextStyle(
                                    color: Colors
                                        .blue
                                        .shade400,
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons
                                      .copy_outlined,
                                  color: Colors.blue
                                      .shade400,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          controller
                              .txDetails[
                          index]
                              .locktime >
                              0
                              ? Text(DateFormat(
                              'yyyy-MM-dd hh:mm')
                              .format(DateTime.fromMillisecondsSinceEpoch(controller
                              .txDetails[
                          index]
                              .locktime *
                              1000)))
                              : Text(DateFormat(
                              'yyyy-MM-dd hh:mm')
                              .format(DateTime
                              .now()))
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets
                            .symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        margin: const EdgeInsets
                            .symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Row(children: [
                              controller
                                  .txDetails[
                              index]
                                  .vin
                                  .first
                                  .isCoinbase
                                  ? Container(
                                height: 20,
                                width: 20,
                                decoration:
                                BoxDecoration(
                                  color: controller
                                      .txDetails[
                                  index]
                                      .vin
                                      .first
                                      .isCoinbase
                                      ? Colors
                                      .grey
                                      : Colors
                                      .red,
                                  shape: BoxShape
                                      .circle,
                                ),
                                child:
                                const Center(
                                    child:
                                    Icon(
                                      Icons.arrow_forward_outlined,
                                      size: 15,
                                      color: Colors.white,
                                    )),
                              )
                                  : SizedBox(),
                              const SizedBox(
                                width: 5,
                              ),
                              controller
                                  .txDetails[
                              index]
                                  .vin
                                  .first
                                  .isCoinbase
                                  ? SizedBox(
                                width: 200,
                                child: Text(
                                  controller
                                      .txDetails[index]
                                      .vin
                                      .first
                                      .isCoinbase
                                      ? 'Coinbase (Newly Generated Coins)\n'
                                      '${controller.hex2ascii(controller.txDetails[index].vin.first.scriptsig.substring(0, 50))}'
                                      : '',
                                  style:
                                  const TextStyle(
                                    color: Colors
                                        .white,
                                    fontSize:
                                    12,
                                    fontWeight:
                                    FontWeight
                                        .w400,
                                  ),
                                ),
                              )
                                  : SizedBox(),
                            ]),
                            const SizedBox(
                                height: 10),
                            ListView.builder(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount:
                                controller
                                    .txDetails[
                                index]
                                    .vin
                                    .length,
                                itemBuilder:
                                    (context, i) {
                                  return controller
                                      .txDetails[
                                  index]
                                      .vin[
                                  i]
                                      .prevout ==
                                      null
                                      ? const SizedBox()
                                      : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color: controller.txDetails[index].vin[i].isCoinbase ? Colors.grey : Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.arrow_forward_outlined,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${controller.txDetails[index].vin[i].prevout!.scriptpubkeyAddress!.substring(0, 10)}...'
                                                      '${controller.txDetails[index].vin[i].prevout!.scriptpubkeyAddress!.substring(controller.txDetails[index].vin[i].prevout!.scriptpubkeyAddress!.length - 10)}',
                                                  style: const TextStyle(color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(controller.isBTC.value
                                              ? '${controller.txDetails[index].vin[i].prevout!.value / 100000000} BTC'
                                              : '\$${controller.formatAmount(((controller.txDetails[index].vin[i].prevout!.value / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}  ')
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            controller
                                .txDetails[
                            index]
                                .vin
                                .first
                                .isCoinbase
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      vertical:
                                      5),
                                  child: Row(
                                    children: [
                                      controller.txDetails[index].vout.first.scriptpubkeyAddress ==
                                          null
                                          ? const Text('')
                                          : Text(
                                        '${controller.txDetails[index].vout.first.scriptpubkeyAddress!.substring(0, 10)}...${controller.txDetails[index].vout.first.scriptpubkeyAddress!.substring(controller.txDetails[index].vout.first.scriptpubkeyAddress!.length - 10)}',
                                        style: const TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(controller
                                        .isBTC
                                        .value
                                        ? '${controller.txDetails[index].vout.first.value / 100000000} BTC'
                                        : '\$${controller.formatAmount(((controller.txDetails[index].vout.first.value / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}  '),
                                    const SizedBox(
                                      width:
                                      5,
                                    ),
                                    Container(
                                      height:
                                      20,
                                      width:
                                      20,
                                      decoration:
                                      BoxDecoration(
                                        color: controller.txDetails[index].vin.first.isCoinbase
                                            ? Colors.grey
                                            : Colors.green,
                                        shape:
                                        BoxShape.circle,
                                      ),
                                      child: const Center(
                                          child: Icon(
                                            Icons
                                                .arrow_forward_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            )
                                : ListView.builder(
                                shrinkWrap:
                                true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: controller
                                    .txDetails[
                                index]
                                    .vout
                                    .length,
                                itemBuilder:
                                    (context,
                                    j) {
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: controller.txDetails[index].vout.first.scriptpubkeyAddress ==
                                            null
                                            ? const Text('')
                                            : Text(
                                          controller.txDetails[index].vout[j].scriptpubkeyAddress == null ? '' : '${controller.txDetails[index].vout[j].scriptpubkeyAddress.toString().substring(0, 10)}...${controller.txDetails[index].vout[j].scriptpubkeyAddress.toString().substring(controller.txDetails[index].vout[j].scriptpubkeyAddress!.length - 10)}',
                                          style: const TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(controller.isBTC.value
                                              ? '${controller.txDetails[index].vout[j].value / 100000000} BTC'
                                              : '\$${controller.formatAmount(((controller.txDetails[index].vout[j].value / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}  '),
                                          const SizedBox(
                                            width:
                                            5,
                                          ),
                                          Container(
                                            height:
                                            20,
                                            width:
                                            20,
                                            decoration:
                                            BoxDecoration(
                                              color: controller.txDetails[index].vin.first.isCoinbase ? Colors.grey : Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                                child: Icon(
                                                  Icons.arrow_forward_outlined,
                                                  size: 15,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                }),
                            controller
                                .txDetails[
                            index]
                                .vin
                                .first
                                .isCoinbase
                                ? Row(
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    'OP_RETURN ${(controller.txDetails[index].vout.where((element) => element.scriptpubkeyType == 'op_return' && element.scriptpubkeyAsm != 'OP_RETURN').isNotEmpty ? controller.txDetails[index].vout.where((element) => element.scriptpubkeyType == 'op_return' && element.scriptpubkeyAsm != 'OP_RETURN').first.scriptpubkeyAsm : '')}...',
                                    style: const TextStyle(
                                        fontSize:
                                        12),
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    const Text(
                                        '\$0.00'),
                                    const SizedBox(
                                      width:
                                      5,
                                    ),
                                    Container(
                                      height:
                                      20,
                                      width:
                                      20,
                                      decoration:
                                      BoxDecoration(
                                        color: controller.txDetails[index].vin.first.isCoinbase
                                            ? Colors.grey
                                            : Colors.green,
                                        shape:
                                        BoxShape.circle,
                                      ),
                                      child:
                                      const Center(
                                        child:
                                        Icon(
                                          Icons.arrow_forward_outlined,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            controller
                                .txDetails[
                            index]
                                .vin[0]
                                .prevout ==
                                null
                                ? const SizedBox()
                                : Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${(controller.txDetails[index].fee / (controller.txDetails[index].weight / 4)).toStringAsFixed(0)} ',
                                      style: const TextStyle(
                                          color:
                                          Colors.white),
                                    ),
                                    const Text(
                                      'sat/vB ',
                                      style: TextStyle(
                                          color:
                                          Colors.grey),
                                    ),
                                    Text(
                                      '- ${controller.formatAmount(controller.txDetails[index].fee.toString())}',
                                      style: const TextStyle(
                                          color:
                                          Colors.white),
                                    ),
                                    const Text(
                                      ' sat ',
                                      style: TextStyle(
                                          color:
                                          Colors.grey),
                                    ),
                                    Text(
                                      '\$ ${(((controller.txDetails[index].fee / (controller.txDetails[index].weight / 4)) * 140) / 100000000 * controller.currentUSD.value).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          color:
                                          Colors.green),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller
                                        .isBTC
                                        .value =
                                    !controller
                                        .isBTC
                                        .value;
                                  },
                                  child:
                                  Container(
                                    padding: const EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        5,
                                        vertical:
                                        5),
                                    decoration:
                                    BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(4),
                                      color: Colors
                                          .blue,
                                    ),
                                    child:
                                    Text(
                                      controller.isBTC.value
                                          ? '${((controller.txDetails[index].vin[0].prevout!.value / 100000000)).toStringAsFixed(8)} BTC'
                                          : '\$${controller.formatAmount(((controller.txDetails[index].vin[0].prevout!.value / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}',
                                      style:
                                      const TextStyle(
                                        color:
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            NumberPaginator(
              numberPages: controller
                  .bitcoinData[
              controller.indexBlock.value]
                  .txCount! ~/
                  25,
              onPageChange: (int index) {
                setState(() {
                  _currentPage = index;
                  controller.txDetailsF(
                      controller
                          .bitcoinData[
                      controller.indexBlock.value]
                          .id!,
                      index * 25);
                });
              },
              showPrevButton: true,
              showNextButton: true,
              nextButtonContent:
              const Icon(
                Icons.arrow_right_alt,
                color: Colors.white,),
            ),
          ],
        ),
      ), context: context,
    );
  }
}
