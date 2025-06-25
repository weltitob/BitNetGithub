import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/transactions/base_transaction_details.dart';
import 'package:bitnet/components/transactions/transaction_amount_widget.dart';
import 'package:bitnet/components/transactions/transaction_detail_tile.dart';
import 'package:bitnet/components/transactions/transaction_details_container.dart';
import 'package:bitnet/components/transactions/transaction_header_widget.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

class OnChainTransactionDetails extends BaseTransactionDetails {
  final String txId;

  const OnChainTransactionDetails({
    required TransactionItemData data,
    required this.txId,
    Key? key,
  }) : super(data: data, key: key);

  @override
  OnChainTransactionDetailsState createState() =>
      OnChainTransactionDetailsState();
}

class OnChainTransactionDetailsState
    extends BaseTransactionDetailsState<OnChainTransactionDetails> {
  late final TransactionController transactionController;
  late final WalletsController walletController;
  late final HomeController homeController;

  @override
  void initState() {
    super.initState();
    transactionController = Get.put(TransactionController());
    transactionController.txID = widget.txId;
    //transactionController.loadTransactionByID();

    walletController = Get.find<WalletsController>();
    homeController = Get.put(HomeController());
  }

  @override
  void dispose() {
    // Stop tracking transaction when screen is closed
    homeController.sendWebSocketMessage('{"track-rbf-summary":true}');
    homeController.sendWebSocketMessage('{"track-tx":"stop"}');
    homeController.sendWebSocketMessage(
        '{"action":"want","data":["blocks","mempool-blocks"]}');
    homeController.isRbfTransaction.value = false;
    super.dispose();
  }

  @override
  String getHeaderTitle() => 'OnChain Transaction';

  @override
  Widget buildNetworkSpecificDetails() {
    if (transactionController.transactionModel == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Block information (for confirmed transactions)
        TransactionDetailTile(
          text: L10n.of(context)!.block,
          onTap: () {
            if (transactionController.transactionModel!.status!.blockHeight !=
                null) {
              homeController.blockHeight =
                  transactionController.transactionModel!.status!.blockHeight!;
              context.push('/wallet/bitcoinscreen/mempool');
            }
          },
          trailing: Row(
            children: [
              Text(
                "${transactionController.transactionModel!.status!.blockHeight ?? "--"}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: AppTheme.elementSpacing / 2),
              Icon(
                Icons.arrow_forward_ios,
                size: AppTheme.cardPadding * 0.75,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),

        // ETA (for pending transactions)
        if (!transactionController.transactionModel!.status!.confirmed!)
          TransactionDetailTile(
            text: 'ETA',
            trailing: Row(
              children: [
                SizedBox(
                  width: 170.w,
                  child: Text(
                    homeController.txPosition.value >= 7
                        ? L10n.of(context)!.inSeveralHours
                        : 'In ~ ${homeController.txPosition.value + 1 * 10}${L10n.of(context)!.minutesTx}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: AppTheme.cardRadiusCircular,
                  ),
                  child: Center(
                    child: Text(
                      L10n.of(context)!.accelerate,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget buildMainContainer() {
    return Obx(() {
      if (transactionController.isLoading.isTrue) {
        return const Center(child: CircularProgressIndicator());
      }

      if (transactionController.transactionModel == null) {
        return const Center(child: Text('Something went wrong'));
      }

      return Column(
        children: [
          // RBF Transaction notice
          if (homeController.isRbfTransaction.value)
            Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade400,
                borderRadius: AppTheme.cardRadiusCircular,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L10n.of(context)!.transactionReplaced,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(
                        text: homeController.replacedTx.value,
                      ));
                      overlayController
                          .showOverlay(L10n.of(context)!.copiedToClipboard);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: Text(
                            homeController.replacedTx.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.white,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                        const Icon(Icons.copy, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: AppTheme.elementSpacing),

          // Main transaction card
          TransactionDetailsContainer(
            child: Column(
              children: [
                // Transaction header with sender/receiver
                TransactionHeaderWidget(
                  data: widget.data,
                  senderLabel:
                      "Sender (${transactionController.transactionModel?.vin?.length})",
                  receiverLabel:
                      "Receiver (${transactionController.transactionModel?.vout?.length})",
                  onSenderTap: () => _showInputsBottomSheet(),
                  onReceiverTap: () => _showOutputsBottomSheet(),
                ),

                // Transaction amount
                TransactionAmountWidget(
                  data: widget.data,
                  useAmountColor: true,
                ),

                const SizedBox(height: AppTheme.elementSpacing),

                // Transaction details
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing),
                  child: Column(
                    children: [
                      // Volume information
                      TransactionDetailTile(
                        text: 'Transaction Volume',
                        trailing: _buildVolumeDisplay(),
                      ),

                      // Transaction ID
                      TransactionDetailTile(
                        text: 'TransactionID',
                        trailing: buildCopyableText(widget.txId),
                      ),

                      // Block information
                      TransactionDetailTile(
                        text: L10n.of(context)!.block,
                        onTap: () {
                          if (transactionController
                                  .transactionModel!.status!.blockHeight !=
                              null) {
                            homeController.blockHeight = transactionController
                                .transactionModel!.status!.blockHeight!;
                            context.push('/wallet/bitcoinscreen/mempool');
                          }
                        },
                        trailing: Row(
                          children: [
                            Text(
                              "${transactionController.transactionModel!.status!.blockHeight ?? "--"}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                            const SizedBox(width: AppTheme.elementSpacing / 2),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: AppTheme.cardPadding * 0.75,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ),

                      // Status
                      TransactionDetailTile(
                        text: L10n.of(context)!.status,
                        trailing: Center(
                          child: Text(
                            homeController.isRbfTransaction.value == true
                                ? L10n.of(context)!.replaced
                                : '${transactionController.confirmations == 0 ? '' : transactionController.confirmations} ' +
                                    transactionController
                                        .statusTransaction.value,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color:
                                      transactionController.transactionModel ==
                                              null
                                          ? AppTheme.errorColor
                                          : transactionController
                                                  .transactionModel!
                                                  .status!
                                                  .confirmed!
                                              ? AppTheme.successColor
                                              : homeController.isRbfTransaction
                                                          .value ==
                                                      true
                                                  ? AppTheme.colorBitcoin
                                                  : AppTheme.errorColor,
                                ),
                          ),
                        ),
                      ),

                      // Payment Network
                      TransactionDetailTile(
                        text: L10n.of(context)!.paymentNetwork,
                        trailing: Row(
                          children: [
                            Image.asset(
                              "assets/images/bitcoin.png",
                              width: AppTheme.cardPadding * 1,
                              height: AppTheme.cardPadding * 1,
                            ),
                            const SizedBox(width: AppTheme.elementSpacing / 2),
                            Text(
                              'Onchain',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),

                      // Time
                      TransactionDetailTile(
                        text: L10n.of(context)!.time,
                        leading: Icon(
                          Icons.access_time,
                          size: AppTheme.cardPadding * 0.75,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.white60
                              : AppTheme.black60,
                        ),
                        trailing: _buildTimeDisplay(),
                      ),

                      // ETA for pending transactions
                      if (!transactionController
                          .transactionModel!.status!.confirmed!)
                        TransactionDetailTile(
                          text: 'ETA',
                          trailing: Row(
                            children: [
                              SizedBox(
                                width: 170.w,
                                child: Text(
                                  homeController.txPosition.value >= 7
                                      ? L10n.of(context)!.inSeveralHours
                                      : 'In ~ ${homeController.txPosition.value + 1 * 10}${L10n.of(context)!.minutesTx}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: AppTheme.cardRadiusCircular,
                                ),
                                child: Center(
                                  child: Text(
                                    L10n.of(context)!.accelerate,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                      // Fee
                      TransactionDetailTile(
                        text: 'Fee',
                        trailing: _buildFeeDisplay(),
                      ),

                      const SizedBox(height: AppTheme.cardPadding),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildVolumeDisplay() {
    final chartLine = walletController.chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;

    num outputTotal = 0;
    if (transactionController.transactionModel != null) {
      for (var vout in transactionController.transactionModel!.vout!) {
        if (vout.value != null) {
          outputTotal += vout.value!;
        }
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            coin.setCurrencyType(coin.coin != null ? !coin.coin! : false);
          },
          child: Text(
            coin.coin ?? true
                ? '$outputTotal'
                : '${CurrencyConverter.convertCurrency(BitcoinUnits.SAT.name, outputTotal.toDouble(), currency, bitcoinPrice)} ${getCurrency(currency)}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        coin.coin ?? true
            ? Icon(AppTheme.satoshiIcon)
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildTimeDisplay() {
    final transactionModel = transactionController.transactionModel!;
    Location loc =
        Provider.of<TimezoneProvider>(context, listen: false).timeZone;

    if (transactionModel.status!.confirmed!) {
      return Container(
        child: Column(
          children: [
            Text(
              '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(transactionModel.status!.blockTime! * 1000).toUtc().add(Duration(milliseconds: loc.currentTimeZone.offset)))}'
              ' (${transactionController.formatTimeAgo(DateTime.fromMillisecondsSinceEpoch(transactionModel.status!.blockTime! * 1000).toUtc().add(Duration(milliseconds: loc.currentTimeZone.offset)))})',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    } else {
      return Obx(
        () => Text(
          transactionController.timeST.value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
  }

  Widget _buildFeeDisplay() {
    final chartLine = walletController.chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            coin.setCurrencyType(coin.coin != null ? !coin.coin! : false);
          },
          child: Text(
            coin.coin ?? true
                ? '${transactionController.transactionModel == null ? '' : transactionController.formatPrice(transactionController.transactionModel!.fee.toString())}'
                : transactionController.transactionModel == null
                    ? ''
                    : '${CurrencyConverter.convertCurrency(BitcoinUnits.SAT.name, transactionController.transactionModel!.fee?.toDouble() ?? 0, currency, bitcoinPrice)} ${getCurrency(currency)}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        coin.coin ?? true
            ? Icon(AppTheme.satoshiIcon)
            : const SizedBox.shrink(),
      ],
    );
  }

  void _showInputsBottomSheet() {
    // Implementation for showing inputs in bottom sheet
    // This would need to be migrated from the original code
  }

  void _showOutputsBottomSheet() {
    // Implementation for showing outputs in bottom sheet
    // This would need to be migrated from the original code
  }
}
