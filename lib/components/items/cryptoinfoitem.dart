import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class CryptoInfoItem extends StatefulWidget {
  final Currency currency;
  final BuildContext context;
  final VoidCallback onTap;
  final String balance;
  final BitcoinUnits defaultUnit;

  const CryptoInfoItem({
    Key? key,
    required this.currency,
    required this.context,
    required this.onTap,
    required this.balance,
    required this.defaultUnit,
  }) : super(key: key);

  @override
  State<CryptoInfoItem> createState() => _CryptoInfoItemState();
}

class _CryptoInfoItemState extends State<CryptoInfoItem> {
  @override
  Widget build(BuildContext context) {
    // Use the same providers as in TransactionItem
    final currencyProvider = Provider.of<CurrencyChangeProvider>(context);
    final currencyTypeProvider =
    Provider.of<CurrencyTypeProvider>(context, listen: true);
    String selectedCurrency = currencyProvider.selectedCurrency ?? "USD";

    // Get current bitcoin price from your WalletsController
    final chartLine = Get.find<WalletsController>().chartLines.value;
    final bitcoinPrice = chartLine?.price;

    // Parse the balance and calculate the fiat equivalent.
    // (Assuming balance is in satoshis)
    final double balanceValue = double.tryParse(widget.balance) ?? 0.0;
    final currencyEquivalent = bitcoinPrice != null
        ? (balanceValue / 100000000 * bitcoinPrice).toStringAsFixed(2)
        : "0.00";

    return GlassContainer(
      borderThickness: 1,
      height: AppTheme.cardPadding * 2.75,
      borderRadius: BorderRadius.circular(AppTheme.cardPadding * 2.75 / 3),
      child: Stack(
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon and Currency Name
                Row(
                  children: [
                    Container(
                      height: AppTheme.cardPadding * 1.75,
                      width: AppTheme.cardPadding * 1.75,
                      child: ClipOval(child: widget.currency.icon),
                    ),
                    SizedBox(width: AppTheme.elementSpacing.w / 1.5),
                    Text(
                      widget.currency.name,
                      style: Theme.of(widget.context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.white90
                            : AppTheme.black90,
                      ),
                    ),
                  ],
                ),
                // Main Balance – apply the currency switch logic with conditional icon
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Obx(() => Get.find<WalletsController>().hideBalance.value
                          ? Text(
                              "******",
                              style: Theme.of(widget.context).textTheme.titleMedium,
                            )
                          : Text(
                              currencyTypeProvider.coin ?? true
                                  ? widget.balance
                                  : "$currencyEquivalent${getCurrency(selectedCurrency)}",
                              style: Theme.of(widget.context).textTheme.titleMedium,
                            )
                        ),
                        (currencyTypeProvider.coin ?? true)
                            ? Icon(
                          AppTheme.satoshiIcon,
                          // Optionally add color logic if needed
                        )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tap Interaction
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
            ),
          ),
        ],
      ),
    );
  }
}