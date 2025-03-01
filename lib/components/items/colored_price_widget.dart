import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColoredPriceWidget extends StatelessWidget {
  final String price;
  final bool isPositive;
  final String currencySymbol;
  final double iconSize;

  const ColoredPriceWidget({
    Key? key,
    required this.price,
    required this.isPositive,
    this.currencySymbol = '\$',
    this.iconSize = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? AppTheme.successColor : AppTheme.errorColor;
    
    return Row(
      children: [
        Icon(
          isPositive ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
          color: color,
          size: AppTheme.iconSize * iconSize,
        ),
        Text(
          "$price $currencySymbol",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}