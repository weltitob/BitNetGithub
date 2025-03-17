import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
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
    
    return Row(
      children: [
        Icon(
          isPositive ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
          color: color,
          size: AppTheme.iconSize * iconSize,
        ),
        Obx(() => controller.hideBalance.value && shouldHideAmount 
          ? Text(
              "******",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: color,
              ),
            )
          : Text(
              "$price$currencySymbol",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: color,
              ),
            ),
        ),
      ],
    );
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
    WalletsController controller = Get.find<WalletsController>();
    
    return Container(
      margin: const EdgeInsets.only(
        top: AppTheme.elementSpacing,
        bottom: AppTheme.elementSpacing,
      ),
      child: Obx(() => controller.hideBalance.value && shouldHideAmount
        ? Text(
            "******",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
            ),
          )
        : PercentageChangeWidget(
            percentage: priceChange,
            isPositive: isPositive,
            fontSize: 14,
          ),
      ),
    );
  }
}