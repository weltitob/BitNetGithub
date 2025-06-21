import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/secondpages/mempool/colorhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Card displaying current Bitcoin transaction fees 
class TransactionFeeCard extends StatelessWidget {
  final dynamic fees;
  final String highPriority;
  final num currentUSD;
  final bool isLoading;
  
  const TransactionFeeCard({
    Key? key,
    required this.fees,
    required this.highPriority,
    required this.currentUSD,
    required this.isLoading,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppTheme.colorBitcoin,
        ),
      );
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding
      ),
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.coins,
                    size: AppTheme.cardPadding * 0.75,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(width: AppTheme.elementSpacing),
                  Text(
                    "Current Network Fees",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: AppTheme.cardPadding),
              
              // Fee amounts
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFeeColumn(
                    context: context,
                    title: L10n.of(context)!.low,
                    feeAmount: fees == null
                        ? ''
                        : '\$ ${_dollarConversion(fees.hourFee!).toStringAsFixed(2)}',
                    feeColor: lighten(
                        getGradientColors(
                            (fees.hourFee!).toDouble(), false)
                            .first,
                        25),
                    icon: Icons.speed,
                    iconColor: AppTheme.errorColor.withOpacity(0.7),
                  ),
                  _buildFeeColumn(
                    context: context,
                    title: L10n.of(context)!.medium,
                    feeAmount: fees == null
                        ? ''
                        : '\$ ${_dollarConversion(fees.halfHourFee!).toStringAsFixed(2)}',
                    feeColor: lighten(
                        getGradientColors(
                            (fees.halfHourFee!).toDouble(), false)
                            .first,
                        25),
                    icon: Icons.speed,
                    iconColor: AppTheme.colorBitcoin.withOpacity(0.8),
                  ),
                  _buildFeeColumn(
                    context: context,
                    title: L10n.of(context)!.high,
                    feeAmount:
                        '\$ ${_dollarConversion(num.parse(highPriority)).toStringAsFixed(2)}',
                    feeColor: lighten(
                        getGradientColors(
                            double.tryParse(highPriority)!, false)
                            .first,
                        25),
                    icon: Icons.speed,
                    iconColor: AppTheme.successColor,
                  ),
                ],
              ),
              
              SizedBox(height: AppTheme.elementSpacing),
              SizedBox(height: AppTheme.elementSpacing),
              
              // Confirmation time
              Text(
                "Estimated confirmation time",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.white60
                      : AppTheme.black60,
                ),
              ),
              SizedBox(height: AppTheme.elementSpacing),
              
              // Time estimates
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTimeEstimate(
                    context, 
                    "~60 min",
                    AppTheme.errorColor.withOpacity(0.7)
                  ),
                  _buildTimeEstimate(
                    context, 
                    "~30 min",
                    AppTheme.colorBitcoin.withOpacity(0.8)
                  ),
                  _buildTimeEstimate(
                    context, 
                    "Next block",
                    AppTheme.successColor
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to convert fee to dollar amount
  double _dollarConversion(num fee) {
    return currentUSD * ((fee * (560 / 4) / 100000000));
  }
  
  // Widget to display fee column with icon, title, and amount
  Widget _buildFeeColumn({
    required BuildContext context,
    required String title,
    required String feeAmount,
    required Color feeColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconColor.withOpacity(0.15),
          ),
          child: Center(
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
        ),
        SizedBox(height: AppTheme.elementSpacing),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: AppTheme.elementSpacing / 2),
        Text(
          feeAmount,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: feeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  // Widget to display time estimate pill
  Widget _buildTimeEstimate(BuildContext context, String time, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.elementSpacing,
        vertical: AppTheme.elementSpacing / 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: AppTheme.cardRadiusSmall,
      ),
      child: Text(
        time,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Helper function to lighten a color
// Originally from colorhelper.dart
Color lighten(Color color, [int amount = 10]) {
  assert(amount >= 0 && amount <= 100);
  
  final hsl = HSLColor.fromColor(color);
  final lightness = (hsl.lightness + (amount / 100)).clamp(0.0, 1.0);
  
  return hsl.withLightness(lightness).toColor();
}