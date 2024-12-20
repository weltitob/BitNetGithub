import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/secondpages/mempool/colorhelper.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/widget/data_widget.dart';
import 'package:bitnet/pages/secondpages/transactionsscreen.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MempoolHome extends StatefulWidget {
  bool? isFromHome = false;
  MempoolHome({this.isFromHome, Key? key}) : super(key: key);

  @override
  State<MempoolHome> createState() => _MempoolHomeState();
}

class _MempoolHomeState extends State<MempoolHome> {
  final controller = Get.put(HomeController());
  final TextFieldController = TextEditingController();
  //final transactionCtrl = Get.put(TransactionController());
  final ScrollController _controller = ScrollController();
  final ScrollController listScrollController = ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  List<BitcoinTransaction> onchainTransactions = List.empty(growable: true);
  List<BitcoinTransaction> onchainTransactionsFull = List.empty(growable: true);

  handleSearch(String query) {
    return query;
  }

  final key1 = GlobalKey();

  Future<void> getDataBlockHeightSearch() async {
    if (controller.blockHeight != null) {
      controller.isLoading.value = true;
      controller.bitcoinData.clear();
      await controller.getDataHeight(controller.blockHeight! + 15);
      await controller.getDataHeight(controller.blockHeight!);
      await controller.getDataHeight(controller.blockHeight! - 15);
      controller.indexBlock.value = controller.bitcoinData
          .indexWhere((e) => e.height == controller.blockHeight);
      controller.selectedIndex = controller.bitcoinData
          .indexWhere((e) => e.height == controller.blockHeight);
      controller
          .txDetailsConfirmedF(
              controller.bitcoinData[controller.indexBlock.value].id!)
          .then((_) async {
        Map<String, dynamic> data =
            Get.find<WalletsController>().onchainTransactions;
        if (data.isNotEmpty) {
          onchainTransactions = await Future.microtask(() {
            BitcoinTransactionsList bitcoinTransactions =
                BitcoinTransactionsList.fromJson(data);

            return bitcoinTransactions.transactions
                .where(
                    (tx) => tx.blockHash == controller.txDetailsConfirmed!.id)
                .sorted((tx, tx1) => tx.timeStamp > tx1.timeStamp)
                .toList();
          });
        }
      });
      controller.txDetailsF(
          controller.bitcoinData[controller.indexBlock.value].id!, 0);
      controller.isLoading.value = false;
      _controller.animateTo(
        controller.scrollValue.value.w +
            (140.w * controller.indexBlock.value).w,
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(
        () {
          controller.showBlock.value = true;
          controller.showNextBlock.value = false;
          controller.indexBlock.value = 0;
          controller.selectedIndex = 0;
          controller.selectedIndexData = -1;
        },
      );
    });
    getDataBlockHeightSearch();
    if (controller.blockHeight == null)
      Future.delayed(
        const Duration(seconds: 3),
        () {
          // Scrollable.ensureVisible(key1.currentContext!,
          //     curve: AppTheme.animationCurve, );

          _controller.animateTo(
            controller.scrollValue.value.w,
            duration: const Duration(
              milliseconds: 500,
            ),
            curve: Curves.easeInOut,
          );
        },
      );
    Map<String, dynamic> data =
        Get.find<WalletsController>().onchainTransactions;
    if (data.isNotEmpty) {
      Future.microtask(() {
        BitcoinTransactionsList bitcoinTransactions =
            BitcoinTransactionsList.fromJson(data);

        return bitcoinTransactions.transactions;
      }).then((val) {
        onchainTransactionsFull = val;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (v) {
        // controller.timer.cancel()
        context.pop(context);
      },
      child: SafeArea(
        child: bitnetScaffold(
          extendBodyBehindAppBar: true,
          context: context,
          appBar: widget.isFromHome == true
              ? const PreferredSize(
                  preferredSize: Size(0, 0),
                  child: SizedBox(),
                )
              : bitnetAppBar(
                  text: L10n.of(context)!.blockChain,
                  onTap: () {
                    // controller.timer.cancel();
                    context.pop(context);
                  },
                  context: context,
                ),
          body: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: AppTheme.cardPadding.h * 2.75,),
                  controller.socketLoading.isTrue
                      ? Padding(
                          padding: const EdgeInsets.only(
                            top: AppTheme.cardPadding * 15,
                          ),
                          child: Center(
                            child: dotProgress(context),
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: AppTheme.cardPadding.h * 0.1.h,
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(
                            //       left: AppTheme.cardPadding),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Text(
                            //         L10n.of(context)!.blockChain,
                            //         style:
                            //             Theme.of(context).textTheme.titleLarge,
                            //       ),
                            //       Row(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.center,
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Text(
                            //             'av. block time:',
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .bodySmall,
                            //           ),
                            //           SizedBox(
                            //             width: AppTheme.elementSpacing,
                            //           ),
                            //           Text(
                            //             '~  ${(controller.da == null ? 10 : controller.da!.timeAvg! / 60000).toStringAsFixed(1)} minutes',
                            //             overflow: TextOverflow.ellipsis,
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .bodyMedium,
                            //           ),
                            //           SizedBox(
                            //             width: AppTheme.elementSpacing,
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: AppTheme.cardPadding.h,
                            // ),
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                SingleChildScrollView(
                                  primary: false,
                                  controller: _controller,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                    children: [
                                      Obx(
                                        () {
                                          return controller.isLoading.isTrue
                                              ? dotProgress(context)
                                              : controller.mempoolBlocks.isEmpty
                                                  ? const Text(
                                                      'Something went wrong!',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 22,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 255,
                                                      child: ListView.builder(
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        reverse: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: controller
                                                            .mempoolBlocks
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var min = (index +
                                                                  1) *
                                                              (controller.da!
                                                                      .timeAvg! /
                                                                  60000);
                                                          return GestureDetector(
                                                            onTap: () {
                                                              channel.sink.add(
                                                                  '{"track-mempool-block":$index}');
                                                              setState(
                                                                () {
                                                                  controller
                                                                      .showNextBlock
                                                                      .value = true;
                                                                  controller
                                                                      .showBlock
                                                                      .value = false;
                                                                  controller
                                                                      .indexShowBlock
                                                                      .value = index;
                                                                  controller
                                                                          .selectedIndexData =
                                                                      index;
                                                                  controller
                                                                      .selectedIndex = -1;
                                                                },
                                                              );
                                                              // controller.getWebSocketData();
                                                            },
                                                            child: Flash(
                                                              infinite: true,
                                                              delay:
                                                                  const Duration(
                                                                      seconds:
                                                                          10),
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          5),
                                                              child: DataWidget.notAccepted(
                                                                  key: index == 0
                                                                      ? controller
                                                                          .containerKey
                                                                      : GlobalKey(),
                                                                  mempoolBlocks:
                                                                      controller
                                                                              .mempoolBlocks[
                                                                          index],
                                                                  mins: min
                                                                      .toStringAsFixed(
                                                                          0),
                                                                  index: controller
                                                                              .selectedIndexData ==
                                                                          index
                                                                      ? 1
                                                                      : 0,
                                                                  singleTx:
                                                                      false,
                                                                  hasUserTxs:
                                                                      false),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                        },
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: AppTheme.elementSpacing,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              AppTheme.cardRadiusCircular,
                                          color: Colors.grey,
                                        ),
                                        height: AppTheme.cardPadding * 6,
                                        width: AppTheme.elementSpacing / 3,
                                      ),
                                      Obx(
                                        () {
                                          return controller.isLoading.isTrue
                                              ? dotProgress(context)
                                              : controller.bitcoinData.isEmpty
                                                  ? const Text(
                                                      'Something went wrong!',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 22,
                                                      ),
                                                    )
                                                  : GetBuilder<HomeController>(
                                                      builder: (controller) {
                                                      return SizedBox(
                                                        key: key1,
                                                        height: 255,
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          // itemScrollController:
                                                          //     itemScrollController,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          physics:
                                                              const BouncingScrollPhysics(),
                                                          itemCount: controller
                                                              .bitcoinData
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            double size = controller
                                                                    .bitcoinData[
                                                                        index]
                                                                    .size! /
                                                                1000000;
                                                            controller
                                                                    .isLoadingPage
                                                                    .isTrue
                                                                ? dotProgress(
                                                                    context)
                                                                : null;

                                                            return GestureDetector(
                                                              onTap: () {
                                                                setState(
                                                                  () {
                                                                    controller
                                                                        .showBlock
                                                                        .value = true;
                                                                    controller
                                                                        .showNextBlock
                                                                        .value = false;
                                                                    controller
                                                                        .indexBlock
                                                                        .value = index;
                                                                    controller
                                                                            .selectedIndex =
                                                                        index;
                                                                    controller
                                                                        .selectedIndexData = -1;
                                                                    controller
                                                                        .txDetailsConfirmedF(controller
                                                                            .bitcoinData[
                                                                                index]
                                                                            .id!)
                                                                        .then(
                                                                            (_) async {
                                                                      Map<String,
                                                                              dynamic>
                                                                          data =
                                                                          Get.find<WalletsController>()
                                                                              .onchainTransactions;
                                                                      if (data
                                                                          .isNotEmpty) {
                                                                        onchainTransactions =
                                                                            await Future.microtask(() {
                                                                          BitcoinTransactionsList
                                                                              bitcoinTransactions =
                                                                              BitcoinTransactionsList.fromJson(data);

                                                                          return bitcoinTransactions
                                                                              .transactions
                                                                              .where((tx) => tx.blockHash == controller.txDetailsConfirmed!.id)
                                                                              .sorted((tx, tx1) => tx.timeStamp > tx1.timeStamp)
                                                                              .toList();
                                                                        });
                                                                      }
                                                                    });
                                                                    controller.txDetailsF(
                                                                        controller
                                                                            .bitcoinData[index]
                                                                            .id!,
                                                                        0);
                                                                  },
                                                                );
                                                              },
                                                              child: DataWidget
                                                                  .accepted(
                                                                      blockData: controller
                                                                              .bitcoinData[
                                                                          index],
                                                                      txId: controller
                                                                          .bitcoinData[
                                                                              index]
                                                                          .id,
                                                                      size:
                                                                          size,
                                                                      time: controller
                                                                          .formatTimeAgo(
                                                                        DateTime
                                                                            .fromMillisecondsSinceEpoch(
                                                                          (controller.bitcoinData[index].timestamp! *
                                                                              1000),
                                                                        ),
                                                                      ),
                                                                      index: controller.selectedIndex ==
                                                                              index
                                                                          ? 1
                                                                          : 0,
                                                                      singleTx:
                                                                          false,
                                                                      hasUserTxs: hasUserTxs(controller
                                                                          .bitcoinData[
                                                                              index]
                                                                          .id!)),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                controller.blockHeight != null
                                    ? Align(
                                        alignment: Alignment.bottomLeft,
                                        child: GestureDetector(
                                          onTap: () async {
                                            controller.bitcoinData.clear();
                                            await controller.getData();
                                            setState(
                                              () {
                                                controller.showBlock.value =
                                                    true;
                                                controller.showNextBlock.value =
                                                    false;
                                                controller.indexBlock.value = 0;
                                                controller.selectedIndex = 0;
                                                controller.selectedIndexData =
                                                    -1;
                                              },
                                            );
                                            await controller
                                                .txDetailsConfirmedF(controller
                                                    .bitcoinData.first.id!)
                                                .then((_) async {
                                              Map<String, dynamic> data =
                                                  Get.find<WalletsController>()
                                                      .onchainTransactions;
                                              if (data.isNotEmpty) {
                                                onchainTransactions =
                                                    await Future.microtask(() {
                                                  BitcoinTransactionsList
                                                      bitcoinTransactions =
                                                      BitcoinTransactionsList
                                                          .fromJson(data);

                                                  return bitcoinTransactions
                                                      .transactions
                                                      .where((tx) =>
                                                          tx.blockHash ==
                                                          controller
                                                              .txDetailsConfirmed!
                                                              .id)
                                                      .sorted((tx, tx1) =>
                                                          tx.timeStamp >
                                                          tx1.timeStamp)
                                                      .toList();
                                                });
                                              }
                                            });
                                            ;
                                            await controller.txDetailsF(
                                                controller
                                                    .bitcoinData.first.id!,
                                                0);
                                            _controller.animateTo(
                                                controller.scrollValue.value.w,
                                                duration:
                                                    const Duration(seconds: 2),
                                                curve: Curves.easeInOut);
                                            controller.blockHeight == null;
                                          },
                                          child: Opacity(
                                            opacity: 0.75,
                                            child: Container(
                                              padding: EdgeInsets.all(4.w),
                                              decoration: BoxDecoration(
                                                color: AppTheme.white60,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.arrow_back,
                                                color: AppTheme.colorBackground,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            Obx(
                              () => controller.loadingDetail.value
                                  ? Center(
                                      child: dotProgress(context),
                                    )
                                  : Column(
                                      children: [
                                        Obx(
                                          () => Visibility(
                                            visible:
                                                controller.showNextBlock.value,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: AppTheme.cardPadding,
                                                  bottom:
                                                      AppTheme.elementSpacing,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      controller.selectedIndexData ==
                                                              0
                                                          ? L10n.of(context)!
                                                              .nextBlock
                                                          : '${L10n.of(context)!.mempoolBlock} ${controller.selectedIndexData + 1}',
                                                      textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(
                                                            () {
                                                              controller
                                                                  .showNextBlock
                                                                  .value = false;
                                                              controller
                                                                  .selectedIndex = -1;
                                                              controller
                                                                  .selectedIndexData = -1;
                                                            },
                                                          );
                                                        },
                                                        icon: const Icon(
                                                            Icons.cancel))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //----------------------UNACCEPTED BLOCKS--------------

                                        Obx(
                                          () => Visibility(
                                            visible:
                                                controller.showNextBlock.value,
                                            child: Container(
                                              child: Column(children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    context.go(
                                                        "/wallet/unaccepted_block_transactions");
                                                    //${controller.txDetailsConfirmed!.id}
                                                  },
                                                  //TEXT HIER ZU SEARCH TROUGH 7825 transactions oder so senden...
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: AppTheme
                                                            .cardPadding),
                                                    child: SearchFieldWidget(
                                                      isSearchEnabled: false,
                                                      hintText:
                                                          '${controller.blockTransactions.length} transactions',
                                                      handleSearch:
                                                          handleSearch,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: AppTheme
                                                          .elementSpacing),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: AppTheme
                                                            .cardPadding.h,
                                                      ),
                                                      feeDistributionUnaccepted(),
                                                      const SizedBox(
                                                        height: AppTheme
                                                            .elementSpacing,
                                                      ),
                                                      const SizedBox(
                                                        height: AppTheme
                                                            .elementSpacing,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          controller.txDetailsConfirmed ==
                                                                  null
                                                              ? const SizedBox()
                                                              : blockSizeUnaccepted()
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: AppTheme
                                                                .cardPadding *
                                                            3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),

                                        //-----------------ACCEPTED BLOCKS-----------------

                                        Obx(
                                          () => Visibility(
                                            visible: controller.showBlock.value,
                                            child:
                                                controller
                                                        .bitcoinData.isNotEmpty
                                                    ? Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              left: AppTheme
                                                                  .cardPadding,
                                                              bottom: AppTheme
                                                                  .elementSpacing),
                                                          child: Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    L10n.of(context)!
                                                                        .block,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleLarge,
                                                                  ),
                                                                  Text(
                                                                      ' ${controller.bitcoinData[controller.indexBlock.value].height}',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .titleLarge!
                                                                          .copyWith(
                                                                            color:
                                                                                AppTheme.colorBitcoin,
                                                                          ))
                                                                ],
                                                              ),
                                                              const Spacer(),
                                                              Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Clipboard.setData(ClipboardData(
                                                                          text: controller
                                                                              .txDetailsConfirmed!
                                                                              .id));
                                                                      showOverlay(
                                                                          context,
                                                                          L10n.of(context)!
                                                                              .copiedToClipboard);
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .copy,
                                                                          color: Theme.of(context).brightness == Brightness.light
                                                                              ? AppTheme.black60
                                                                              : AppTheme.white60,
                                                                          size: AppTheme.elementSpacing *
                                                                              1.5,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              AppTheme.elementSpacing / 2,
                                                                        ),
                                                                        Text(
                                                                          controller.txDetailsConfirmed == null
                                                                              ? ''
                                                                              : '${controller.txDetailsConfirmed?.id.toString().substring(0, 5)}...${controller.txDetailsConfirmed?.id.toString().substring(controller.txDetailsConfirmed!.id.length - 5)}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .labelMedium,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: AppTheme
                                                                            .elementSpacing /
                                                                        2,
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                        () {
                                                                          controller
                                                                              .showBlock
                                                                              .value = false;
                                                                          controller.selectedIndex =
                                                                              -1;
                                                                          controller.selectedIndexData =
                                                                              -1;
                                                                        },
                                                                      );
                                                                    },
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .cancel),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                          ),
                                        ),
                                        Obx(
                                          () => Visibility(
                                              visible:
                                                  controller.showBlock.value,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      context.push(
                                                          "/wallet/block_transactions"); //${controller.txDetailsConfirmed!.id}
                                                    },
                                                    //TEXT HIER ZU SEARCH TROUGH 7825 transactions oder so senden...
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: AppTheme
                                                              .cardPadding),
                                                      child: SearchFieldWidget(
                                                        isSearchEnabled: false,
                                                        hintText:
                                                            '${controller.bitcoinData.isNotEmpty ? controller.bitcoinData[controller.indexBlock.value].txCount : 0} transactions',
                                                        handleSearch:
                                                            handleSearch,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: AppTheme
                                                            .elementSpacing),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // SizedBox(
                                                          //   height: AppTheme
                                                          //       .cardPadding
                                                          //       .h,
                                                          // ),
                                                          // Text("   Your Transactions:", style: Theme.of(context).textTheme.titleMedium,),
                                                          const SizedBox(
                                                            height: AppTheme
                                                                .elementSpacing,
                                                          ),
                                                          ...onchainTransactions
                                                              .map(
                                                            (transaction) =>
                                                                TransactionItem(
                                                              context: context,
                                                              data:
                                                                  TransactionItemData(
                                                                timestamp:
                                                                    transaction
                                                                        .timeStamp,
                                                                status: transaction
                                                                            .numConfirmations >
                                                                        0
                                                                    ? TransactionStatus
                                                                        .confirmed
                                                                    : TransactionStatus
                                                                        .pending,
                                                                type:
                                                                    TransactionType
                                                                        .onChain,
                                                                direction: transaction
                                                                        .amount!
                                                                        .contains(
                                                                            "-")
                                                                    ? TransactionDirection
                                                                        .sent
                                                                    : TransactionDirection
                                                                        .received,
                                                                receiver: transaction
                                                                        .amount!
                                                                        .contains(
                                                                            "-")
                                                                    ? transaction
                                                                        .destAddresses
                                                                        .last
                                                                        .toString()
                                                                    : transaction
                                                                        .destAddresses
                                                                        .first
                                                                        .toString(),
                                                                txHash: transaction
                                                                    .txHash
                                                                    .toString(),
                                                                fee: 0,
                                                                amount: transaction
                                                                        .amount!
                                                                        .contains(
                                                                            "-")
                                                                    ? transaction
                                                                        .amount
                                                                        .toString()
                                                                    : "+" +
                                                                        transaction
                                                                            .amount
                                                                            .toString(),
                                                              ),
                                                            ),
                                                          ), // TransactionItem(
                                                          //     context: context,
                                                          //     data: TransactionItemData(
                                                          //       type: TransactionType.onChain,
                                                          //       amount: "500",
                                                          //       timestamp: 38399,
                                                          //       status: TransactionStatus.confirmed,
                                                          //       direction: TransactionDirection.received,
                                                          //       txHash: "1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa",
                                                          //       fee: 321,
                                                          //       receiver: "dihsdisd",
                                                          //     )),
                                                          BitNetListTile(
                                                            leading: const Icon(
                                                                Icons
                                                                    .timelapse),
                                                            text: L10n.of(
                                                                    context)!
                                                                .minedAt,
                                                            trailing: Container(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                      DateFormat(
                                                                              'yyyy-MM-dd hh:mm')
                                                                          .format(
                                                                        (DateTime.fromMillisecondsSinceEpoch(controller.txDetailsConfirmed!.timestamp *
                                                                            1000)),
                                                                      ),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              fontWeight: FontWeight.bold)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          BitNetListTile(
                                                            leading: const Icon(
                                                                FontAwesomeIcons
                                                                    .truckPickup),
                                                            text: L10n.of(
                                                                    context)!
                                                                .mined,
                                                            trailing: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            AppTheme.elementSpacing /
                                                                                2,
                                                                        vertical:
                                                                            AppTheme.elementSpacing /
                                                                                3),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            AppTheme
                                                                                .cardRadiusSmall,
                                                                        color: AppTheme
                                                                            .colorBitcoin),
                                                                    child: Text(
                                                                      (' ${controller.txDetailsConfirmed!.extras.pool.name} '),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          BitNetListTile(
                                                            leading: const Icon(
                                                                FontAwesomeIcons
                                                                    .bitcoin),
                                                            text: L10n.of(
                                                                    context)!
                                                                .minerRewardAndFees,
                                                            trailing: Container(
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      // Text((controller.txDetailsConfirmed!.extras.reward / 100000000).toStringAsFixed(3), style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                                                                      // Transform.translate(
                                                                      //   offset: const Offset(0, 2),
                                                                      //   child: Text(
                                                                      //     ' BTC  ',
                                                                      //     style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
                                                                      //   ),
                                                                      // ),
                                                                      Text(
                                                                        '  \$${controller.formatAmount((controller.txDetailsConfirmed!.extras.reward / 100000000 * controller.currentUSD.value).toStringAsFixed(0))}',
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              AppTheme.successColor,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          feeDistributionAccepted(),
                                                          const SizedBox(
                                                            height: AppTheme
                                                                .elementSpacing,
                                                          ),
                                                          const SizedBox(
                                                              height: AppTheme
                                                                  .cardPadding),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              blockSizeAccepted(),
                                                              blockHealth(),
                                                            ],
                                                          ),
                                                        ]),
                                                  ),
                                                  Container(
                                                    height:
                                                        AppTheme.cardPadding *
                                                            3,
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                            ),
                            transactionfees(),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionfees() {
    return Obx(
      () => controller.showBlock.value || controller.showNextBlock.value
          ? const SizedBox()
          : Column(
              children: [
                const SizedBox(
                  height: AppTheme.elementSpacing * 1,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: AppTheme.cardPadding),
                  child: Text(
                    "${L10n.of(context)!.transactionFees}:",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Obx(() {
                    return controller.transactionLoading.isTrue
                        ? Center(child: dotProgress(context))
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  GlassContainer(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: AppTheme.cardRadiusSmall,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              AppTheme.elementSpacing * 1,
                                          vertical:
                                              AppTheme.elementSpacing / 3),
                                      child: Text(
                                        L10n.of(context)!.low,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppTheme.elementSpacing / 2,
                                  ),
                                  Text(
                                    controller.fees == null
                                        ? ''
                                        : '\$ ${controller.dollarConversion(controller.fees!.hourFee!).toStringAsFixed(2)}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: lighten(
                                              getGradientColors(
                                                      (controller
                                                              .fees!.hourFee!)
                                                          .toDouble(),
                                                      false)
                                                  .first,
                                              25),
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GlassContainer(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: AppTheme.cardRadiusSmall,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              AppTheme.elementSpacing * 1,
                                          vertical:
                                              AppTheme.elementSpacing / 3),
                                      child: Text(
                                        L10n.of(context)!.medium,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppTheme.elementSpacing / 2,
                                  ),
                                  Text(
                                    controller.fees == null
                                        ? ''
                                        : '\$ ${controller.dollarConversion(controller.fees!.halfHourFee!).toStringAsFixed(2)}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: lighten(
                                              getGradientColors(
                                                      (controller.fees!
                                                              .halfHourFee!)
                                                          .toDouble(),
                                                      false)
                                                  .first,
                                              25),
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GlassContainer(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              AppTheme.elementSpacing * 1,
                                          vertical:
                                              AppTheme.elementSpacing / 3),
                                      child: Text(
                                        L10n.of(context)!.high,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppTheme.elementSpacing / 2,
                                  ),
                                  Text(
                                      '\$ ${controller.dollarConversion(num.parse(controller.highPriority.value)).toStringAsFixed(2)}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: lighten(
                                                getGradientColors(
                                                        double.tryParse(
                                                            controller
                                                                .highPriority
                                                                .value)!,
                                                        false)
                                                    .first,
                                                25),
                                          )),
                                ],
                              ),
                            ],
                          );
                  }),
                ),
                SizedBox(
                  height: AppTheme.cardPadding.h * 1,
                ),
                difficultyAdjustment(),
                SizedBox(
                  height: AppTheme.cardPadding.h * 1.75,
                ),
                LastTransactions(ownedTransactions: onchainTransactionsFull),

                //recentReplacements(),
                //recentTransactions(),
              ],
            ),
    );
  }

  Widget difficultyAdjustment() {
    return Column(children: [
      const SizedBox(height: AppTheme.cardPadding * 1.5),
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(left: AppTheme.cardPadding),
        child: Text(
          L10n.of(context)!.difficultyAdjustment,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      const SizedBox(
        height: AppTheme.elementSpacing,
      ),
      Obx(() {
        return controller.transactionLoading.isTrue
            ? Center(child: dotProgress(context))
            : Obx(() {
                return controller.daLoading.isTrue
                    ? Center(child: dotProgress(context))
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppTheme.cardPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('In ~${controller.days}'),
                                const SizedBox(height: 5),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Text(DateFormat.MMMd().format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  controller.da!
                                                      .estimatedRetargetDate!
                                                      .toInt())) ??
                                          ''),
                                      const Text(' at '),
                                      Text(DateFormat.jm().format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  controller.da!
                                                      .estimatedRetargetDate!
                                                      .toInt())) ??
                                          ''),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                    controller.da!.difficultyChange!.isNegative
                                        ? Icons.arrow_downward_rounded
                                        : Icons.arrow_upward_rounded,
                                    color: controller
                                            .da!.difficultyChange!.isNegative
                                        ? AppTheme.errorColor
                                        : AppTheme.successColor,
                                    size: AppTheme.cardPadding * 1.25),
                                const SizedBox(
                                  width: AppTheme.elementSpacing / 2,
                                ),
                                Text(
                                    controller.da!.difficultyChange!.isNegative
                                        ? '${controller.da!.difficultyChange!.abs().toStringAsFixed(2)} %'
                                        : '${controller.da!.difficultyChange!.toStringAsFixed(2)} %',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: controller.da!
                                                  .difficultyChange!.isNegative
                                              ? AppTheme.errorColor
                                              : AppTheme.successColor,
                                        )),
                              ],
                            ),
                          ],
                        ),
                      );
              });
      }),
    ]);
  }

  Widget blockHealth() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              L10n.of(context)!.health,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              width: AppTheme.elementSpacing / 2,
            ),
            Icon(
              Icons.help_outline_rounded,
              color: AppTheme.white80,
              size: AppTheme.cardPadding * 0.75,
            )
          ],
        ),
        const SizedBox(
          height: AppTheme.cardPadding * 0.75,
        ),
        Icon(
          FontAwesomeIcons.faceSmile,
          color: controller.txDetailsConfirmed!.extras.matchRate >= 99
              ? AppTheme.successColor
              : controller.txDetailsConfirmed!.extras.matchRate >= 75 &&
                      controller.txDetailsConfirmed!.extras.matchRate < 99
                  ? AppTheme.colorBitcoin
                  : AppTheme.errorColor,
          size: AppTheme.cardPadding * 2.5,
        ),
        const SizedBox(
          height: AppTheme.elementSpacing * 1.25,
        ),
        Row(
          children: [
            Container(
              child: Text(
                ('${controller.txDetailsConfirmed!.extras.matchRate} %'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget blockSizeAccepted() {
    // Assuming controller.txDetailsConfirmed.size and .weight are already in MB and MWU units respectively.
    double mbSize = controller.txDetailsConfirmed!.size / 1000000;
    double mwu = controller.txDetailsConfirmed!.weight / 1000000;

    // Calculate the width based on the ratio
    double maxWidth = AppTheme.cardPadding * 3;
    double ratio = (mbSize / mwu) * maxWidth;
    double orangeContainerWidth =
        ratio.clamp(0, maxWidth); // Ensuring it doesn't exceed maxWidth

    return Column(
      children: [
        Row(
          children: [
            Text(
              L10n.of(context)!.blockSize,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              width: AppTheme.elementSpacing / 2,
            ),
            Icon(
              Icons.help_outline_rounded,
              color: AppTheme.white80,
              size: AppTheme.cardPadding * 0.75,
            )
          ],
        ),
        const SizedBox(
          height: AppTheme.cardPadding * 0.5,
        ),
        Stack(
          children: [
            Container(
              height: AppTheme.cardPadding * 3,
              width: AppTheme.cardPadding * 3,
              decoration: BoxDecoration(
                borderRadius: AppTheme.cardRadiusSmall,
                color: Colors.grey,
              ),
            ),
            Container(
              height: AppTheme.cardPadding * 3,
              width: orangeContainerWidth, // Adjusted width based on ratio
              decoration: BoxDecoration(
                borderRadius: AppTheme.cardRadiusSmall,
                color: AppTheme.colorBitcoin,
              ),
            ),
            Container(
              height: AppTheme.cardPadding * 3,
              width: AppTheme.cardPadding * 3,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${mbSize.toStringAsFixed(2)} MB',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppTheme.white90, shadows: [
                        AppTheme.boxShadowBig,
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppTheme.elementSpacing * 0.75,
        ),
        Row(
          children: [
            Text(
              "of ${mwu.toStringAsFixed(2)} MB",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // Transform.translate(
            //   offset: const Offset(0, 2),
            //   child: Text(
            //     ' MB  ',
            //     style: Theme.of(context).textTheme.labelSmall,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Widget blockSizeUnaccepted() {
    // Assuming controller.mempoolBlocks[controller.indexShowBlock.value].blockSize and controller.txDetailsConfirmed!.weight are already in MB and MWU units respectively.
    double mbSize =
        controller.mempoolBlocks[controller.indexShowBlock.value].blockSize! /
            1000000;
    double mwu = (controller.txDetailsConfirmed?.weight)! / 1000000;

    // Calculate the width based on the ratio
    double maxWidth = AppTheme.cardPadding * 3;
    double ratio = (mbSize / mwu) * maxWidth;
    double orangeContainerWidth =
        ratio.clamp(0, maxWidth); // Ensuring it doesn't exceed maxWidth

    return Column(
      children: [
        Row(
          children: [
            Text(
              L10n.of(context)!.blockSize,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              width: AppTheme.elementSpacing / 2,
            ),
            Icon(
              Icons.help_outline_rounded,
              color: AppTheme.white80,
              size: AppTheme.cardPadding * 0.75,
            )
          ],
        ),
        const SizedBox(
          height: AppTheme.cardPadding * 0.5,
        ),
        Stack(
          children: [
            Container(
              height: AppTheme.cardPadding * 3,
              width: AppTheme.cardPadding * 3,
              decoration: BoxDecoration(
                borderRadius: AppTheme.cardRadiusSmall,
                color: Colors.grey,
              ),
            ),
            Container(
              height: AppTheme.cardPadding * 3,
              width: orangeContainerWidth,
              decoration: BoxDecoration(
                borderRadius: AppTheme.cardRadiusSmall,
                color: AppTheme.colorBitcoin,
              ),
            ),
            Container(
              height: AppTheme.cardPadding * 3,
              width: AppTheme.cardPadding * 3,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${mbSize.toStringAsFixed(2)} MB',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppTheme.white90,
                        shadows: [
                          AppTheme.boxShadowBig,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppTheme.elementSpacing * 0.75,
        ),
        Row(
          children: [
            Text(
              "of ${mwu.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Transform.translate(
              offset: const Offset(0, 2),
              child: Text(
                ' MWU  ',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget feeDistributionAccepted() {
    return Column(children: [
      BitNetListTile(
        leading: const Icon(FontAwesomeIcons.moneyBill),
        text: L10n.of(context)!.feeDistribution,
        trailing: Container(
          child: Row(
            children: [
              // Text(
              //     (controller.txDetailsConfirmed!.extras.totalFees / 100000000)
              //         .toStringAsFixed(3),
              //     style: Theme.of(context)
              //         .textTheme
              //         .bodySmall!
              //         .copyWith(fontWeight: FontWeight.bold)),
              // Transform.translate(
              //   offset: const Offset(0, 2),
              //   child: Text(
              //     ' BTC  ',
              //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
              //         fontWeight: FontWeight.bold,
              //         color: AppTheme.secondaryColor),
              //   ),
              // ),
              Text(
                '\$${controller.formatAmount((controller.txDetailsConfirmed!.extras.totalFees / 100000000 * controller.currentUSD.value).toStringAsFixed(0))}',
                style: const TextStyle(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: AppTheme.elementSpacing,
      ),
      Text(
          '${L10n.of(context)!.median}' +
              '~' +
              '\$${(((controller.txDetailsConfirmed!.extras.medianFee * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppTheme.white90,
              )),
      const SizedBox(
        height: AppTheme.elementSpacing,
      ),
      Container(
        width: AppTheme.cardPadding * 12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SfLinearGauge(
              showTicks: false,
              showLabels: false,
              useRangeColorForAxis: true,
              axisTrackStyle: const LinearAxisTrackStyle(
                  thickness: AppTheme.cardPadding,
                  color: Colors.grey,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.greenAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.1, 0.9],
                      tileMode: TileMode.clamp)),
              minimum: controller.txDetailsConfirmed!.extras.feeRange.first,
              maximum: controller.txDetailsConfirmed!.extras.feeRange.last,
              markerPointers: [
                LinearWidgetPointer(
                    value: controller.txDetailsConfirmed!.extras.medianFee,
                    child: Container(
                      height: AppTheme.cardPadding * 1.25,
                      width: AppTheme.elementSpacing * 0.75,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '\$${(((controller.txDetailsConfirmed!.extras.feeRange.first * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.redAccent,
                          )),
                  Text(
                      '\$${(((controller.txDetailsConfirmed!.extras.feeRange.last * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.greenAccent,
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget feeDistributionUnaccepted() {
    return Column(children: [
      BitNetListTile(
        leading: const Icon(FontAwesomeIcons.moneyBill),
        text: L10n.of(context)!.feeDistribution,
        trailing: Container(
          child: Row(
            children: [
              // Text(
              //   controller.mempoolBlocks.isNotEmpty
              //       ? controller.numberFormat.format(controller
              //               .mempoolBlocks[controller.indexShowBlock.value]
              //               .totalFees! /
              //           100000000)
              //       : '',
              //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
              //         fontWeight: FontWeight.bold,
              //       ),
              // ),
              // Transform.translate(
              //   offset: const Offset(0, 2),
              //   child: Text(
              //     ' BTC  ',
              //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
              //         fontWeight: FontWeight.bold,
              //         color: AppTheme.secondaryColor),
              //   ),
              // ),
              Text(
                controller.mempoolBlocks.isNotEmpty
                    ? ('\$${controller.formatAmount((controller.mempoolBlocks[controller.indexShowBlock.value].totalFees! / 100000000 * controller.currentUSD.value).toStringAsFixed(0))}')
                    : '',
                style: const TextStyle(
                  color: AppTheme.successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(
        height: AppTheme.elementSpacing,
      ),
      Text(
          '${L10n.of(context)!.median}' +
              '~' +
              '\$${(((controller.mempoolBlocks.isEmpty ? 0 : controller.mempoolBlocks[controller.indexShowBlock.value].medianFee! * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppTheme.black60,
              )),
      const SizedBox(
        height: AppTheme.elementSpacing,
      ),
      Container(
        width: AppTheme.cardPadding * 12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SfLinearGauge(
              showTicks: false,
              showLabels: false,
              useRangeColorForAxis: true,
              axisTrackStyle: const LinearAxisTrackStyle(
                  thickness: AppTheme.cardPadding,
                  color: Colors.grey,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.greenAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.1, 0.9],
                      tileMode: TileMode.clamp)),
              minimum: controller.mempoolBlocks[controller.indexShowBlock.value]
                  .feeRange!.first
                  .toDouble(),
              maximum: controller
                  .mempoolBlocks[controller.indexShowBlock.value].feeRange!.last
                  .toDouble(),
              markerPointers: [
                LinearWidgetPointer(
                    value: controller
                        .mempoolBlocks[controller.indexShowBlock.value]
                        .medianFee!
                        .toDouble(),
                    child: Container(
                      height: AppTheme.cardPadding * 1.25,
                      width: AppTheme.elementSpacing * 0.75,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '\$${(((controller.mempoolBlocks[controller.indexShowBlock.value].feeRange!.first * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.redAccent,
                          )),
                  Text(
                      '\$${(((controller.mempoolBlocks[controller.indexShowBlock.value].feeRange!.last * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.greenAccent,
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  bool hasUserTxs(String blockhash) {
    return onchainTransactionsFull
            .firstWhereOrNull((tx) => tx.blockHash == blockhash) !=
        null;
  }
}
