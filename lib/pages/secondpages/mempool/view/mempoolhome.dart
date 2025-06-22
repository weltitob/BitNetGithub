import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/secondpages/mempool/colorhelper.dart';
import 'package:bitnet/pages/secondpages/mempool/components/block_details/block_header.dart';
import 'package:bitnet/pages/secondpages/mempool/components/block_details/block_health_widget.dart';
import 'package:bitnet/pages/secondpages/mempool/components/block_details/block_size_widget.dart';
import 'package:bitnet/pages/secondpages/mempool/components/block_details/block_transactions_search.dart';
import 'package:bitnet/pages/secondpages/mempool/components/block_details/fee_distribution_widget.dart';
import 'package:bitnet/pages/secondpages/mempool/components/block_details/mining_info_card.dart';
import 'package:bitnet/pages/secondpages/mempool/components/blocks_list_view.dart';
import 'package:bitnet/pages/secondpages/mempool/components/difficulty_adjustment_card.dart';
import 'package:bitnet/pages/secondpages/mempool/components/fear_and_greed_card_optimized.dart';
import 'package:bitnet/pages/secondpages/mempool/components/hashrate_card_optimized.dart';
import 'package:bitnet/pages/secondpages/mempool/components/transaction_fee_card.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/model/fear_gear_chart_model.dart';
import 'package:bitnet/pages/secondpages/mempool/widget/data_widget.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
  final ScrollController _controller = ScrollController();
  final ScrollController listScrollController = ScrollController();
  List<BitcoinTransaction> onchainTransactions = List.empty(growable: true);
  List<BitcoinTransaction> onchainTransactionsFull = List.empty(growable: true);

  handleSearch(String query) {
    return query;
  }

  final key1 = GlobalKey();

  Future<void> getDataBlockHeightSearch() async {
    if (controller.blockHeight == null) {
      print('Block height is null, skipping data fetch');
      return;
    }
    
    try {
      controller.isLoading.value = true;
      controller.bitcoinData.clear();
      
      // Fetch block data with error handling for each call
      try {
        await controller.getDataHeight(controller.blockHeight! + 15);
      } catch (e) {
        print('Failed to fetch block height +15: $e');
      }
      
      try {
        await controller.getDataHeight(controller.blockHeight!);
      } catch (e) {
        print('Failed to fetch current block height: $e');
      }
      
      try {
        await controller.getDataHeight(controller.blockHeight! - 15);
      } catch (e) {
        print('Failed to fetch block height -15: $e');
      }
      
      // Safely find the block index with bounds checking
      controller.indexBlock.value = controller.bitcoinData
          .indexWhere((e) => e.height == controller.blockHeight);
      
      if (controller.indexBlock.value == -1) {
        print('Block not found in bitcoinData, using index 0');
        controller.indexBlock.value = 0;
      }
      
      controller.selectedIndex = controller.indexBlock.value;
      
      // Ensure we have data before accessing by index
      if (controller.bitcoinData.isEmpty) {
        print('No bitcoin data available');
        controller.isLoading.value = false;
        return;
      }
      
      // Safely access block data
      if (controller.indexBlock.value < controller.bitcoinData.length &&
          controller.bitcoinData[controller.indexBlock.value].id != null) {
        
        try {
          await controller.txDetailsConfirmedF(
              controller.bitcoinData[controller.indexBlock.value].id!);
          
          // Safe transaction processing
          try {
            Map<String, dynamic> data =
                Get.find<WalletsController>().onchainTransactions;
            if (data.isNotEmpty && controller.txDetailsConfirmed?.id != null) {
              onchainTransactions = await Future.microtask(() {
                try {
                  BitcoinTransactionsList bitcoinTransactions =
                      BitcoinTransactionsList.fromJson(data);

                  return bitcoinTransactions.transactions
                      .where((tx) => tx.blockHash == controller.txDetailsConfirmed!.id)
                      .sorted((tx, tx1) => tx.timeStamp > tx1.timeStamp)
                      .toList();
                } catch (e) {
                  print('Error processing onchain transactions: $e');
                  return <BitcoinTransaction>[];
                }
              });
            }
          } catch (e) {
            print('Error fetching onchain transactions: $e');
          }
          
          // Safely fetch transaction details
          await controller.txDetailsF(
              controller.bitcoinData[controller.indexBlock.value].id!, 0);
              
        } catch (e) {
          print('Error fetching transaction details: $e');
        }
      }
      
      controller.isLoading.value = false;
      
      // Safe scroll animation
      try {
        await _controller.animateTo(
          controller.scrollValue.value.w +
              (140.w * controller.indexBlock.value).w,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        print('Error animating scroll: $e');
      }
      
    } catch (e) {
      print('Error in getDataBlockHeightSearch: $e');
      controller.isLoading.value = false;
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
          if (mounted && _controller.hasClients) {
            _controller.animateTo(
              controller.scrollValue.value.w,
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.easeInOut,
            );
          }
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
                            
                            // Blocks list view (mempool and confirmed blocks)
                            BlocksListView(
                              scrollController: _controller,
                              isLoading: controller.isLoading.value,
                              hasUserTxs: hasUserTxs,
                              onMempoolBlockTap: (index) {
                                controller.sendWebSocketMessage('{"track-mempool-block":$index}');
                                setState(() {
                                  controller.showNextBlock.value = true;
                                  controller.showBlock.value = false;
                                  controller.indexShowBlock.value = index;
                                  controller.selectedIndexData = index;
                                  controller.selectedIndex = -1;
                                });
                              },
                              onConfirmedBlockTap: (index) {
                                setState(() {
                                  controller.showBlock.value = true;
                                  controller.showNextBlock.value = false;
                                  controller.indexBlock.value = index;
                                  controller.selectedIndex = index;
                                  controller.selectedIndexData = -1;
                                  controller.txDetailsConfirmedF(controller.bitcoinData[index].id!)
                                    .then((_) async {
                                      Map<String, dynamic> data =
                                          Get.find<WalletsController>().onchainTransactions;
                                      if (data.isNotEmpty) {
                                        onchainTransactions = await Future.microtask(() {
                                          BitcoinTransactionsList bitcoinTransactions =
                                              BitcoinTransactionsList.fromJson(data);

                                          return bitcoinTransactions.transactions
                                              .where((tx) => tx.blockHash == controller.txDetailsConfirmed!.id)
                                              .sorted((tx, tx1) => tx.timeStamp > tx1.timeStamp)
                                              .toList();
                                        });
                                      }
                                    });
                                  controller.txDetailsF(controller.bitcoinData[index].id!, 0);
                                });
                              },
                            ),
                            
                            Obx(
                              () => controller.loadingDetail.value
                                  ? Center(
                                      child: dotProgress(context),
                                    )
                                  : Column(
                                      children: [
                                        // Unaccepted block details
                                        _buildUnacceptedBlockDetails(context),
                                        
                                        // Accepted block details
                                        _buildAcceptedBlockDetails(context, loc),
                                      ],
                                    ),
                            ),
                            
                            // Other content only shown when no block details are displayed
                            _buildMainContent(context, loc),
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

  // Build the unaccepted (mempool) block details section
  Widget _buildUnacceptedBlockDetails(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.showNextBlock.value,
        child: Column(
          children: [
            // Header with block info
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppTheme.cardPadding,
                  bottom: AppTheme.elementSpacing,
                ),
                child: Row(
                  children: [
                    Text(
                      controller.selectedIndexData == 0
                          ? L10n.of(context)!.nextBlock
                          : '${L10n.of(context)!.mempoolBlock} ${controller.selectedIndexData + 1}',
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
                      icon: const Icon(Icons.cancel)
                    )
                  ],
                ),
              ),
            ),

            // Search through transactions
            BlockTransactionsSearch(
              transactionCount: controller.blockTransactions.length,
              handleSearch: handleSearch,
              onTap: () {
                context.go("/wallet/unaccepted_block_transactions");
              },
              isEnabled: false,
            ),
            
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppTheme.cardPadding.w
              ),
              child: Column(
                children: [
                  SizedBox(height: AppTheme.cardPadding.h),
                  
                  // Fee distribution for unaccepted block
                  FeeDistributionWidget(isAccepted: false),
                  
                  const SizedBox(height: AppTheme.elementSpacing),
                  
                  // Block size for unaccepted block
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      controller.txDetailsConfirmed == null
                          ? const SizedBox()
                          : BlockSizeWidget(isAccepted: false)
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.cardPadding * 3),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  // Build the accepted block details section
  Widget _buildAcceptedBlockDetails(BuildContext context, Location loc) {
    return Obx(
      () => Visibility(
        visible: controller.showBlock.value,
        child: controller.bitcoinData.isNotEmpty && !controller.txDetailsConfirmed.isNull
            ? Column(
                children: [
                  // Block header with block number and hash
                  BlockHeader(
                    blockHeight: controller.bitcoinData[controller.indexBlock.value].height.toString(),
                    blockId: controller.txDetailsConfirmed!.id,
                    onClose: () {
                      setState(() {
                        controller.showBlock.value = false;
                        controller.selectedIndex = -1;
                        controller.selectedIndexData = -1;
                      });
                    },
                  ),
                  
                  // Search through transactions
                  BlockTransactionsSearch(
                    transactionCount: controller.bitcoinData.isNotEmpty 
                        ? controller.bitcoinData[controller.indexBlock.value].txCount ?? 0
                        : 0,
                    handleSearch: handleSearch,
                    onTap: () {
                      context.push("/wallet/block_transactions");
                    },
                    isEnabled: false,
                  ),
                  
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding.w
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppTheme.elementSpacing),
                        
                        // User's transactions in this block
                        ...onchainTransactions.map(
                          (transaction) => TransactionItem(
                            data: TransactionItemData(
                              timestamp: transaction.timeStamp,
                              status: transaction.numConfirmations > 0
                                  ? TransactionStatus.confirmed
                                  : TransactionStatus.pending,
                              type: TransactionType.onChain,
                              direction: transaction.amount!.contains("-")
                                  ? TransactionDirection.sent
                                  : TransactionDirection.received,
                              receiver: transaction.amount!.contains("-")
                                  ? transaction.destAddresses.last.toString()
                                  : transaction.destAddresses.first.toString(),
                              txHash: transaction.txHash.toString(),
                              fee: 0,
                              amount: transaction.amount!.contains("-")
                                  ? transaction.amount.toString()
                                  : "+" + transaction.amount.toString(),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: AppTheme.elementSpacing),
                        
                        // Mining information card
                        MiningInfoCard(
                          timestamp: DateTime.fromMillisecondsSinceEpoch(
                            controller.txDetailsConfirmed!.timestamp * 1000
                          ).toUtc().add(Duration(
                            milliseconds: loc.currentTimeZone.offset
                          )),
                          poolName: controller.txDetailsConfirmed!.extras.pool.name,
                          rewardAmount: controller.txDetailsConfirmed!.extras.reward / 
                              100000000 * controller.currentUSD.value,
                        ),
                        
                        const SizedBox(height: AppTheme.elementSpacing),
                        
                        // Fee distribution for accepted block
                        FeeDistributionWidget(isAccepted: true),
                        
                        const SizedBox(height: AppTheme.elementSpacing),

                        // Block size and health widgets
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1, // This ensures a square shape
                                child: BlockSizeWidget(isAccepted: true),
                              ),
                            ),
                            SizedBox(width: AppTheme.elementSpacing),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: BlockHealthWidget(isAccepted: true),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ),
                  ),
                  
                  Container(height: AppTheme.cardPadding * 2.5.h)
                ],
              )
            : const SizedBox()
      ),
    );
  }

  // Build the main content section (shown when no block details are displayed)
  Widget _buildMainContent(BuildContext context, Location loc) {
    return Obx(
      () => controller.showBlock.value || controller.showNextBlock.value
          ? const SizedBox()
          : Column(
              children: [
                SizedBox(height: AppTheme.cardPadding.h * 1),
                // Transaction fees card
                TransactionFeeCard(
                  fees: controller.fees,
                  highPriority: controller.highPriority.value,
                  currentUSD: controller.currentUSD.value,
                  isLoading: controller.transactionLoading.value,
                ),
                
                SizedBox(height: AppTheme.cardPadding.h * 1),
                
                // Difficulty adjustment card
                DifficultyAdjustmentCard(
                  da: controller.da,
                  days: controller.days,
                  isLoading: controller.daLoading.value,
                ),
                
                SizedBox(height: AppTheme.cardPadding.h * 1),
                
                // Hashrate card - Optimized version
                HashrateCardOptimized(),
                
                SizedBox(height: AppTheme.cardPadding.h * 1),
                
                // Fear & Greed Index card - Optimized version
                FearAndGreedCardOptimized(),
                
                SizedBox(height: AppTheme.cardPadding.h * 1),
                
                // Last transactions
                _buildLastTransactions(),
                
                SizedBox(height: AppTheme.cardPadding.h * 2),
              ],
            ),
    );
  }

  // Hashrate data and methods
  List<ChartLine> hashrateChartData = [];
  List<Difficulty> hashrateChartDifficulty = [];
  bool hashrateLoading = true;

  Future<void> getHashrateData([String period = '1M']) async {
    // This is needed for backward compatibility - in a future update
    // this can be removed when the MempoolController is fully implemented
    // and the HashrateCard is updated to use it directly
  }

  // Fear & Greed data
  FearGearChartModel fearGreedData = FearGearChartModel();
  bool fearGreedLoading = true;
  String formattedFearGreedDate = '';

  Future<void> getFearGreedData() async {
    // This is needed for backward compatibility - in a future update
    // this can be removed when the MempoolController is fully implemented
    // and the FearAndGreedCard is updated to use it directly
  }

  // Last transactions widget
  Widget _buildLastTransactions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppTheme.cardPadding / 2,
              bottom: AppTheme.elementSpacing,
            ),
            child: Text(
              "Latest Transactions",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...onchainTransactionsFull
              .take(5)
              .map(
                (transaction) => TransactionItem(
                  data: TransactionItemData(
                    timestamp: transaction.timeStamp,
                    status: transaction.numConfirmations > 0
                        ? TransactionStatus.confirmed
                        : TransactionStatus.pending,
                    type: TransactionType.onChain,
                    direction: transaction.amount!.contains("-")
                        ? TransactionDirection.sent
                        : TransactionDirection.received,
                    receiver: transaction.amount!.contains("-")
                        ? transaction.destAddresses.last.toString()
                        : transaction.destAddresses.first.toString(),
                    txHash: transaction.txHash.toString(),
                    fee: 0,
                    amount: transaction.amount!.contains("-")
                        ? transaction.amount.toString()
                        : "+" + transaction.amount.toString(),
                  ),
                ),
              ).toList(),
        ],
      ),
    );
  }

  // Helper function to check if a block contains user transactions
  bool hasUserTxs(String blockhash) {
    return onchainTransactionsFull
            .firstWhereOrNull((tx) => tx.blockHash == blockhash) !=
        null;
  }
}