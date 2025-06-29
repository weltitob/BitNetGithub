import 'dart:math';

import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/camera/qrscanneroverlay.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

class BitcoinAddressInformationScreen extends StatefulWidget {
  const BitcoinAddressInformationScreen({super.key, required this.state});
  final GoRouterState state;
  @override
  State<BitcoinAddressInformationScreen> createState() =>
      _BitcoinAddressInformationScreenState();
}

class _BitcoinAddressInformationScreenState
    extends State<BitcoinAddressInformationScreen> {
  bool isShowMore = false;
  final controller = Get.put(TransactionController());
  final homeController = Get.put(HomeController());
  bool isLoadingAddress = false;
  late ScrollController scrollController;
  List<TransactionItem> transactions = List.empty(growable: true);

  @override
  void initState() {
    scrollController = ScrollController();
    String address = widget.state.pathParameters['address']!;
    controller
        .getAddressComponent(widget.state.pathParameters['address'])
        .then((val) {
      //find and initialize specific transactions
      setState(() {});
      final homeController = Get.find<HomeController>();

      for (int index = 0;
          index < controller.subTransactionModel.length;
          index++) {
        int confirmation = 0;
        int height =
            controller.subTransactionModel[index].status?.blockHeight ?? 0;
        int chainTip = homeController.bitcoinData.first.height ?? 0;
        confirmation = max(1, chainTip - height + 1);
        num bitCoin = controller.subTransactionModel[index].fee! / 100000000;
        String feeUsd = (bitCoin * usdPrice).toStringAsFixed(2);
        String time =
            controller.subTransactionModel[index].status?.blockTime == null
                ? ''
                : DateTime.fromMillisecondsSinceEpoch(controller
                            .subTransactionModel[index].status!.blockTime!
                            .toInt() *
                        1000)
                    .toString();
        DateTime? timeDate =
            controller.subTransactionModel[index].status?.blockTime == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(controller
                        .subTransactionModel[index].status!.blockTime!
                        .toInt() *
                    1000);
        int value = controller
            .calculateAddressValue(controller.subTransactionModel[index]);

        if (controller.subTransactionModel[index].status?.blockTime != null) {
          List<String> date = time.split(" ");
          String singleDate = date[0];
          String times = date[1];
          List<String> splitTime = times.split(":");

          String hour = splitTime[0];
          String min = splitTime[1];
          time = '$singleDate $hour:$min';
        }

        // Initialize variables for amounts and addresses
        num totalReceived = 0;
        num totalSent = 0;
        String otherAddress = '';

        for (var vin in controller.subTransactionModel[index].vin!) {
          if (vin.prevout != null && vin.prevout!.value != null) {
            // Check if the input is from our address
            if (vin.prevout?.scriptpubkeyAddress == address) {
              totalSent += vin.prevout!.value!;
            }
          }
        }

        for (var vout in controller.subTransactionModel[index].vout!) {
          if (vout.value != null) {
            // Check if the output is to our address
            if (vout.scriptpubkeyAddress == address) {
              totalReceived += vout.value!;
            } else if (vout.scriptpubkeyAddress != null) {
              otherAddress = vout.scriptpubkeyAddress!;
            }
          }
        }

// Determine the net amount and direction
        num amount = totalReceived - totalSent;
        TransactionDirection direction;

        if (amount >= 0) {
          direction = TransactionDirection.received;
        } else {
          direction = TransactionDirection.sent;
        }

        transactions.add(TransactionItem(
            data: TransactionItemData(
          timestamp:
              timeDate != null ? (timeDate.millisecondsSinceEpoch ~/ 1000) : 0,
          type: TransactionType.onChain,
          direction: direction,
          txHash: controller.subTransactionModel[index].txid ?? '',
          amount: amount.toString(), // Format the amount as needed
          fee: controller.subTransactionModel[index].fee ?? 0,
          status:
              controller.subTransactionModel[index].status?.confirmed ?? false
                  ? TransactionStatus.confirmed
                  : TransactionStatus.failed,
          receiver: otherAddress ??
              'Unknown', // Handle case where address might not be found
          // other properties
        )));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String address = widget.state.pathParameters['address']!;
    double balance =
        // widget.state.extra! as double != -1
        //     ? CurrencyConverter.convertSatoshiToBTC((widget.state.extra! as double))
        //     :
        ((controller.addressComponentModel?.chainStats.fundedTxoSum ?? 0) +
                    (controller
                            .addressComponentModel?.mempoolStats.fundedTxoSum ??
                        0) -
                    (controller.addressComponentModel?.chainStats.spentTxoSum ??
                        0) +
                    (controller
                            .addressComponentModel?.mempoolStats.spentTxoSum ??
                        0))
                .toDouble() /
            100000000.0;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";
    final chartLine = Get.find<WalletsController>().chartLines.value;
    final bitcoinPrice = chartLine?.price;

    String currBalance = CurrencyConverter.convertCurrency(
        'BTC', balance, currency, bitcoinPrice);
    String currSymbol = getCurrency(currency);
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: L10n.of(context)!.bitcoinInfoCard,
        onTap: () {
          context.pop();
        },
      ),
      context: context,
      body: Obx(
        () => controller.isLoadingAddress.value
            ? Center(
                child: dotProgress(context),
              )
            : CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: AppTheme.cardPadding * 3,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: Container(
                        margin: const EdgeInsets.all(AppTheme.cardPadding),
                        child: CustomPaint(
                          foregroundPainter:
                              Theme.of(context).brightness == Brightness.light
                                  ? BorderPainterBlack()
                                  : BorderPainter(),
                          child: Container(
                            padding: const EdgeInsets.all(
                                AppTheme.cardPadding / 1.25),
                            margin: const EdgeInsets.all(AppTheme.cardPadding),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: AppTheme.cardRadiusBigger),
                            child: PrettyQrView.data(
                                data: address,
                                decoration: const PrettyQrDecoration(
                                  shape: PrettyQrSmoothSymbol(
                                    roundFactor: 1,
                                  ),
                                  image: PrettyQrDecorationImage(
                                    image: const AssetImage(
                                        'assets/images/bitcoin.png'),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing),
                      child: BitNetListTile(
                        text: L10n.of(context)!.address,
                        trailing: Container(
                          width: AppTheme.cardPadding * 10,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            address,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppTheme.elementSpacing),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing),
                      child: BitNetListTile(
                        text: L10n.of(context)!.totalReceived,
                        trailing: Row(
                          children: [
                            Text(
                              '${((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 5),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing),
                      child: BitNetListTile(
                        text: L10n.of(context)!.totalSent,
                        trailing: Row(
                          children: [
                            Text(
                              '${((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 5),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing),
                      child: BitNetListTile(
                        text: L10n.of(context)!.balance,
                        trailing: Row(
                          children: [
                            Text(
                              '${balance.toStringAsFixed(8)} BTC',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$currSymbol $currBalance',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppTheme.elementSpacing),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppTheme.cardPadding.h * 1.75),
                          Text(L10n.of(context)!.activity,
                              style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: AppTheme.elementSpacing.h),
                        ],
                      ),
                    ),
                  ),
                  Transactions(
                      hideLightning: true,
                      hideOnchain: true,
                      filters: [L10n.of(context)!.onchain],
                      customTransactions: transactions,
                      scrollController: scrollController),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
