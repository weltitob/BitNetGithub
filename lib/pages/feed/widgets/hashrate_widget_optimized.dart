import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/mempool_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

/// Optimized Hashrate Widget for feed screen with minimal performance impact
class HashrateWidgetOptimized extends StatelessWidget {
  const HashrateWidgetOptimized({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MempoolController());
    
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding,
        vertical: AppTheme.elementSpacing,
      ),
      height: 200, // Reduced height for better performance
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.cardPadding),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppTheme.elementSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    L10n.of(context)!.hashrate,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/wallet/bitcoinscreen/hashrate');
                    },
                    child: Text(
                      "View more",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Obx(() {
                if (controller.hashrateLoading.value) {
                  return Center(child: dotProgress(context));
                }
                
                if (controller.hashrateChartData.isEmpty) {
                  return Center(
                    child: Text(
                      "No data available",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                
                return Column(
                  children: [
                    // Current value display
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                      child: _buildHashrateInfo(context, controller),
                    ),
                    
                    // Simplified chart
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: AppTheme.elementSpacing,
                          right: AppTheme.elementSpacing,
                          bottom: AppTheme.elementSpacing,
                        ),
                        child: _buildSimplifiedChart(controller),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHashrateInfo(BuildContext context, MempoolController controller) {
    final hashrateInfo = controller.getCurrentHashrateInfo();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              hashrateInfo['currentHashrate'],
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (hashrateInfo['changePercentage'].isNotEmpty)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    hashrateInfo['isPositive']
                        ? Icons.trending_up
                        : Icons.trending_down,
                    color: hashrateInfo['isPositive']
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    hashrateInfo['changePercentage'],
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: hashrateInfo['isPositive']
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
        
        // Time period selector - simplified
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.colorBitcoin.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            controller.selectedTimePeriod.value,
            style: TextStyle(
              color: AppTheme.colorBitcoin,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimplifiedChart(MempoolController controller) {
    // Sample data for performance
    final chartData = controller.hashrateChartData;
    final sampledData = _sampleData(chartData, maxPoints: 30);
    
    return SfSparkLineChart(
      data: sampledData.map((e) => e.price).toList(),
      color: AppTheme.colorBitcoin,
      axisLineWidth: 0,
      trackball: SparkChartTrackball(
        activationMode: SparkChartActivationMode.none,
      ),
      marker: SparkChartMarker(
        displayMode: SparkChartMarkerDisplayMode.none,
      ),
    );
  }

  List<ChartLine> _sampleData(List<ChartLine> data, {int maxPoints = 30}) {
    if (data.length <= maxPoints) return data;
    
    final List<ChartLine> sampled = [];
    final step = data.length ~/ maxPoints;
    
    for (int i = 0; i < data.length; i += step) {
      sampled.add(data[i]);
    }
    
    if (sampled.last != data.last) {
      sampled.add(data.last);
    }
    
    return sampled;
  }
}