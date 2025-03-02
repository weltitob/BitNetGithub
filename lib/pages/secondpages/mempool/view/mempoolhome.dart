import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/secondpages/fear_and_greed.dart';
import 'package:bitnet/pages/secondpages/hashrate/hashrate.dart';
import 'package:bitnet/pages/secondpages/mempool/colorhelper.dart';
import 'package:bitnet/pages/secondpages/mempool/model/fear_gear_chart_model.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
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
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:timezone/timezone.dart';

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
    // Initialize loading states
    hashrateLoading = true;
    fearGreedLoading = true;

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

      // Fetch data for our widgets
      getHashrateData();
      getFearGreedData();
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
    final overlayController = Get.find<OverlayController>();
    Location loc =
        Provider.of<TimezoneProvider>(context, listen: false).timeZone;

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
                  SizedBox(
                    height: AppTheme.cardPadding.h * 3,
                  ),
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
                                                                        ).toUtc().add(Duration(
                                                                            milliseconds:
                                                                                loc.currentTimeZone.offset)),
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
                                                  margin:  EdgeInsets
                                                      .symmetric(
                                                      horizontal: AppTheme
                                                          .cardPadding.w),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: AppTheme
                                                            .cardPadding.h,
                                                      ),
                                                      feeDistribution(context,
                                                          isAccepted: false),
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
                                                              : blockSize(
                                                                  context,
                                                                  isAccepted:
                                                                      false)
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
                                                                      overlayController
                                                                          .showOverlay(
                                                                              L10n.of(context)!.copiedToClipboard);
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
                                          () =>
                                              controller
                                                      .txDetailsConfirmed.isNull
                                                  ? Container()
                                                  : Visibility(
                                                      visible: controller
                                                          .showBlock.value,
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
                                                                  horizontal:
                                                                      AppTheme
                                                                          .cardPadding),
                                                              child:
                                                                  SearchFieldWidget(
                                                                isSearchEnabled:
                                                                    false,
                                                                hintText:
                                                                    '${controller.bitcoinData.isNotEmpty ? controller.bitcoinData[controller.indexBlock.value].txCount : 0} transactions',
                                                                handleSearch:
                                                                    handleSearch,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:  EdgeInsets
                                                                .symmetric(
                                                                horizontal: AppTheme
                                                                    .cardPadding.w),
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
                                                                      data:
                                                                          TransactionItemData(
                                                                        timestamp:
                                                                            transaction.timeStamp,
                                                                        status: transaction.numConfirmations >
                                                                                0
                                                                            ? TransactionStatus.confirmed
                                                                            : TransactionStatus.pending,
                                                                        type: TransactionType
                                                                            .onChain,
                                                                        direction: transaction.amount!.contains("-")
                                                                            ? TransactionDirection.sent
                                                                            : TransactionDirection.received,
                                                                        receiver: transaction.amount!.contains("-")
                                                                            ? transaction.destAddresses.last.toString()
                                                                            : transaction.destAddresses.first.toString(),
                                                                        txHash: transaction
                                                                            .txHash
                                                                            .toString(),
                                                                        fee: 0,
                                                                        amount: transaction.amount!.contains("-")
                                                                            ? transaction.amount
                                                                                .toString()
                                                                            : "+" +
                                                                                transaction.amount.toString(),
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
                                                                  const SizedBox(
                                                                    height: AppTheme
                                                                        .elementSpacing,
                                                                  ),
                                                                  MiningInfoCard(
                                                                    timestamp: DateTime.fromMillisecondsSinceEpoch(controller.txDetailsConfirmed!.timestamp *
                                                                            1000)
                                                                        .toUtc()
                                                                        .add(Duration(
                                                                            milliseconds:
                                                                                loc.currentTimeZone.offset)),
                                                                    poolName: controller
                                                                        .txDetailsConfirmed!
                                                                        .extras
                                                                        .pool
                                                                        .name,
                                                                    rewardAmount: controller
                                                                            .txDetailsConfirmed!
                                                                            .extras
                                                                            .reward /
                                                                        100000000 *
                                                                        controller
                                                                            .currentUSD
                                                                            .value,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: AppTheme
                                                                        .elementSpacing,
                                                                  ),
                                                                  feeDistribution(
                                                                      context,
                                                                      isAccepted:
                                                                          true),
                                                                  const SizedBox(
                                                                    height: AppTheme
                                                                        .elementSpacing,
                                                                  ),

                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            AspectRatio(
                                                                          aspectRatio:
                                                                              1, // This ensures a square shape
                                                                          child: blockSize(
                                                                              context,
                                                                              isAccepted: true),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: AppTheme
                                                                            .elementSpacing,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            AspectRatio(
                                                                          aspectRatio:
                                                                              1,
                                                                          child: blockHealth(
                                                                              context,
                                                                              isAccepted: true),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ]),
                                                          ),
                                                          Container(
                                                            height: AppTheme
                                                                    .cardPadding *
                                                                2.5.h,
                                                          )
                                                        ],
                                                      )),
                                        ),
                                      ],
                                    ),
                            ),
                            // 1. Transaction Fees
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
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Obx(() {
                    return controller.transactionLoading.isTrue
                        ? Center(child: dotProgress(context))
                        : GlassContainer(
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(AppTheme.cardPadding),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.coins,
                                        size: AppTheme.cardPadding * 0.75,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      SizedBox(width: AppTheme.elementSpacing),
                                      Text(
                                        "Current Network Fees",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppTheme.cardPadding),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildFeeColumn(
                                        context: context,
                                        title: L10n.of(context)!.low,
                                        feeAmount: controller.fees == null
                                            ? ''
                                            : '\$ ${controller.dollarConversion(controller.fees!.hourFee!).toStringAsFixed(2)}',
                                        feeColor: lighten(
                                            getGradientColors(
                                                    (controller.fees!.hourFee!)
                                                        .toDouble(),
                                                    false)
                                                .first,
                                            25),
                                        icon: Icons.speed,
                                        iconColor: AppTheme.errorColor
                                            .withOpacity(0.7),
                                      ),
                                      _buildFeeColumn(
                                        context: context,
                                        title: L10n.of(context)!.medium,
                                        feeAmount: controller.fees == null
                                            ? ''
                                            : '\$ ${controller.dollarConversion(controller.fees!.halfHourFee!).toStringAsFixed(2)}',
                                        feeColor: lighten(
                                            getGradientColors(
                                                    (controller
                                                            .fees!.halfHourFee!)
                                                        .toDouble(),
                                                    false)
                                                .first,
                                            25),
                                        icon: Icons.speed,
                                        iconColor: AppTheme.colorBitcoin
                                            .withOpacity(0.8),
                                      ),
                                      _buildFeeColumn(
                                        context: context,
                                        title: L10n.of(context)!.high,
                                        feeAmount:
                                            '\$ ${controller.dollarConversion(num.parse(controller.highPriority.value)).toStringAsFixed(2)}',
                                        feeColor: lighten(
                                            getGradientColors(
                                                    double.tryParse(controller
                                                        .highPriority.value)!,
                                                    false)
                                                .first,
                                            25),
                                        icon: Icons.speed,
                                        iconColor: AppTheme.successColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppTheme.elementSpacing),
                                  SizedBox(height: AppTheme.elementSpacing),
                                  Text(
                                    "Estimated confirmation time",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppTheme.white60
                                              : AppTheme.black60,
                                        ),
                                  ),
                                  SizedBox(height: AppTheme.elementSpacing),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildTimeEstimate(context, "~60 min",
                                          AppTheme.errorColor.withOpacity(0.7)),
                                      _buildTimeEstimate(
                                          context,
                                          "~30 min",
                                          AppTheme.colorBitcoin
                                              .withOpacity(0.8)),
                                      _buildTimeEstimate(context, "Next block",
                                          AppTheme.successColor),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                  }),
                ),
                SizedBox(
                  height: AppTheme.cardPadding.h * 1.5,
                ),

                difficultyAdjustment(),
                SizedBox(
                  height: AppTheme.cardPadding.h * 1.5,
                ),
                // Bitcoin Hashrate Widget
                _buildHashrateWidget(),
                SizedBox(height: AppTheme.cardPadding.h * 1.5),

                // Fear & Greed Index Widget
                _buildFearGreedWidget(),
                SizedBox(height: AppTheme.cardPadding.h * 1.5),

                LastTransactions(ownedTransactions: onchainTransactionsFull),
                SizedBox(height: AppTheme.cardPadding.h * 2),
              ],
            ),
    );
  }

  // Hashrate Widget
  // Hashrate data members
  List<ChartLine> hashrateChartData = [];
  List<Difficulty> hashrateChartDifficulty = [];
  bool hashrateLoading = true;

  Future<void> getHashrateData([String period = '1M']) async {
    if (!mounted) return;

    try {
      setState(() {
        hashrateLoading = true;
      });

      var dio = Dio();
      var response =
          await dio.get('https://mempool.space/api/v1/mining/hashrate/$period');

      if (response.statusCode == 200) {
        List<ChartLine> line = [];
        hashrateChartData.clear();
        hashrateChartDifficulty.clear();

        HashChartModel hashChartModel = HashChartModel.fromJson(response.data);
        hashrateChartDifficulty.addAll(hashChartModel.difficulty ?? []);

        for (int i = 0; i < hashChartModel.hashrates!.length; i++) {
          line.add(ChartLine(
            time:
                double.parse(hashChartModel.hashrates![i].timestamp.toString()),
            price: hashChartModel.hashrates![i].avgHashrate!,
          ));
        }

        setState(() {
          hashrateChartData = line;
          hashrateLoading = false;
        });
      }
    } catch (e) {
      print('Hashrate error: $e');
      setState(() {
        hashrateLoading = false;
      });
    }
  }

  Widget _buildHashrateWidget() {
    // Get current hashrate value from the latest data point
    String currentHashrate = "...";
    String changePercentage = "";
    bool isPositive = true;

    if (hashrateChartData.isNotEmpty) {
      // Get the most recent data point
      final lastPoint = hashrateChartData.last;
      // Format hashrate value - convert to EH/s (Exahash per second)
      final hashrateParsed = double.parse(lastPoint.price.toString().substring(
          0,
          lastPoint.price.toString().length > 3
              ? 3
              : lastPoint.price.toString().length));
      currentHashrate = "$hashrateParsed EH/s";

      // Calculate change percentage if we have more than one data point
      if (hashrateChartData.length > 10) {
        final previousPoint = hashrateChartData[
            hashrateChartData.length - 10]; // Compare with point ~10 days ago
        final change =
            (lastPoint.price - previousPoint.price) / previousPoint.price * 100;
        isPositive = change >= 0;
        changePercentage =
            "${isPositive ? "+" : ""}${change.toStringAsFixed(1)}%";
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.server,
                        size: AppTheme.cardPadding * 0.75,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: AppTheme.elementSpacing),
                      Text(
                        L10n.of(context)!.hashrate,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Current hashrate display
              Center(
                child: Column(
                  children: [
                    Text(
                      currentHashrate,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    if (hashrateChartData.isNotEmpty &&
                        changePercentage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isPositive
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: isPositive
                                  ? AppTheme.successColor
                                  : AppTheme.errorColor,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              changePercentage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: isPositive
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Time period selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeButton(context, '1D', hashrateLoading),
                  SizedBox(width: 4),
                  _buildTimeButton(context, '1W', hashrateLoading),
                  SizedBox(width: 4),
                  _buildTimeButton(context, '1M', hashrateLoading),
                  SizedBox(width: 4),
                  _buildTimeButton(context, '1Y', hashrateLoading),
                  SizedBox(width: 4),
                  _buildTimeButton(context, 'MAX', hashrateLoading),
                ],
              ),

              SizedBox(height: 16),

              // Hashrate chart similar to the hashrate screen
              hashrateLoading
                  ? Center(
                      child: SizedBox(
                        height: 180,
                        child: dotProgress(context),
                      ),
                    )
                  : hashrateChartData.isEmpty
                      ? Center(
                          child: Text(
                            "Failed to load hashrate data",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : Container(
                          height: 180,
                          padding: EdgeInsets.only(top: 8, right: 8),
                          decoration: BoxDecoration(
                            borderRadius: AppTheme.cardRadiusSmall,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppTheme.black70
                                    : AppTheme.white70,
                          ),
                          child: _buildMiniHashrateChart(),
                        ),

              SizedBox(height: 16),

              // Hashrate explanation
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusSmall,
                  color: AppTheme.colorBitcoin.withOpacity(0.1),
                ),
                child: Text(
                  "Higher hashrate = stronger network security",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppTheme.colorBitcoin,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Track selected time period
  String selectedTimePeriod = '1M';

  Widget _buildTimeButton(BuildContext context, String period, bool isLoading, {bool isSelected = false}) {
    // Use the tracked time period
    final isActive = period == selectedTimePeriod;
    return InkWell(
      onTap: isLoading ? null : () {
        // Update selected period
        setState(() {
          selectedTimePeriod = period;
        });

        // Handle period selection here
        if (period == '1D') {
          getHashrateData('1D');
        } else if (period == '1W') {
          getHashrateData('1W');
        } else if (period == '1M') {
          getHashrateData('1M');
        } else if (period == '1Y') {
          getHashrateData('1Y');
        } else if (period == 'MAX') {
          getHashrateData('3Y'); // Maximum available data is 3 years
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.colorBitcoin.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isActive ? AppTheme.colorBitcoin : AppTheme.white60,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          period,
          style: TextStyle(
            color: isActive ? AppTheme.colorBitcoin : null,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Mini hashrate chart
  Widget _buildMiniHashrateChart() {
    // Similar to HashrateChart in hashratechart.dart
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: EdgeInsets.only(left: 8, bottom: 8),
      enableAxisAnimation: true,
      trackballBehavior: TrackballBehavior(
        lineColor: Colors.grey[400],
        enable: true,
        activationMode: ActivationMode.singleTap,
        lineWidth: 2,
        lineType: TrackballLineType.horizontal,
        tooltipSettings: const InteractiveTooltip(enable: false),
        markerSettings: const TrackballMarkerSettings(
            color: Colors.white,
            borderColor: Colors.white,
            markerVisibility: TrackballVisibilityMode.visible),
      ),
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.days,
        edgeLabelPlacement: EdgeLabelPlacement.none,
        majorGridLines: MajorGridLines(
          width: 0.5,
          color: AppTheme.white70,
          dashArray: [5, 5],
        ),
        axisLine: const AxisLine(width: 0),
        labelStyle: TextStyle(color: AppTheme.white70, fontSize: 10),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        plotOffset: 0,
        edgeLabelPlacement: EdgeLabelPlacement.none,
        majorGridLines: MajorGridLines(
          width: 0.5,
          color: AppTheme.white70,
          dashArray: [5, 5],
        ),
        majorTickLines: const MajorTickLines(width: 0),
        numberFormat: NumberFormat.compact(),
        labelStyle: TextStyle(color: AppTheme.white60, fontSize: 10),
      ),
      series: <CartesianSeries>[
        // Hashrate line
        SplineSeries<ChartLine, DateTime>(
          name: L10n.of(context)!.hashrate,
          enableTooltip: true,
          dataSource: hashrateChartData,
          splineType: SplineType.cardinal,
          cardinalSplineTension: 0.7,
          animationDuration: 1000,
          width: 2,
          color: AppTheme.colorBitcoin,
          xValueMapper: (ChartLine sales, _) =>
              DateTime.fromMillisecondsSinceEpoch(sales.time.toInt() * 1000,
                  isUtc: true),
          yValueMapper: (ChartLine sales, _) => double.parse(sales.price
              .toString()
              .substring(
                  0,
                  sales.price.toString().length > 3
                      ? 3
                      : sales.price.toString().length)),
        ),
        // Add difficulty markers as scatter series
        if (hashrateChartDifficulty.isNotEmpty)
          ScatterSeries<Difficulty, DateTime>(
            name: L10n.of(context)!.difficulty,
            enableTooltip: true,
            dataSource: hashrateChartDifficulty,
            color: Colors.white,
            markerSettings: MarkerSettings(
              height: 6,
              width: 6,
              shape: DataMarkerType.circle,
              borderColor: AppTheme.colorBitcoin,
              borderWidth: 1,
            ),
            xValueMapper: (Difficulty sales, _) =>
                DateTime.fromMillisecondsSinceEpoch(sales.time!.toInt() * 1000,
                    isUtc: true),
            yValueMapper: (Difficulty sales, _) => double.parse(
                (sales.difficulty! / 100000000000).toStringAsFixed(2)),
          ),
      ],
    );
  }

  // Fear & Greed data and state
  FearGearChartModel fearGreedData = FearGearChartModel();
  bool fearGreedLoading = true;
  String formattedFearGreedDate = '';

  Future<void> getFearGreedData() async {
    if (!mounted) return;

    try {
      setState(() {
        fearGreedLoading = true;
      });

      var dio = Dio();
      var response =
          await dio.get('https://fear-and-greed-index.p.rapidapi.com/v1/fgi',
              options: Options(headers: {
                'X-RapidAPI-Key':
                    'd9329ded30msh2e4ed90bed55972p1162f9jsn68d0a91b20ff',
                'X-RapidAPI-Host': 'fear-and-greed-index.p.rapidapi.com'
              }));

      if (response.statusCode == 200) {
        Location loc =
            Provider.of<TimezoneProvider>(context, listen: false).timeZone;
        setState(() {
          fearGreedData = FearGearChartModel.fromJson(response.data);
          if (fearGreedData.lastUpdated != null) {
            DateTime dateTime =
                DateTime.parse(fearGreedData.lastUpdated!.humanDate!)
                    .toUtc()
                    .add(Duration(milliseconds: loc.currentTimeZone.offset));
            formattedFearGreedDate = DateFormat('d MMMM yyyy').format(dateTime);
          }
          fearGreedLoading = false;
        });
      }
    } catch (e) {
      print('Fear and Greed error: $e');
      setState(() {
        fearGreedLoading = false;
      });
    }
  }

  // Fear & Greed Widget with real data
  Widget _buildFearGreedWidget() {
    // Get current value or use 50 as default
    int currentValue = 50;
    if (fearGreedData.fgi != null && fearGreedData.fgi!.now != null) {
      currentValue = fearGreedData.fgi!.now!.value ?? 50;
    }

    // Get historical values for comparison
    Map<String, int> historicalValues = {};
    if (fearGreedData.fgi != null) {
      if (fearGreedData.fgi!.previousClose != null) {
        historicalValues['Yesterday'] = fearGreedData.fgi!.previousClose!.value ?? 0;
      }
      if (fearGreedData.fgi!.oneWeekAgo != null) {
        historicalValues['Last Week'] = fearGreedData.fgi!.oneWeekAgo!.value ?? 0;
      }
      if (fearGreedData.fgi!.oneMonthAgo != null) {
        historicalValues['Last Month'] = fearGreedData.fgi!.oneMonthAgo!.value ?? 0;
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.gaugeHigh,
                        size: AppTheme.cardPadding * 0.75,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: AppTheme.elementSpacing),
                      Text(
                        L10n.of(context)!.fearAndGreedIndex,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Gauge visualization
              fearGreedLoading
                  ? Center(
                      child: SizedBox(
                        height: 100,
                        child: dotProgress(context),
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          _buildRadialGauge(currentValue),
                          // Value and sentiment text
                          Text(
                            fearGreedData.fgi?.now?.valueText ?? "Neutral",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: _getFearGreedColor(currentValue),
                                ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to get color based on value
  Color _getFearGreedColor(int value) {
    if (value <= 25) {
      return AppTheme.errorColor;
    } else if (value <= 45) {
      return Colors.orange;
    } else if (value <= 55) {
      return AppTheme.colorBitcoin;
    } else if (value <= 75) {
      return AppTheme.successColor;
    } else {
      return AppTheme.successColor;
    }
  }

  // Build a custom radial gauge for fear & greed
  Widget _buildRadialGauge(int value) {
    return Container(
      height: 160,
      width: 160,
      child: AnimatedRadialGauge(
        duration: const Duration(seconds: 1),
        curve: Curves.elasticOut,
        radius: 80,
        value: value.toDouble(),
        axis: GaugeAxis(
          min: 0,
          max: 100,
          degrees: 180,
          style: GaugeAxisStyle(
            thickness: 20,
            background: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white70
                : AppTheme.black70,
            segmentSpacing: 4,
          ),
          progressBar: GaugeProgressBar.rounded(
            color: _getFearGreedColor(value),
          ),
        ),
        builder: (context, child, value) => RadialGaugeLabel(
          value: value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Widget _buildFeeColumn({
    required BuildContext context,
    required String title,
    required String feeAmount,
    required Color feeColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withOpacity(0.15),
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
        ),
        SizedBox(height: AppTheme.elementSpacing),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: AppTheme.elementSpacing / 2),
        Text(
          feeAmount,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: feeColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildTimeEstimate(BuildContext context, String time, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.elementSpacing,
        vertical: AppTheme.elementSpacing / 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: AppTheme.cardRadiusSmall,
      ),
      child: Text(
        time,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget difficultyAdjustment() {
    Location loc =
        Provider.of<TimezoneProvider>(context, listen: false).timeZone;

    return Column(children: [
      Obx(() {
        return controller.transactionLoading.isTrue
            ? Center(child: dotProgress(context))
            : Obx(() {
                return controller.daLoading.isTrue
                    ? Center(child: dotProgress(context))
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppTheme.cardPadding),
                        child: GlassContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(AppTheme.cardPadding),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.gear,
                                      size: AppTheme.cardPadding * 0.75,
                                    ),
                                    SizedBox(width: AppTheme.elementSpacing),
                                    Text(
                                      "Bitcoin Network Difficulty",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppTheme.cardPadding),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Left side - Date information
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildInfoRow(
                                          context,
                                          "Next adjustment in:",
                                          "~${controller.days}",
                                          Icons.calendar_today,
                                        ),
                                        SizedBox(
                                            height:
                                                AppTheme.elementSpacing * 1.5),
                                        _buildInfoRow(
                                          context,
                                          "Estimated date:",
                                          DateFormat.yMMMd().format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      controller.da!
                                                          .estimatedRetargetDate!
                                                          .toInt())
                                              .toUtc()
                                              .add(Duration(
                                                  milliseconds: loc
                                                      .currentTimeZone
                                                      .offset))),
                                          Icons.event,
                                        ),
                                        SizedBox(
                                            height:
                                                AppTheme.elementSpacing * 1.5),
                                        _buildInfoRow(
                                          context,
                                          "Estimated time:",
                                          DateFormat.jm().format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      controller.da!
                                                          .estimatedRetargetDate!
                                                          .toInt())
                                              .toUtc()
                                              .add(Duration(
                                                  milliseconds: loc
                                                      .currentTimeZone
                                                      .offset))),
                                          Icons.access_time,
                                        ),
                                      ],
                                    ),

                                    // Right side - Difficulty change visualization
                                    Container(
                                      width: 120.w,
                                      height: 120.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: controller.da!
                                                  .difficultyChange!.isNegative
                                              ? AppTheme.errorColor
                                                  .withOpacity(0.5)
                                              : AppTheme.successColor
                                                  .withOpacity(0.5),
                                          width: 3,
                                        ),
                                        color: controller.da!.difficultyChange!
                                                .isNegative
                                            ? AppTheme.errorColor
                                                .withOpacity(0.1)
                                            : AppTheme.successColor
                                                .withOpacity(0.1),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            controller.da!.difficultyChange!
                                                    .isNegative
                                                ? Icons.arrow_downward_rounded
                                                : Icons.arrow_upward_rounded,
                                            color: controller
                                                    .da!
                                                    .difficultyChange!
                                                    .isNegative
                                                ? AppTheme.errorColor
                                                : AppTheme.successColor,
                                            size: 36,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            controller.da!.difficultyChange!
                                                    .isNegative
                                                ? '${controller.da!.difficultyChange!.abs().toStringAsFixed(2)}%'
                                                : '${controller.da!.difficultyChange!.toStringAsFixed(2)}%',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  color: controller
                                                          .da!
                                                          .difficultyChange!
                                                          .isNegative
                                                      ? AppTheme.errorColor
                                                      : AppTheme.successColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            controller.da!.difficultyChange!
                                                    .isNegative
                                                ? "Decrease"
                                                : "Increase",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: controller
                                                          .da!
                                                          .difficultyChange!
                                                          .isNegative
                                                      ? AppTheme.errorColor
                                                      : AppTheme.successColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppTheme.elementSpacing),
                                SizedBox(height: AppTheme.elementSpacing),
                                Text(
                                  "Difficulty adjusts every 2016 blocks (~2 weeks)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? AppTheme.white60
                                            : AppTheme.black60,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              });
      }),
    ]);
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.white60,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.white60
                        : AppTheme.black60,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  bool hasUserTxs(String blockhash) {
    return onchainTransactionsFull
            .firstWhereOrNull((tx) => tx.blockHash == blockhash) !=
        null;
  }
}

class MiningInfoCard extends StatelessWidget {
  final DateTime timestamp;
  final String poolName;
  final double rewardAmount;

  const MiningInfoCard({
    Key? key,
    required this.timestamp,
    required this.poolName,
    required this.rewardAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Container(
        padding: const EdgeInsets.all(AppTheme.elementSpacing * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Miner Information text heading
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.elementSpacing),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.truckPickup,
                    size: AppTheme.cardPadding * 0.75,
                  ),
                  SizedBox(
                    width: AppTheme.elementSpacing,
                  ),
                  Text("Miner Information",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),

            // Header with timestamp and pool
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Timestamp
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Color(0xFFA1A1AA), // zinc-400
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(timestamp),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                // Pool badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.colorBitcoin, // orange-500
                    borderRadius: AppTheme.cardRadiusSmall,
                  ),
                  child: Text(poolName,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: darken(AppTheme.colorBitcoin, 95))),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.cardPadding * 0.75),

            // Status indicator
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppTheme.successColor, // green-400
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Mined',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.cardPadding * 0.75),

            // Reward amount
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.bitcoin,
                  color: AppTheme.colorBitcoin, // orange-500
                  size: 24,
                ),
                const SizedBox(width: AppTheme.elementSpacing),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Miner Reward (Subsidy + fees)',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      '\$${NumberFormat('#,##0').format(rewardAmount)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppTheme.successColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Usage example:
// Replace your existing BitNetListTiles with:
/*
MiningInfoCard(
  timestamp: DateTime.fromMillisecondsSinceEpoch(
    controller.txDetailsConfirmed!.timestamp * 1000
  ).toUtc().add(Duration(milliseconds: loc.currentTimeZone.offset)),
  poolName: controller.txDetailsConfirmed!.extras.pool.name,
  rewardAmount: controller.txDetailsConfirmed!.extras.reward / 100000000 * controller.currentUSD.value,
)
*/

// Unified widgets for both accepted and unaccepted blocks
Widget blockSize(BuildContext context, {bool isAccepted = true}) {
  final controller = Get.find<HomeController>();
  // Get the appropriate size and weight based on whether we're looking at accepted or unaccepted block
  double mbSize = isAccepted
      ? controller.txDetailsConfirmed!.size / 1000000
      : controller.mempoolBlocks[controller.indexShowBlock.value].blockSize! /
          1000000;

  double mwu = controller.txDetailsConfirmed!.weight / 1000000;

  // Calculate the width based on the ratio
  double maxWidth = AppTheme.cardPadding * 3;
  double ratio = (mbSize / mwu) * maxWidth;
  double orangeContainerWidth =
      ratio.clamp(0, maxWidth); // Ensuring it doesn't exceed maxWidth

  return GlassContainer(
    height: isAccepted ? null : AppTheme.cardPadding * 6.5.h,
    width: isAccepted ? null : AppTheme.cardPadding * 6.5.w,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              L10n.of(context)!.blockSize,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "of ${mwu.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Transform.translate(
              offset: const Offset(0, 2),
              child: Text(
                isAccepted ? ' MB  ' : ' MWU  ',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget blockHealth(BuildContext context, {bool isAccepted = true}) {
  final controller = Get.find<HomeController>();
  // For unaccepted blocks, assume 100% health since they haven't been mined yet
  double matchRate =
      isAccepted ? controller.txDetailsConfirmed!.extras.matchRate : 100.0;

  return GlassContainer(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              L10n.of(context)!.health,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
          color: matchRate >= 99
              ? AppTheme.successColor
              : matchRate >= 75 && matchRate < 99
                  ? AppTheme.colorBitcoin
                  : AppTheme.errorColor,
          size: AppTheme.cardPadding * 2.5,
        ),
        const SizedBox(
          height: AppTheme.elementSpacing * 1.25,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                ('${matchRate} %'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget feeDistribution(BuildContext context, {bool isAccepted = true}) {
  final controller = Get.find<HomeController>();
  // Get the appropriate fee data based on whether we're looking at accepted or unaccepted block
  num medianFee = isAccepted
      ? controller.txDetailsConfirmed!.extras.medianFee
      : controller.mempoolBlocks[controller.indexShowBlock.value].medianFee!;

  num totalFees = isAccepted
      ? controller.txDetailsConfirmed!.extras.totalFees
      : controller.mempoolBlocks[controller.indexShowBlock.value].totalFees!;

  List<num> feeRange = isAccepted
      ? controller.txDetailsConfirmed!.extras.feeRange
      : controller.mempoolBlocks[controller.indexShowBlock.value].feeRange!;

  return GlassContainer(
    child: Column(children: [
      BitNetListTile(
        leading: const Icon(
          FontAwesomeIcons.moneyBill,
          size: AppTheme.cardPadding * 0.75,
        ),
        text: L10n.of(context)!.feeDistribution,
        trailing: Container(
          child: Row(
            children: [
              Text(
                '\$${controller.formatAmount(((totalFees / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}',
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
              '\$${(((medianFee * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
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
                      colors: [AppTheme.errorColor, AppTheme.successColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.1, 0.9],
                      tileMode: TileMode.clamp)),
              minimum: feeRange.first.toDouble(),
              maximum: feeRange.last.toDouble(),
              markerPointers: [
                LinearWidgetPointer(
                    value: medianFee.toDouble(),
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
                      '\$${(((feeRange.first * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppTheme.errorColor,
                          )),
                  Text(
                      '\$${(((feeRange.last * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppTheme.successColor,
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: AppTheme.cardPadding,
      ),
    ]),
  );
}
