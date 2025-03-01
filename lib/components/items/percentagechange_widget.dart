import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PercentageChangeWidget extends StatelessWidget {
  final String percentage;
  final bool isPositive;
  final bool showIcon;
  final double fontSize;

  const PercentageChangeWidget({
    Key? key,
    required this.percentage,
    required this.isPositive,
    this.showIcon = false,
    this.fontSize = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? AppTheme.successColor : AppTheme.errorColor;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.elementSpacing / 2,
        vertical: AppTheme.elementSpacing / 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: color,
              size: fontSize * 1.1,
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            percentage,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: fontSize.sp,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}