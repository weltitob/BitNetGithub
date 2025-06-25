import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/mempool_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:get/get.dart';

/// Card displaying the Bitcoin Fear and Greed Index
class FearAndGreedCard extends StatelessWidget {
  const FearAndGreedCard({Key? key}) : super(key: key);

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

              SizedBox(height: 20),

              // Gauge visualization
              Obx(() {
                if (controller.fearGreedLoading.value) {
                  return Center(
                    child: SizedBox(
                      height: 100,
                      child: dotProgress(context),
                    ),
                  );
                }

                // Get current value
                final currentValue = controller.getCurrentFearGreedValue();

                return Center(
                  child: Column(
                    children: [
                      _buildRadialGauge(context, currentValue, controller),
                      // Value and sentiment text
                      Text(
                        controller.fearGreedData.value.fgi?.now?.valueText ??
                            "Neutral",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: controller.getFearGreedColor(currentValue),
                            ),
                      ),

                      // Date of reading
                      if (controller.formattedFearGreedDate.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Updated on ${controller.formattedFearGreedDate.value}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppTheme.white60
                                          : AppTheme.black60,
                                    ),
                          ),
                        ),

                      // Add historical comparison
                      if (controller.fearGreedData.value.fgi?.previousClose !=
                          null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child:
                              _buildHistoricalComparison(context, controller),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Build a custom radial gauge for fear & greed
  Widget _buildRadialGauge(
      BuildContext context, int value, MempoolController controller) {
    return SizedBox(
      height: 160,
      width: 160,
      child: AnimatedRadialGauge(
        duration: const Duration(seconds: 1),
        curve: Curves.elasticOut,
        radius: 80,
        value: value.toDouble(),
        axis: GaugeAxis(
          min: 0,
          max: 100,
          degrees: 180,
          style: GaugeAxisStyle(
            thickness: 20,
            background: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.white70
                : AppTheme.black70,
            segmentSpacing: 4,
          ),
          progressBar: GaugeProgressBar.rounded(
            color: controller.getFearGreedColor(value),
          ),
          // Add segments to visualize the different value ranges
          segments: [
            GaugeSegment(
              from: 0,
              to: 25,
              color: AppTheme.errorColor,
              cornerRadius: const Radius.circular(4),
            ),
            GaugeSegment(
              from: 25,
              to: 50,
              color: Colors.orange,
              cornerRadius: const Radius.circular(4),
            ),
            GaugeSegment(
              from: 50,
              to: 75,
              color: Colors.yellow,
              cornerRadius: const Radius.circular(4),
            ),
            GaugeSegment(
              from: 75,
              to: 100,
              color: AppTheme.successColor,
              cornerRadius: const Radius.circular(4),
            ),
          ],
        ),
        builder: (context, child, value) => RadialGaugeLabel(
          value: value,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  // Build a widget showing historical comparison
  Widget _buildHistoricalComparison(
      BuildContext context, MempoolController controller) {
    final data = controller.fearGreedData.value;

    // Get current value and historical values
    final currentValue = data.fgi?.now?.value ?? 50;
    final yesterday = data.fgi?.previousClose?.value;
    final lastWeek = data.fgi?.oneWeekAgo?.value;
    final lastMonth = data.fgi?.oneMonthAgo?.value;

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        // Header row
        TableRow(
          children: [
            Text(
              'Period',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Value',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Change',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),

        // Yesterday row
        if (yesterday != null)
          _buildComparisonRow(
              context, 'Yesterday', yesterday, currentValue, controller),

        // Last week row
        if (lastWeek != null)
          _buildComparisonRow(
              context, 'Last Week', lastWeek, currentValue, controller),

        // Last month row
        if (lastMonth != null)
          _buildComparisonRow(
              context, 'Last Month', lastMonth, currentValue, controller),
      ],
    );
  }

  // Build a row for the comparison table
  TableRow _buildComparisonRow(BuildContext context, String label, int value,
      int currentValue, MempoolController controller) {
    final change = currentValue - value;
    final isPositive = change > 0;

    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            value.toString(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: controller.getFearGreedColor(value),
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                size: 12,
              ),
              SizedBox(width: 2),
              Text(
                '${change.abs()}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: isPositive
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
