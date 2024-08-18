import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
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

  final TextFieldController = TextEditingController();
  handleSearch(String query) {}

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.blockTransaction,
        context: context,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 3,
            ),
            Container(
              child: SearchFieldWidget(
                onChanged: (value) {
                  controller.isLoadingTx.value = true;
                  if (value.isEmpty) {
                    controller.txDetails = controller.txDetailsReset;
                  } else {
                    controller.txDetails.clear;
                    controller.txDetails = controller.txDetailsFound
                        .where((element) => element.txid == value)
                        .toList();
                  }
                  controller.isLoadingTx.value = false;
                },
                hintText:
                    '${controller.bitcoinData[controller.indexBlock.value].txCount} transactions',
                handleSearch: handleSearch,
                isSearchEnabled: true,
              ),
            ),
            // NumberPaginator(
            //   numberPages: controller
            //           .bitcoinData[controller.indexBlock.value].txCount! ~/
            //       25,
            //   onPageChange: (int index) {
            //     setState(() {
            //       _currentPage = index;
            //       controller.txDetailsF(
            //           controller.bitcoinData[controller.indexBlock.value].id!,
            //           index * 25);
            //     });
            //   },
            //   showPrevButton: true,
            //   showNextButton: true,
            //   nextButtonContent: Icon(
            //     Icons.arrow_right_alt,
            //     color: AppTheme.white70,
            //   ),
            // ),
            controller.isLoadingTx.value
                ?  Center(
                    child: dotProgress(context),
                  )
                : controller.txDetails.isEmpty
                    ? const SizedBox()
            //the listview builder has some space for the bottom
                    : ListView.builder(
                        //padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.txDetails.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: AppTheme.cardPadding * 0.5,
                              left: AppTheme.elementSpacing,
                              right: AppTheme.elementSpacing,
                            ),
                            child: GlassContainer(
                              child: Column(
                                children: [
                                  BitNetListTile(
                                    leading: Icon(
                                      size: AppTheme.cardPadding * 0.75,
                                      Icons.copy_outlined,
                                      color: AppTheme.white80,
                                    ),
                                    text: controller.txDetails.isEmpty
                                        ? ''
                                        : '${controller.txDetails[index].txid.substring(0, 8)}...${controller.txDetails[index].txid.substring(controller.txDetails[index].txid.length - 5)}',
                                    trailing: controller
                                                .txDetails[index].locktime >
                                            0
                                        ? Text(DateFormat('yyyy-MM-dd hh:mm')
                                            .format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    controller.txDetails[index]
                                                            .locktime *
                                                        1000)))
                                        : Text(DateFormat('yyyy-MM-dd hh:mm')
                                            .format(DateTime.now())),
                                    onTap: () async {
                                      await Clipboard.setData(ClipboardData(
                                        text: controller.txDetails[index].txid,
                                      ));
                                      Get.snackbar(
                                          L10n.of(context)!.copiedToClipboard,
                                          controller.txDetails[index].txid);
                                    },
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.elementSpacing * 1.25,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(children: [
                                          controller.txDetails[index].vin.first
                                                  .isCoinbase
                                              ? Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                            .txDetails[index]
                                                            .vin
                                                            .first
                                                            .isCoinbase
                                                        ? Colors.grey
                                                        : Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons
                                                        .arrow_forward_outlined,
                                                    size: 15,
                                                    color: Colors.white,
                                                  )),
                                                )
                                              : SizedBox(),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          controller.txDetails[index].vin.first
                                                  .isCoinbase
                                              ? SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    controller
                                                            .txDetails[index]
                                                            .vin
                                                            .first
                                                            .isCoinbase
                                                        ? '${L10n.of(context)!.coinBase}'
                                                            '${controller.hex2ascii(controller.txDetails[index].vin.first.scriptsig.substring(0, 50))}'
                                                        : '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ]),
                                        const SizedBox(
                                            height: AppTheme.elementSpacing),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: controller
                                                .txDetails[index].vin.length,
                                            itemBuilder: (context, i) {
                                              return controller.txDetails[index]
                                                          .vin[i].prevout ==
                                                      null
                                                  ? const SizedBox()
                                                  : Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: controller
                                                                              .txDetails[index]
                                                                              .vin[i]
                                                                              .isCoinbase
                                                                          ? Colors.grey
                                                                          : Colors.red,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_outlined,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: AppTheme
                                                                            .elementSpacing /
                                                                        2,
                                                                  ),
                                                                  Text(
                                                                    '${controller.txDetails[index].vin[i].prevout!.scriptpubkeyAddress!.substring(0, 10)}...'
                                                                    '${controller.txDetails[index].vin[i].prevout!.scriptpubkeyAddress!.substring(controller.txDetails[index].vin[i].prevout!.scriptpubkeyAddress!.length - 10)}',
                                                                    style: TextStyle(
                                                                        color: AppTheme
                                                                            .white70),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Text(controller
                                                                    .isBTC.value
                                                                ? '${controller.txDetails[index].vin[i].prevout!.value / 100000000} BTC'
                                                                : '\$${controller.formatAmount(((controller.txDetails[index].vin[i].prevout!.value / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}  ')
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                            }),
                                        const SizedBox(
                                          height: AppTheme.elementSpacing,
                                        ),
                                        controller.txDetails[index].vin.first
                                                .isCoinbase
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
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
                                                      SizedBox(width:  AppTheme.elementSpacing / 2,),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(vertical: 5),
                                                        child: Row(
                                                          children: [
                                                            controller
                                                                .txDetails[
                                                            index]
                                                                .vout
                                                                .first
                                                                .scriptpubkeyAddress ==
                                                                null
                                                                ? const Text('')
                                                                : Text(
                                                              '${controller.txDetails[index].vout.first.scriptpubkeyAddress!.substring(0, 10)}...${controller.txDetails[index].vout.first.scriptpubkeyAddress!.substring(controller.txDetails[index].vout.first.scriptpubkeyAddress!.length - 10)}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white70),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text(controller
                                                              .isBTC.value
                                                          ? '${controller.txDetails[index].vout.first.value / 100000000} BTC'
                                                          : '\$${controller.formatAmount(((controller.txDetails[index].vout.first.value / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}  '),

                                                    ],
                                                  )
                                                ],
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .txDetails[index]
                                                    .vout
                                                    .length,
                                                itemBuilder: (context, j) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
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
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .green,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Center(
                                                                child: Icon(
                                                              Icons
                                                                  .arrow_forward_outlined,
                                                              size: 15,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: controller
                                                                        .txDetails[
                                                                            index]
                                                                        .vout
                                                                        .first
                                                                        .scriptpubkeyAddress ==
                                                                    null
                                                                ? const Text('')
                                                                : Text(
                                                                    controller.txDetails[index].vout[j].scriptpubkeyAddress ==
                                                                            null
                                                                        ? ''
                                                                        : '${controller.txDetails[index].vout[j].scriptpubkeyAddress.toString().substring(0, 10)}...${controller.txDetails[index].vout[j].scriptpubkeyAddress.toString().substring(controller.txDetails[index].vout[j].scriptpubkeyAddress!.length - 10)}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white70),
                                                                  ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(controller
                                                              .isBTC.value
                                                          ? '${controller.txDetails[index].vout[j].value / 100000000} BTC'
                                                          : '\$${controller.formatAmount(((controller.txDetails[index].vout[j].value / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}  ')
                                                    ],
                                                  );
                                                }),
                                        controller.txDetails[index].vin.first
                                                .isCoinbase
                                            ? Row(
                                                children: [
                                                  Container(
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
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: AppTheme.elementSpacing / 2,),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      'OP_RETURN ${(controller.txDetails[index].vout.where((element) => element.scriptpubkeyType == 'op_return' && element.scriptpubkeyAsm != 'OP_RETURN').isNotEmpty ? controller.txDetails[index].vout.where((element) => element.scriptpubkeyType == 'op_return' && element.scriptpubkeyAsm != 'OP_RETURN').first.scriptpubkeyAsm : '')}...',
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      const Text('\$0.00'),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: AppTheme.elementSpacing,
                                        ),
                                        controller.txDetails[index].vin[0]
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
                                                      // Text(
                                                      //   '${(controller.txDetails[index].fee / (controller.txDetails[index].weight / 4)).toStringAsFixed(0)} ',
                                                      //   style: const TextStyle(
                                                      //       color: Colors.white),
                                                      // ),
                                                      // const Text(
                                                      //   'sat/vB ',
                                                      //   style: TextStyle(
                                                      //       color: Colors.grey),
                                                      // ),
                                                      // Text(
                                                      //   '- ${controller.formatAmount(controller.txDetails[index].fee.toString())}',
                                                      //   style: const TextStyle(
                                                      //       color: Colors.white),
                                                      // ),
                                                      // const Text(
                                                      //   ' sat ',
                                                      //   style: TextStyle(
                                                      //       color: Colors.grey),
                                                      // ),
                                                      Text("Fee"),
                                                      SizedBox(
                                                        width: AppTheme
                                                                .elementSpacing /
                                                            2,
                                                      ),
                                                      Text(
                                                        '\$${(((controller.txDetails[index].fee / (controller.txDetails[index].weight / 4)) * 140) / 100000000 * controller.currentUSD.value).toStringAsFixed(2)}',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.isBTC.value =
                                                          !controller
                                                              .isBTC.value;
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: AppTheme
                                                              .elementSpacing,
                                                          vertical: AppTheme
                                                                  .elementSpacing /
                                                              2),
                                                      decoration: BoxDecoration(
                                                        borderRadius: AppTheme
                                                            .cardRadiusSmall,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                      ),
                                                      child: Text(
                                                        controller.isBTC.value
                                                            ? '${((controller.txDetails[index].vin[0].prevout!.value / 100000000)).toStringAsFixed(8)} BTC'
                                                            : '\$${controller.formatAmount(((controller.txDetails[index].vin[0].prevout!.value / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}',
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        SizedBox(
                                          height: AppTheme.elementSpacing,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
            // NumberPaginator(
            //   numberPages: controller
            //           .bitcoinData[controller.indexBlock.value].txCount! ~/
            //       25,
            //   onPageChange: (int index) {
            //     setState(() {
            //       _currentPage = index;
            //       controller.txDetailsF(
            //           controller.bitcoinData[controller.indexBlock.value].id!,
            //           index * 25);
            //     });
            //   },
            //   showPrevButton: true,
            //   showNextButton: true,
            //   nextButtonContent: const Icon(
            //     Icons.arrow_right_alt,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
      context: context,
    );
  }
}
