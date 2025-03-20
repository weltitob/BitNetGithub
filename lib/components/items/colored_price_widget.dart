import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ColoredPriceWidget extends StatelessWidget {
  final String price;
  final bool isPositive;
  final String currencySymbol;
  final double iconSize;
  final bool shouldHideAmount;

  const ColoredPriceWidget({
    Key? key,
    required this.price,
    required this.isPositive,
    this.currencySymbol = '\$',
    this.iconSize = 1.0,
    this.shouldHideAmount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? AppTheme.successColor : AppTheme.errorColor;
    WalletsController controller = Get.find<WalletsController>();
    
    return Obx(() {
      // Calculate satoshi equivalent of the price
      double priceValue = 0;
      try {
        // Strip currency symbol and handle K notation if present
        String cleanPrice = price.replaceAll(RegExp(r'[^\d.-K]'), '');
        if (cleanPrice.contains('K')) {
          cleanPrice = cleanPrice.replaceAll('K', '');
          priceValue = double.parse(cleanPrice) * 1000;
        } else {
          priceValue = double.parse(cleanPrice);
        }
      } catch (e) {
        priceValue = 0;
      }
      
      // Get Bitcoin price from controller
      final chartLine = controller.chartLines.value;
      final bitcoinPrice = chartLine?.price ?? 0;
      
      // Calculate satoshi value (if price is in fiat)
      int satoshiValue = 0;
      if (bitcoinPrice > 0 && currencySymbol != 'sat') {
        // Convert fiat amount to BTC then to satoshis
        double btcAmount = priceValue / bitcoinPrice;
        satoshiValue = (btcAmount * 100000000).round();
      } else if (currencySymbol == '\$' || currencySymbol == '€' || currencySymbol == '£') {
        // If it's a fiat currency but we don't have a bitcoin price
        satoshiValue = 0;
      } else {
        // If it's already in sats
        satoshiValue = priceValue.round();
      }
      
      String satoshiText = satoshiValue.toString();
      
      return Row(
        children: [
          Icon(
            isPositive ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
            color: color,
            size: AppTheme.iconSize * iconSize,
          ),
          controller.hideBalance.value && shouldHideAmount 
            ? Text(
                "******",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: color,
                ),
              )
            : controller.coin.value
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      satoshiText,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: color,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      AppTheme.satoshiIcon,
                      size: 16,
                      color: color,
                    ),
                  ],
                )
              : Text(
                  "$price$currencySymbol",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: color,
                  ),
                ),
        ],
      );
    });
  }
}

class BitNetPercentWidget extends StatelessWidget {
  final String priceChange;
  final bool shouldHideAmount;

  const BitNetPercentWidget({
    Key? key,
    required this.priceChange,
    this.shouldHideAmount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPositive = !priceChange.contains('-');
    
    return Container(
      margin: const EdgeInsets.only(
        top: AppTheme.elementSpacing,
        bottom: AppTheme.elementSpacing,
      ),
      child: PercentageChangeWidget(
        percentage: priceChange,
        isPositive: isPositive,
        fontSize: 14,
      ),
    );
  }
}