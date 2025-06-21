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
    // Debug: Add print for troubleshooting
    if (percentage.contains("-")) {
      print("DEBUG: percentage='$percentage', isPositive=$isPositive");
    }
    
    // Fixed logic: Only treat zero percentages as positive, not all positive values
    final isReallyPositive = isPositive && !percentage.trim().startsWith('-');
    final color = isReallyPositive ? AppTheme.successColor : AppTheme.errorColor;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.elementSpacing * 0.5,
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
              isReallyPositive ? Icons.arrow_upward : Icons.arrow_downward,
              color: color,
              size: fontSize * 1.1,
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            // Fix -0% display: always show 0% as positive
            percentage.trim() == "-0%" ? "0%" : 
            percentage.trim() == "0%" ? "0%" : 
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