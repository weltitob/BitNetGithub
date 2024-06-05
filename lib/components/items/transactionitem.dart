import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/lightning_transaction_details.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
 import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

enum TransactionType {
  lightning,
  onChain,
}

enum TransactionStatus { failed, pending, confirmed }

enum TransactionDirection { received, sent }

class TransactionItem extends StatefulWidget {
  final TransactionItemData data;
  final BuildContext context;

  const TransactionItem({
    Key? key,
    required this.context,
    required this.data,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  String usd = '';

  dollarRate() async {
    final _dio = Dio();

    String url =
        'https://mempool.space/api/v1/historical-price?timestamp=${widget.data.timestamp}';

    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> prices = data['prices'];
      if (prices.isNotEmpty) {
        final latestPrice = prices.last;
        usd = ((double.parse(widget.data.amount) / 100000000) *
                latestPrice['USD'])
            .toStringAsFixed(3);
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      throw Exception('Failed to load historical price');
    }
  }

  @override
  void initState() {
    dollarRate(); 
    super.initState();
  }

  bool showInfo = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletsController>();
    // Use DateFormat for formatting the timestamp
    final String formattedDate = displayTimeAgoFromInt(widget.data.timestamp);
    final chartLine = controller.chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;

    final currencyEquivalent = bitcoinPrice != null
        ? (double.parse(widget.data.amount) / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";
    return Obx(() {
      Get.find<WalletsController>().chartLines.value;
      return Padding(
        padding: const EdgeInsets.only(
          left: AppTheme.cardPadding,
          right: AppTheme.cardPadding,
          bottom: AppTheme.elementSpacing,
        ),
        child: GestureDetector(
          onTap: () {
            if (widget.data.type == TransactionType.lightning) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LightningTransactionDetails(
                    data: widget.data,
                  ),
                ),
              );
            } else {
              final controllerTransaction = Get.put(
                TransactionController(
                  txID: widget.data.txHash.toString(),
                ),
              );
              controllerTransaction.txID = widget.data.txHash.toString();
              controllerTransaction.getSingleTransaction(
                  controllerTransaction.txID!,
                  );
              controllerTransaction.changeSocket();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleTransactionScreen(),
                ),
              );
            }
          },
          child: GlassContainer(
            height: AppTheme.cardPadding * 3.h,
            borderThickness: 1,
            borderRadius: AppTheme.cardRadiusBig,
            child: ClipRRect(
              borderRadius: AppTheme.cardRadiusBig,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppTheme.elementSpacing * 0.75,
                        right: AppTheme.elementSpacing * 1,
                        top: AppTheme.elementSpacing * 0.75,
                        bottom: AppTheme.elementSpacing * 0.75),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(child: Avatar()),
                          const SizedBox(width: AppTheme.elementSpacing * 0.75),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: AppTheme.cardPadding * 5,
                                    child: Text(
                                      widget.data.receiver.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(widget.context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppTheme.elementSpacing / 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formattedDate,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(widget.context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Obx(
                            () => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                controller.hideBalance.value
                                    ? Text(
                                        '*****',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    : Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              coin.setCurrencyType(
                                                  coin.coin != null
                                                      ? !coin.coin!
                                                      : false);
                                            },
                                            child: Text(
                                              coin.coin ?? true
                                                  ? widget.data.amount
                                                  : "$currencyEquivalent${getCurrency(currency!)}",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: widget.data
                                                                  .direction ==
                                                              TransactionDirection
                                                                  .received
                                                          ? AppTheme
                                                              .successColor
                                                          : AppTheme
                                                              .errorColor),
                                            ),
                                          ),
                                          coin.coin ?? true
                                              ? Icon(
                                                  AppTheme.satoshiIcon,
                                                  color: widget
                                                              .data.direction ==
                                                          TransactionDirection
                                                              .received
                                                      ? AppTheme.successColor
                                                      : AppTheme.errorColor,
                                                )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.elementSpacing / 3,
                                      vertical: AppTheme.elementSpacing / 15),
                                  child: Row(
                                    children: [
                                      //only for received transactions
                                      GestureDetector(
                                        onTap: () {
                                          ///when the lightning invoice wont get trough the payment will be canceled and the user
                                          ///will receive the funds back
                                        },
                                        child: Icon(
                                          Icons.circle,
                                          color: widget.data.status ==
                                                  TransactionStatus.confirmed
                                              ? AppTheme.successColor
                                              : widget.data.status ==
                                                      TransactionStatus.pending
                                                  ? AppTheme.colorBitcoin
                                                  : AppTheme.errorColor,
                                          size: AppTheme.cardPadding * 0.75,
                                        ),
                                      ),
                                      SizedBox(
                                        width: AppTheme.elementSpacing / 2,
                                      ),
                                      Image.asset(
                                        widget.data.type ==
                                                TransactionType.onChain
                                            ? "assets/images/bitcoin.png"
                                            : "assets/images/lightning.png",
                                        width: AppTheme.cardPadding * 0.75,
                                        height: AppTheme.cardPadding * 0.75,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
