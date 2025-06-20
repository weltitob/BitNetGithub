import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/mempool_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

/// Optimized and simplified Fear and Greed Index card
class FearAndGreedCardOptimized extends StatelessWidget {
  const FearAndGreedCardOptimized({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MempoolController());
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.gaugeHigh,
                        size: AppTheme.cardPadding * 0.75,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: AppTheme.elementSpacing),
                      Text(
                        L10n.of(context)!.fearAndGreedIndex,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Simplified content
              Obx(() {
                if (controller.fearGreedLoading.value) {
                  return _buildLoadingState();
                }
                
                final currentValue = controller.getCurrentFearGreedValue();
                return _buildIndexDisplay(context, currentValue, controller);
              }),

              SizedBox(height: 16),

              // Index explanation
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusSmall,
                  color: controller.fearGreedLoading.value 
                      ? Colors.grey.withOpacity(0.1)
                      : controller.getFearGreedColor(controller.getCurrentFearGreedValue()).withOpacity(0.1),
                ),
                child: Text(
                  "Market sentiment indicator (0-100)",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: controller.fearGreedLoading.value 
                        ? Colors.grey
                        : controller.getFearGreedColor(controller.getCurrentFearGreedValue()),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        // Placeholder for value
        Container(
          height: 80,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(height: 12),
        // Placeholder for sentiment
        Container(
          height: 24,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildIndexDisplay(BuildContext context, int currentValue, MempoolController controller) {
    return Column(
      children: [
        // Large circular indicator with just the number
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controller.getFearGreedColor(currentValue).withOpacity(0.1),
            border: Border.all(
              color: controller.getFearGreedColor(currentValue),
              width: 4,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentValue.toString(),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: controller.getFearGreedColor(currentValue),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'INDEX',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: controller.getFearGreedColor(currentValue),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        SizedBox(height: 16),
        
        // Sentiment text
        Text(
          controller.fearGreedData.value.fgi?.now?.valueText ?? "Neutral",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: controller.getFearGreedColor(currentValue),
          ),
        ),
        
        // Last updated
        if (controller.formattedFearGreedDate.value.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Updated ${controller.formattedFearGreedDate.value}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.white60
                    : AppTheme.black60,
              ),
            ),
          ),
        
        // Simplified historical comparison
        if (controller.fearGreedData.value.fgi?.previousClose != null)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _buildSimpleComparison(context, controller, currentValue),
          ),
      ],
    );
  }
  
  Widget _buildSimpleComparison(BuildContext context, MempoolController controller, int currentValue) {
    final previousValue = controller.fearGreedData.value.fgi?.previousClose?.value ?? currentValue;
    final change = currentValue - previousValue;
    final isPositive = change > 0;
    
    if (change == 0) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (isPositive ? AppTheme.successColor : AppTheme.errorColor).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
            size: 16,
          ),
          SizedBox(width: 6),
          Text(
            '${change.abs()} since yesterday',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}