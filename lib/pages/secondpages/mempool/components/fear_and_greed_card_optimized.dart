import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/mempool_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
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

  Widget _buildIndexDisplay(
      BuildContext context, int currentValue, MempoolController controller) {
    return Column(
      children: [
        // Horizontal slider/gauge representation
        Container(
          height: 60,
          child: Column(
            children: [
              // Value display above the slider
              Text(
                currentValue.toString(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: controller.getFearGreedColor(currentValue),
                    ),
              ),

              SizedBox(height: 8),

              // Horizontal gradient slider
              Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.errorColor, // Red for Extreme Fear
                      AppTheme.errorColor.withOpacity(0.7), // Lighter red
                      Colors.orange, // Orange for neutral
                      AppTheme.successColor.withOpacity(0.7), // Lighter green
                      AppTheme.successColor, // Green for Extreme Greed
                    ],
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    // Position indicator
                    Positioned(
                      left: (currentValue / 100) *
                              (MediaQuery.of(context).size.width -
                                  2 * AppTheme.cardPadding -
                                  2 * AppTheme.cardPadding) -
                          6,
                      top: -2,
                      child: Container(
                        width: 12,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.3),
                              width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        // Sentiment text and change indicator in one row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sentiment text
            Text(
              controller.fearGreedData.value.fgi?.now?.valueText ?? "Neutral",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: controller.getFearGreedColor(currentValue),
                  ),
            ),

            // Change indicator
            if (controller.fearGreedData.value.fgi?.previousClose != null)
              _buildSimpleComparison(context, controller, currentValue),
          ],
        ),
      ],
    );
  }

  Widget _buildSimpleComparison(
      BuildContext context, MempoolController controller, int currentValue) {
    final previousValue =
        controller.fearGreedData.value.fgi?.previousClose?.value ??
            currentValue;
    final change = currentValue - previousValue;
    final isPositive = change > 0;

    if (change == 0) return SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPositive ? Icons.trending_up : Icons.trending_down,
          color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
          size: 14,
        ),
        SizedBox(width: 4),
        Text(
          '${isPositive ? '+' : ''}${change}',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
