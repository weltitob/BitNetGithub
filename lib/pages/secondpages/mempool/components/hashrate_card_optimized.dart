import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/mempool_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

/// Optimized Hashrate Card with better performance
class HashrateCardOptimized extends StatelessWidget {
  const HashrateCardOptimized({Key? key}) : super(key: key);

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
                        FontAwesomeIcons.server,
                        size: AppTheme.cardPadding * 0.75,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: AppTheme.elementSpacing),
                      Text(
                        L10n.of(context)!.hashrate,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Optimized hashrate display
              Obx(() {
                if (controller.hashrateLoading.value) {
                  return _buildLoadingState();
                }
                
                final hashrateInfo = controller.getCurrentHashrateInfo();
                return _buildHashrateDisplay(context, hashrateInfo);
              }),

              SizedBox(height: 16),

              // Simplified chart display
              Obx(() {
                if (controller.hashrateLoading.value) {
                  return SizedBox(height: 80);
                } else if (controller.hashrateChartData.isEmpty) {
                  return _buildErrorState(context);
                } else {
                  return _buildSimplifiedChart(context, controller);
                }
              }),

              SizedBox(height: 16),

              // Hashrate explanation
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusSmall,
                  color: AppTheme.colorBitcoin.withOpacity(0.1),
                ),
                child: Text(
                  "Higher hashrate = stronger network security",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppTheme.colorBitcoin,
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
        // Placeholder for hashrate value
        Container(
          height: 32,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 8),
        // Placeholder for percentage
        Container(
          height: 20,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildHashrateDisplay(BuildContext context, Map<String, dynamic> hashrateInfo) {
    return Column(
      children: [
        Text(
          hashrateInfo['currentHashrate'],
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (hashrateInfo['changePercentage'].isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  hashrateInfo['isPositive']
                      ? Icons.trending_up
                      : Icons.trending_down,
                  color: hashrateInfo['isPositive']
                      ? AppTheme.successColor
                      : AppTheme.errorColor,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  hashrateInfo['changePercentage'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                        color: hashrateInfo['isPositive']
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Container(
      height: 80,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.grey,
              size: 24,
            ),
            SizedBox(height: 8),
            Text(
              "No data available",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimplifiedChart(BuildContext context, MempoolController controller) {
    // Use a lightweight sparkline chart instead of full chart
    final chartData = controller.hashrateChartData;
    
    // Sample data to reduce points for better performance
    final sampledData = _sampleData(chartData, maxPoints: 50);
    
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SfSparkLineChart(
        data: sampledData.map((e) => e.price).toList(),
        color: AppTheme.colorBitcoin,
        trackball: SparkChartTrackball(
          activationMode: SparkChartActivationMode.tap,
          color: Colors.transparent,
          borderColor: AppTheme.colorBitcoin,
          borderWidth: 1,
        ),
        marker: SparkChartMarker(
          displayMode: SparkChartMarkerDisplayMode.none,
        ),
        labelDisplayMode: SparkChartLabelDisplayMode.none,
        axisLineWidth: 0,
      ),
    );
  }

  // Helper method to sample data for better performance
  List<ChartLine> _sampleData(List<ChartLine> data, {int maxPoints = 50}) {
    if (data.length <= maxPoints) return data;
    
    final List<ChartLine> sampled = [];
    final step = data.length ~/ maxPoints;
    
    for (int i = 0; i < data.length; i += step) {
      sampled.add(data[i]);
    }
    
    // Always include the last point
    if (sampled.last != data.last) {
      sampled.add(data.last);
    }
    
    return sampled;
  }
}