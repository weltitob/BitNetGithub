import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TransactionAmountWidget extends StatelessWidget {
  final TransactionItemData data;
  final bool useAmountColor;

  const TransactionAmountWidget({
    required this.data,
    this.useAmountColor = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletsController>();
    final chartLine = controller.chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? (double.parse(data.amount) / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppTheme.cardPadding * 0.75),
      child: Obx(() => controller.hideBalance.value
          ? Text(
              '*****',
              style: Theme.of(context).textTheme.displayMedium,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    coin.setCurrencyType(
                        coin.coin != null ? !coin.coin! : false);
                  },
                  child: Row(
                    children: [
                      Text(
                        coin.coin ?? true
                            ? data.amount
                            : "${currencyEquivalent}",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: useAmountColor
                                    ? (double.parse(data.amount) > 0
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor)
                                    : null),
                      ),
                      if (!(coin.coin ?? true)) ...[
                        Text(
                          ' ${getCurrency(currency!)}',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: useAmountColor
                                      ? (double.parse(data.amount) > 0
                                          ? AppTheme.successColor
                                          : AppTheme.errorColor)
                                      : null),
                        )
                      ]
                    ],
                  ),
                ),
                if (coin.coin ?? true)
                  Icon(
                    AppTheme.satoshiIcon,
                    size: AppTheme.cardPadding * 2,
                    color: useAmountColor
                        ? (double.parse(data.amount) > 0
                            ? AppTheme.successColor
                            : AppTheme.errorColor)
                        : null,
                  ),
              ],
            )),
    );
  }
}
