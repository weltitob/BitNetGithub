import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
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
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BlockTransactions extends StatefulWidget {
  const BlockTransactions({super.key});

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
    Map<String, dynamic> data = Get.find<WalletsController>().onchainTransactions;
    if (data.isNotEmpty) {
      Future.microtask(() {
        BitcoinTransactionsList bitcoinTransactions = BitcoinTransactionsList.fromJson(data);

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
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !controller.isLoadingMoreTx.value) {
      if (reachedFinalPage) return;
      controller.isLoadingMoreTx.value = true;

      await Future.delayed(const Duration(seconds: 2));

      int returnedTxsAmt = await controller.txDetailsMore(controller.txDetailsConfirmed!.id, (currentPage + 1) * 25);
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
        return (test.txid.contains(query) && test.locktime >= filterController.start && test.locktime <= filterController.end) ||
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
    // Use DateFormat for formatting the timestamp
    final chartLine = walletcontroller.chartLines.value;
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";
    final bitcoinPrice = chartLine?.price ?? 0;

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.blockTransaction,
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
              child: SearchFieldWidget(
                node: searchNode,
                // onChanged: (value) {
                //   controller.isLoadingTx.value = true;
                //   if (value.isEmpty) {
                //     controller.txDetails = controller.txDetailsReset;

                //   } else {
                //     controller.txDetails.clear;
                //     controller.txDetails = controller.txDetailsFound
                //         .where((element) => element.txid == value)
                //         .toList();
                //   }
                //   controller.isLoadingTx.value = false;
                // },
                hintText: '${controller.bitcoinData[controller.indexBlock.value].txCount} transactions',
                handleSearch: handleSearch,
                isSearchEnabled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.filter,
                    color: Theme.of(context).brightness == Brightness.dark ? AppTheme.white60 : AppTheme.black60,
                    size: AppTheme.cardPadding * 0.75,
                  ),
                  onPressed: () async {
                    await BitNetBottomSheet(
                      context: context,
                      child: const WalletFilterScreen(hideFilters: true),
                    );
                    handleSearch(lastQuery);
                  },
                ),
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
                ? Center(
                    child: dotProgress(context),
                  )
                : controller.txDetails.isEmpty
                    ? const SizedBox()
                    //the listview builder has some space for the bottom
                    : Obx(() {
                        controller.isLoadingMoreTx.value;
                        return MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 8),
                              //padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.txDetails.length,
                              itemBuilder: (context, index) {
                                if (controller.isLoadingMoreTx.value && index == (controller.txDetails.length - 1)) {
                                  return Center(
                                      child: Padding(padding: const EdgeInsets.symmetric(vertical: 32), child: dotProgress(context)));
                                }
                                BitcoinTransaction? ownedTransaction = ownedTransactions.firstWhereOrNull((tx) =>
                                    tx.blockHash == controller.txDetails[index].txid ||
                                    tx.txHash == controller.txDetails[index].txid ||
                                    tx.rawTxHex == controller.txDetails[index].txid);
                                int volume = 0;
                                for (int i = 0; i < controller.txDetails[index].vout.length; i++) {
                                  volume += controller.txDetails[index].vout[i].value;
                                }
                                double btcVolume = CurrencyConverter.convertSatoshiToBTC(volume.toDouble());
                                String currVolume =
                                    CurrencyConverter.convertCurrency(BitcoinUnits.SAT.name, volume.toDouble(), currency!, bitcoinPrice);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  child: GlassContainer(
                                    borderRadius: BorderRadius.all(Radius.circular(AppTheme.cardPadding * 0.5)),
                                    child: Column(
                                      children: [
                                        BitNetListTile(
                                          onTap: () {
                                            final controllerTransaction = Get.put(
                                              TransactionController(
                                                txID: controller.txDetails[index].txid.toString(),
                                              ),
                                            );
                                            controllerTransaction.txID = controller.txDetails[index].txid.toString();
                                            controllerTransaction.getSingleTransaction(controllerTransaction.txID!);
                                            controllerTransaction.changeSocket();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const SingleTransactionScreen(),
                                              ),
                                            );
                                          },
                                          text:
                                              '${controller.txDetails[index].txid.substring(0, 5)}...${controller.txDetails[index].txid.substring(controller.txDetails[index].txid.length - 5)}' ??
                                                  '',
                                          trailing: SizedBox(
                                            width: 145,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                if (ownedTransaction != null) ...[
                                                  Container(
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: AppTheme.colorBitcoin,
                                                    ),
                                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                                    child: const Center(
                                                      child: Text(
                                                        'has Tx',
                                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                ],
                                                // Text(
                                                //   controller.isBTC.value
                                                //       ? '${btcVolume.toStringAsFixed(8)} BTC'
                                                //       : '${currVolume} ${getCurrency(currency)}',
                                                //   style: Theme.of(context).textTheme.labelMedium,
                                                // ),
                                                AmountPreviewer(
                                                  unitModel: BitcoinUnitModel(bitcoinUnit: BitcoinUnits.SAT, amount: volume),
                                                  textStyle: Theme.of(context).textTheme.labelMedium!,
                                                  textColor: null,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (ownedTransaction != null) ...[
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context).brightness == Brightness.light
                                                          ? Colors.black.withAlpha(50)
                                                          : Colors.white.withAlpha(50)),
                                                  borderRadius: BorderRadius.circular(AppTheme.cardPadding * 0.2)),
                                              child: TransactionItem(
                                                  context: context,
                                                  data: TransactionItemData(
                                                    timestamp: ownedTransaction.timeStamp,
                                                    status: ownedTransaction.numConfirmations > 0
                                                        ? TransactionStatus.confirmed
                                                        : TransactionStatus.pending,
                                                    type: TransactionType.onChain,
                                                    direction: ownedTransaction.amount!.contains("-")
                                                        ? TransactionDirection.sent
                                                        : TransactionDirection.received,
                                                    receiver: ownedTransaction.amount!.contains("-")
                                                        ? ownedTransaction.destAddresses.last.toString()
                                                        : ownedTransaction.destAddresses.first.toString(),
                                                    txHash: ownedTransaction.txHash.toString(),
                                                    fee: 0,
                                                    amount: ownedTransaction.amount!.contains("-")
                                                        ? ownedTransaction.amount.toString()
                                                        : "+" + ownedTransaction.amount.toString(),
                                                  )),
                                            ),
                                          )
                                        ]
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
          ],
        ),
      ),
      context: context,
    );
  }

  String amountCalc(TransactionDetailsModel transaction) {
    int totalOutput = transaction.vout.fold(0, (sum, output) => sum + output.value);

    return totalOutput.toString();
  }
}
