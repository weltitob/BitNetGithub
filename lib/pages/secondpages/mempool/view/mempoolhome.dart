import 'package:animate_do/animate_do.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/secondpages/mempool/colorhelper.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/widget/data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class MempoolHome extends StatefulWidget {
  const MempoolHome({Key? key}) : super(key: key);

  @override
  State<MempoolHome> createState() => _MempoolHomeState();
}

class _MempoolHomeState extends State<MempoolHome> {
  final controller = Get.put(HomeController());
  final TextFieldController = TextEditingController();
  //final transactionCtrl = Get.put(TransactionController());
  final ScrollController _controller = ScrollController();


  handleSearch(String query) {
    return query;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    setState(() {
      controller.showBlock.value = true;
      controller.showNextBlock.value =
      false;
      controller.indexBlock.value = 0;
      controller.selectedIndex = 0;
      controller.selectedIndexData = -1;
      controller.txDetailsConfirmedF(
          controller
              .bitcoinData[0].id!);
      controller.txDetailsF(
          controller.bitcoinData[0].id!,
          0);
    });

    Future.delayed(Duration(seconds: 1), () {
      _controller.animateTo(
        1150.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: 'Mempool',
        onTap: (){
          context.pop();
        },
        actions: [
          IconButton(
            onPressed: () {
              context.go('/wallet/transaction');
            },
            icon: const Icon(Icons.search),
          ),
        ], context: context,
      ),
      body: SingleChildScrollView(
          child:  Obx(()=> controller.socketLoading.isTrue?Center(child: CircularProgressIndicator(),): Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: AppTheme.cardPadding * 3,),
              Container(
                margin: EdgeInsets.only(
                    top: AppTheme.cardPadding, left: AppTheme.cardPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Blockchain",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'av. block time:',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          width: AppTheme.elementSpacing,
                        ),
                        Text(
                          '~ ${(controller.da!.timeAvg! / 60000).toStringAsFixed(1)} minutes',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          width: AppTheme.elementSpacing,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppTheme.elementSpacing / 2,
              ),
              SingleChildScrollView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    Obx(() {
                      return controller.isLoading.isTrue
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : controller.mempoolBlocks.isEmpty
                          ? const Text(
                        'Something went wrong!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      )
                          : SizedBox(
                        height: 255,
                        child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.mempoolBlocks.length,
                            itemBuilder: (context, index) {
                              var min = (index + 1) *
                                  (controller.da!.timeAvg! / 60000);
                              return GestureDetector(
                                onTap: () {
                                  channel.sink.add('{"track-mempool-block":$index}');
                                  setState(() {
                                    controller.showNextBlock.value = true;
                                    controller.showBlock.value = false;
                                    controller.indexShowBlock.value =
                                        index;
                                    controller.selectedIndexData = index;
                                    controller.selectedIndex = -1;
                                  });
                                  // controller.getWebSocketData();
                                },
                                child: Flash(
                                  infinite: true,
                                  delay: const Duration(seconds: 10),
                                  duration: const Duration(seconds: 5),
                                  child: DataWidget.notAccepted(
                                    key: index == 0
                                        ? controller.containerKey
                                        : GlobalKey(),
                                    mempoolBlocks:
                                    controller.mempoolBlocks[index],
                                    mins: min.toStringAsFixed(0),
                                    index: controller.selectedIndexData ==
                                        index
                                        ? 1
                                        : 0,
                                    singleTx: false,
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
                    Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                      decoration: BoxDecoration(
                        borderRadius: AppTheme.cardRadiusCircular,
                        color: Colors.grey,
                      ),
                      height: AppTheme.cardPadding * 6,
                      width: AppTheme.elementSpacing / 3,
                    ),
                    Obx(() {
                      return controller.isLoading.isTrue
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : controller.bitcoinData.isEmpty
                          ? const Text(
                        'Something went wrong!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      )
                          : SizedBox(
                        height: 255,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.bitcoinData.length,
                            itemBuilder: (context, index) {
                              double size =
                                  controller.bitcoinData[index].size! /
                                      1000000;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controller.showBlock.value = true;
                                    controller.showNextBlock.value =
                                    false;
                                    controller.indexBlock.value = index;
                                    controller.selectedIndex = index;
                                    controller.selectedIndexData = -1;
                                    controller.txDetailsConfirmedF(
                                        controller
                                            .bitcoinData[index].id!);
                                    controller.txDetailsF(
                                        controller.bitcoinData[index].id!,
                                        0);
                                  });
                                },
                                child: DataWidget.accepted(
                                  blockData:
                                  controller.bitcoinData[index],
                                  txId: controller.bitcoinData[index].id,
                                  size: size,
                                  time: controller.formatTimeAgo(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          (controller.bitcoinData[index]
                                              .timestamp! *
                                              1000))),
                                  index: controller.selectedIndex == index
                                      ? 1
                                      : 0,
                                  singleTx: false,
                                ),
                              );
                            }),
                      );
                    }),
                  ],
                ),
              ),
              Obx(
                    () => Visibility(
                  visible: controller.showNextBlock.value,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppTheme.cardPadding,
                          bottom: AppTheme.elementSpacing),
                      child: Row(
                        children: [
                          Text(
                            controller.selectedIndexData == 0
                                ? 'Next Block'
                                : 'Mempool block ${controller.selectedIndexData + 1}',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  controller.showNextBlock.value = false;
                                  controller.selectedIndex = -1;
                                  controller.selectedIndexData = -1;
                                });
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //----------------------UNACCEPTED BLOCKS--------------

              Obx(
                    () => Visibility(
                  visible: controller.showNextBlock.value,
                  child: Container(
                    child: Column(children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     context.go(
                      //         "/wallet/block_transactions"); //${controller.txDetailsConfirmed!.id}
                      //   },
                      //   //TEXT HIER ZU SEARCH TROUGH 7825 transactions oder so senden...
                      //   child: SearchFieldWidget(
                      //     isSearchEnabled: false,
                      //     hintText: controller
                      //             .mempoolBlocks[controller.indexShowBlock.value]
                      //             .nTx!
                      //             .toStringAsFixed(0) +
                      //         " transactions",
                      //     handleSearch: handleSearch,
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          context.go(
                              "/wallet/unaccepted_block_transactions"); //${controller.txDetailsConfirmed!.id}
                        },
                        //TEXT HIER ZU SEARCH TROUGH 7825 transactions oder so senden...
                        child: SearchFieldWidget(
                          isSearchEnabled: false,
                          hintText:
                          '${controller.blockTransactions.length} transactions',
                          handleSearch: handleSearch,
                        ),
                      ),
                      SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      feeDistributionUnaccepted(),
                      SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing),
                        child: MyDivider(),
                      ),
                      SizedBox(
                        height: AppTheme.elementSpacing,
                      ),

                      Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            controller.txDetailsConfirmed==null?  SizedBox(): blockSizeUnaccepted()],
                        ),
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding * 3,
                      ),
                    ]),
                  ),
                ),
              ),

              //-----------------ACCEPTED BLOCKS-----------------

              Obx(
                    () => Visibility(
                  visible: controller.showBlock.value,
                  child: controller.bitcoinData.isNotEmpty
                      ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppTheme.cardPadding,
                          bottom: AppTheme.elementSpacing),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Block',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                  ' ${controller.bitcoinData[controller.indexBlock.value].height}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                    color: AppTheme.colorBitcoin,
                                  ))
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                      controller.txDetailsConfirmed!.id));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                          Text('Copied to Clipboard')));
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.copy,
                                      color: AppTheme.white80,
                                      size: AppTheme.elementSpacing * 1.5,
                                    ),
                                    SizedBox(
                                      width: AppTheme.elementSpacing / 2,
                                    ),
                                    Text(
                                      controller.txDetailsConfirmed==null?'':  '${controller.txDetailsConfirmed?.id.toString().substring(0, 5)}...${controller.txDetailsConfirmed?.id.toString().substring(controller.txDetailsConfirmed!.id.length - 5)}',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: AppTheme.elementSpacing / 2,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.showBlock.value = false;
                                      controller.selectedIndex = -1;
                                      controller.selectedIndexData = -1;
                                    });
                                  },
                                  icon: const Icon(Icons.cancel)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                      : const SizedBox(),
                ),
              ),
              Obx(
                    () => Visibility(
                    visible: controller.showBlock.value,
                    child: controller.mempoolBlocks.isNotEmpty
                        ? controller.txDetailsConfirmed == null
                        ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                        : Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.go(
                                "/wallet/block_transactions"); //${controller.txDetailsConfirmed!.id}
                          },
                          //TEXT HIER ZU SEARCH TROUGH 7825 transactions oder so senden...
                          child: SearchFieldWidget(
                            isSearchEnabled: false,
                            hintText:
                            '${controller.bitcoinData[controller.indexBlock.value].txCount} transactions',
                            handleSearch: handleSearch,
                          ),
                        ),
                        Container(
                          child: Column(children: [
                            BitNetListTile(
                              leading: Icon(Icons.timelapse),
                              text: 'Mined at',
                              trailing: Container(
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd hh:mm')
                                          .format((DateTime
                                          .fromMillisecondsSinceEpoch(
                                          controller
                                              .txDetailsConfirmed!
                                              .timestamp *
                                              1000))),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("time ago..."),
                                  ],
                                ),
                              ),
                            ),
                            BitNetListTile(
                              leading: Icon(FontAwesomeIcons.truckPickup),
                              text: 'Miner',
                              trailing: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                          AppTheme.elementSpacing / 2,
                                          vertical:
                                          AppTheme.elementSpacing /
                                              3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          AppTheme.cardRadiusSmall,
                                          color: AppTheme.colorBitcoin),
                                      child: Text(
                                        (' ${controller.txDetailsConfirmed!.extras.pool.name} '),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BitNetListTile(
                              leading: Icon(FontAwesomeIcons.bitcoin),
                              text: 'Miner Reward (Subsidy + fees)',
                              trailing: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          (controller.txDetailsConfirmed!
                                              .extras.reward /
                                              100000000)
                                              .toStringAsFixed(3),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: const Offset(0, 2),
                                          child: Text(
                                            ' BTC  ',
                                            style: TextStyle(
                                                color:
                                                Colors.grey.shade300,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Text(
                                          '  \$${controller.formatAmount((controller.txDetailsConfirmed!.extras.reward / 100000000 * controller.currentUSD.value).toStringAsFixed(0))}',
                                          style: const TextStyle(
                                            color: AppTheme.successColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppTheme.elementSpacing,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.elementSpacing),
                              child: MyDivider(),
                            ),
                            feeDistributionAccepted(),
                            SizedBox(
                              height: AppTheme.elementSpacing,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.elementSpacing),
                              child: MyDivider(),
                            ),
                            SizedBox(height: AppTheme.elementSpacing),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppTheme.cardPadding),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  blockSizeAccepted(),
                                  blockHealth(),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          height: AppTheme.cardPadding * 3,
                        )
                      ],
                    )
                        : const Text('')),
              ),
              transactionfees(),
            ],
          ),
          )),
    );
  }

  Widget transactionfees() {
    return Obx(
          () => controller.showBlock.value || controller.showNextBlock.value
          ? const SizedBox()
          : Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: AppTheme.cardPadding),
            child: Text(
              "Transaction fees:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: AppTheme.elementSpacing,
          ),
          Container(
            margin:
            EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Obx(() {
              return controller.transactionLoading.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Expanded(
                  //   flex: 3,
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         '${controller.fees?.economyFee} sat/vB' ??
                  //             '',
                  //         maxLines: 1,
                  //         overflow:
                  //         TextOverflow.ellipsis,
                  //       ),
                  //       const Divider(),
                  //       Text(
                  //         controller.fees == null
                  //             ? ''
                  //             : '\$ ${controller.dollarConversion(controller.fees!.economyFee!).toStringAsFixed(2)}',
                  //         overflow:
                  //         TextOverflow.ellipsis,
                  //         style: const TextStyle(
                  //           color: Colors.green,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(width: 20),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: AppTheme.cardRadiusSmall,
                          color:
                          Theme.of(context).colorScheme.primary,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing * 1,
                            vertical: AppTheme.elementSpacing / 3),
                        child: Text(
                          'Low',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      Text(
                        '${controller.fees?.hourFee} sat/vB' ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
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
                                      (controller.fees!
                                          .hourFee!)
                                          .toDouble(),
                                      false)
                                      .first,
                                  25))),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: AppTheme.cardRadiusSmall,
                          color:
                          Theme.of(context).colorScheme.primary,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing * 1,
                            vertical: AppTheme.elementSpacing / 3),
                        child: Text(
                          'Medium',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      Text(
                        '${controller.fees?.halfHourFee} sat/vB' ??
                            '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
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
                                  25))),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: AppTheme.cardRadiusSmall,
                          color:
                          Theme.of(context).colorScheme.primary,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing * 1,
                            vertical: AppTheme.elementSpacing / 3),
                        child: Text(
                          'High',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      Text(
                        '${controller.highPriority.value} sat/vB' ??
                            '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
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
          difficultyAdjustment(),
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
          "Difficulty Adjustment",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      SizedBox(
        height: AppTheme.elementSpacing,
      ),
      Obx(() {
        return controller.transactionLoading.isTrue
            ? const Center(child: CircularProgressIndicator())
            : Obx(() {
          return controller.daLoading.isTrue
              ? const Center(child: CircularProgressIndicator())
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
                    SizedBox(
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
              'Health',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              width: AppTheme.elementSpacing / 2,
            ),
            Icon(
              Icons.help_outline_rounded,
              color: AppTheme.white80,
              size: AppTheme.cardPadding * 0.75,
            )
          ],
        ),
        SizedBox(
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
        SizedBox(
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
              'Block Size',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              width: AppTheme.elementSpacing / 2,
            ),
            Icon(
              Icons.help_outline_rounded,
              color: AppTheme.white80,
              size: AppTheme.cardPadding * 0.75,
            )
          ],
        ),
        SizedBox(
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
        SizedBox(
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
              'Block Size',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              width: AppTheme.elementSpacing / 2,
            ),
            Icon(
              Icons.help_outline_rounded,
              color: AppTheme.white80,
              size: AppTheme.cardPadding * 0.75,
            )
          ],
        ),
        SizedBox(
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
        SizedBox(
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
        leading: Icon(FontAwesomeIcons.moneyBill),
        text: 'Fee Distribution',
        trailing: Container(
          child: Row(
            children: [
              Text(
                (controller.txDetailsConfirmed!.extras.totalFees / 100000000)
                    .toStringAsFixed(3),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 2),
                child: Text(
                  ' BTC  ',
                  style: TextStyle(color: Colors.grey.shade300, fontSize: 12),
                ),
              ),
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
      SizedBox(
        height: AppTheme.elementSpacing,
      ),
      Text(
          'Median: ' +
              '~' +
              '\$${(((controller.txDetailsConfirmed!.extras.medianFee * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppTheme.white90,
          )),
      SizedBox(
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
              axisTrackStyle: LinearAxisTrackStyle(
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
                      decoration: BoxDecoration(
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
        leading: Icon(FontAwesomeIcons.moneyBill),
        text: 'Fee Distribution',
        trailing: Container(
          child: Row(
            children: [
              Text(
                controller.mempoolBlocks.isNotEmpty
                    ? controller.numberFormat.format(controller
                    .mempoolBlocks[controller.indexShowBlock.value]
                    .totalFees! /
                    100000000)
                    : '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 2),
                child: Text(
                  ' BTC  ',
                  style: TextStyle(color: Colors.grey.shade300, fontSize: 12),
                ),
              ),
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
      SizedBox(
        height: AppTheme.elementSpacing,
      ),
      Text(
          'Median: ' +
              '~' +
              '\$${(((controller.mempoolBlocks[controller.indexShowBlock.value].medianFee! * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppTheme.white90,
          )),
      SizedBox(
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
              axisTrackStyle: LinearAxisTrackStyle(
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
                      decoration: BoxDecoration(
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
}

