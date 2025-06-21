import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/frostedcolorbackground.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/amount_previewer.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/mempool_models/txPaginationModel.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';

class BlinkingDot extends StatefulWidget {
  final Color color;
  final double size;

  const BlinkingDot({
    Key? key,
    required this.color,
    this.size = 12.0,
  }) : super(key: key);

  @override
  State<BlinkingDot> createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _opacityAnimation =
        Tween<double>(begin: 0.4, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withOpacity(_opacityAnimation.value),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.4 * _opacityAnimation.value),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

class BlockTransactions extends StatefulWidget {
  final bool isConfirmed;

  const BlockTransactions({
    super.key,
    this.isConfirmed = true,
  });

  @override
  State<BlockTransactions> createState() => _BlockTransactionsState();
}

class _BlockTransactionsState extends State<BlockTransactions> {
  final controller = Get.put(HomeController());
  late final ScrollController scrollController;
  late final WalletFilterController filterController;
  final TextFieldController = TextEditingController();
  List<BitcoinTransaction> ownedTransactions = List.empty(growable: true);

  int currentPage = 0;
  bool reachedFinalPage = false;
  String lastQuery = '';
  bool isTxTapped = false;
  late FocusNode searchNode;

  @override
  void initState() {
    super.initState();
    searchNode = FocusNode();
    searchNode.requestFocus();
    Get.delete<WalletFilterController>();
    filterController = Get.put(
      WalletFilterController(),
    );
    Map<String, dynamic> data =
        Get.find<WalletsController>().onchainTransactions;
    if (data.isNotEmpty) {
      Future.microtask(() {
        BitcoinTransactionsList bitcoinTransactions =
            BitcoinTransactionsList.fromJson(data);
        return bitcoinTransactions.transactions;
      }).then((val) {
        ownedTransactions = val;
      });
    }
    scrollController = ScrollController();
    scrollController.addListener(loadMoreTx);
  }

  @override
  void dispose() {
    searchNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void loadMoreTx() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !controller.isLoadingMoreTx.value) {
      if (reachedFinalPage) return;
      controller.isLoadingMoreTx.value = true;

      await Future.delayed(const Duration(seconds: 2));

      int returnedTxsAmt = await controller.txDetailsMore(
          controller.txDetailsConfirmed!.id, (currentPage + 1) * 25);
      currentPage++;
      if (returnedTxsAmt < 25 && returnedTxsAmt != -1) {
        reachedFinalPage = true;
        setState(() {});
      }
    }
  }

  handleSearch(String query) {
    controller.isLoadingTx.value = true;
    if (query.isEmpty) {
      controller.txDetails = controller.txDetailsReset;
    } else {
      controller.txDetails = controller.txDetailsReset.where((test) {
        return (test.txid.contains(query) &&
                test.locktime >= filterController.start &&
                test.locktime <= filterController.end) ||
            (test.txid.contains(query) && test.locktime == 0);
      }).toList();
    }
    lastQuery = query;

    controller.isLoadingTx.value = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final walletcontroller = Get.find<WalletsController>();
    final chartLine = walletcontroller.chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";
    final bitcoinPrice = chartLine?.price ?? 0;

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        text: widget.isConfirmed
            ? L10n.of(context)!.blockTransaction
            : '${L10n.of(context)!.blockTransaction} Pending',
        context: context,
        onTap: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const SizedBox(
              height: AppTheme.cardPadding * 3,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: SearchFieldWidget(
                node: searchNode,
                hintText: widget.isConfirmed
                    ? '${controller.bitcoinData[controller.indexBlock.value].txCount} transactions'
                    : '${controller.blockTransactions.length} transactions',
                handleSearch: handleSearch,
                isSearchEnabled: true,
                suffixIcon: widget.isConfirmed
                    ? IconButton(
                        icon: Icon(
                          FontAwesomeIcons.filter,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.white60
                              : AppTheme.black60,
                          size: AppTheme.cardPadding * 0.75,
                        ),
                        onPressed: () async {
                          await BitNetBottomSheet(
                            context: context,
                            child: const WalletFilterScreen(hideFilters: true),
                          );
                          handleSearch(lastQuery);
                        },
                      )
                    : null,
              ),
            ),

            // Content based on transaction type
            widget.isConfirmed
                ? _buildConfirmedTransactions(context, currency, bitcoinPrice)
                : _buildPendingTransactions(context),
          ],
        ),
      ),
      context: context,
    );
  }

  Widget _buildConfirmedTransactions(
      BuildContext context, String currency, double bitcoinPrice) {
    return controller.isLoadingTx.value
        ? Center(
            child: dotProgress(context),
          )
        : controller.txDetails.isEmpty
            ? const SizedBox()
            : Obx(() {
                controller.isLoadingMoreTx.value;
                return MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.txDetails.length,
                      itemBuilder: (context, index) {
                        if (controller.isLoadingMoreTx.value &&
                            index == (controller.txDetails.length - 1)) {
                          return Center(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 32),
                                  child: dotProgress(context)));
                        }
                        BitcoinTransaction? ownedTransaction =
                            ownedTransactions.firstWhereOrNull((tx) =>
                                tx.blockHash ==
                                    controller.txDetails[index].txid ||
                                tx.txHash == controller.txDetails[index].txid ||
                                tx.rawTxHex ==
                                    controller.txDetails[index].txid);
                        int volume = 0;
                        for (int i = 0;
                            i < controller.txDetails[index].vout.length;
                            i++) {
                          volume += controller.txDetails[index].vout[i].value;
                        }
                        double btcVolume =
                            CurrencyConverter.convertSatoshiToBTC(
                                volume.toDouble());

                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              final controllerTransaction = Get.put(
                                TransactionController(
                                  txID: controller.txDetails[index].txid
                                      .toString(),
                                ),
                              );
                              controllerTransaction.txID =
                                  controller.txDetails[index].txid.toString();
                              controllerTransaction.getSingleTransaction(
                                  controllerTransaction.txID!);
                              controllerTransaction.changeSocket();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SingleTransactionScreen(),
                                ),
                              );
                            },
                            child: GlassContainer(
                              borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: AppTheme.cardPadding * 2.h,
                                      height: AppTheme.cardPadding * 2.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          FontAwesomeIcons.cube,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${controller.txDetails[index].txid.substring(0, 10)}...${controller.txDetails[index].txid.substring(controller.txDetails[index].txid.length - 10)}',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  BlinkingDot(
                                                    color:
                                                        AppTheme.successColor,
                                                    size: 10,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  ownedTransaction != null
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppTheme
                                                                .colorBitcoin
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          child: Text(
                                                            'Your TX',
                                                            style: TextStyle(
                                                              color: AppTheme
                                                                  .colorBitcoin,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                              AmountPreviewer(
                                                unitModel: BitcoinUnitModel(
                                                    bitcoinUnit:
                                                        BitcoinUnits.SAT,
                                                    amount: volume),
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!,
                                                textColor: null,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              });
  }

  Widget _buildPendingTransactions(BuildContext context) {
    return controller.isLoadingTx.value
        ? Center(
            child: dotProgress(context),
          )
        : controller.blockTransactions.isEmpty
            ? const SizedBox()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.blockTransactions.length,
                itemBuilder: (context, index) {
                  double btcValue =
                      controller.blockTransactions[index][1] / 100000000;
                  controller.blockTransactions[index][3];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding, vertical: 8),
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.cube,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await Clipboard.setData(ClipboardData(
                                        text: controller
                                            .blockTransactions[index][0],
                                      ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('copied TXID'),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                    child: Text(
                                        controller.blockTransactions.isEmpty
                                            ? ''
                                            : '${controller.blockTransactions[index][0].substring(0, 10)}...${controller.blockTransactions[index][0].substring(controller.blockTransactions[index][0].length - 10)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          BlinkingDot(
                                            color: AppTheme.colorBitcoin,
                                            size: 10,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '${(controller.blockTransactions[index][1] / 100000000).toStringAsFixed(8)} BTC',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '\$${formatPriceDecimal(btcValue * usdPrice)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
  }

  String amountCalc(TransactionDetailsModel transaction) {
    int totalOutput =
        transaction.vout.fold(0, (sum, output) => sum + output.value);
    return totalOutput.toString();
  }
}
