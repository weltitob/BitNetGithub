import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/mempool_controller.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Card displaying Bitcoin network hashrate information
class HashrateCard extends StatelessWidget {
  const HashrateCard({Key? key}) : super(key: key);

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

              // Current hashrate display
              Obx(() {
                final hashrateInfo = controller.getCurrentHashrateInfo();
                return Center(
                  child: Column(
                    children: [
                      Text(
                        hashrateInfo['currentHashrate'],
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      if (controller.hashrateChartData.isNotEmpty &&
                          hashrateInfo['changePercentage'].isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                hashrateInfo['isPositive']
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
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
                  ),
                );
              }),

              SizedBox(height: 16),

              // Time period selection
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTimeButton(context, '1D', controller),
                      SizedBox(width: 4),
                      _buildTimeButton(context, '1W', controller),
                      SizedBox(width: 4),
                      _buildTimeButton(context, '1M', controller),
                      SizedBox(width: 4),
                      _buildTimeButton(context, '1Y', controller),
                      SizedBox(width: 4),
                      _buildTimeButton(context, 'MAX', controller),
                    ],
                  )),

              SizedBox(height: 16),

              // Hashrate chart
              Obx(() {
                if (controller.hashrateLoading.value) {
                  return Center(
                    child: SizedBox(
                      height: 180,
                      child: dotProgress(context),
                    ),
                  );
                } else if (controller.hashrateChartData.isEmpty) {
                  return Center(
                    child: Text(
                      "Failed to load hashrate data",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                } else {
                  return Container(
                    height: 180,
                    padding: EdgeInsets.only(top: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: AppTheme.cardRadiusSmall,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.black70
                          : AppTheme.white70,
                    ),
                    child: _buildHashrateChart(context, controller),
                  );
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

  // Helper method to build time period buttons
  Widget _buildTimeButton(
      BuildContext context, String period, MempoolController controller) {
    // Use the tracked time period
    final isActive = period == controller.selectedTimePeriod.value;
    return InkWell(
      onTap: controller.hashrateLoading.value
          ? null
          : () {
              controller.updateHashrateTimePeriod(period);
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.colorBitcoin.withOpacity(0.2)
              : Colors.transparent,
          border: Border.all(
            color: isActive ? AppTheme.colorBitcoin : AppTheme.white60,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          period,
          style: TextStyle(
            color: isActive ? AppTheme.colorBitcoin : null,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Helper method to build the hashrate chart
  Widget _buildHashrateChart(
      BuildContext context, MempoolController controller) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: EdgeInsets.only(left: 8, bottom: 8),
      enableAxisAnimation: true,
      trackballBehavior: TrackballBehavior(
        lineColor: Colors.grey[400],
        enable: true,
        activationMode: ActivationMode.singleTap,
        lineWidth: 2,
        lineType: TrackballLineType.vertical,
        tooltipSettings: const InteractiveTooltip(enable: false),
        markerSettings: const TrackballMarkerSettings(
            color: Colors.white,
            borderColor: Colors.white,
            markerVisibility: TrackballVisibilityMode.visible),
      ),
      primaryXAxis: DateTimeAxis(
        intervalType: DateTimeIntervalType.days,
        edgeLabelPlacement: EdgeLabelPlacement.none,
        majorGridLines: MajorGridLines(
          width: 0.5,
          color: AppTheme.white70,
          dashArray: [5, 5],
        ),
        axisLine: const AxisLine(width: 0),
        labelStyle: TextStyle(color: AppTheme.white70, fontSize: 10),
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        plotOffset: 0,
        edgeLabelPlacement: EdgeLabelPlacement.none,
        majorGridLines: MajorGridLines(
          width: 0.5,
          color: AppTheme.white70,
          dashArray: [5, 5],
        ),
        majorTickLines: const MajorTickLines(width: 0),
        numberFormat: NumberFormat.compact(),
        labelStyle: TextStyle(color: AppTheme.white60, fontSize: 10),
      ),
      series: <CartesianSeries>[
        // Hashrate line
        SplineSeries<ChartLine, DateTime>(
          name: L10n.of(context)!.hashrate,
          enableTooltip: true,
          dataSource: controller.hashrateChartData,
          splineType: SplineType.cardinal,
          cardinalSplineTension: 0.7,
          animationDuration: 1000,
          width: 2,
          color: AppTheme.colorBitcoin,
          xValueMapper: (ChartLine sales, _) =>
              DateTime.fromMillisecondsSinceEpoch(sales.time.toInt() * 1000,
                  isUtc: true),
          yValueMapper: (ChartLine sales, _) => double.parse(sales.price
              .toString()
              .substring(
                  0,
                  sales.price.toString().length > 3
                      ? 3
                      : sales.price.toString().length)),
        ),
        // Add difficulty markers as scatter series
        if (controller.hashrateChartDifficulty.isNotEmpty)
          ScatterSeries<Difficulty, DateTime>(
            name: L10n.of(context)!.difficulty,
            enableTooltip: true,
            dataSource: controller.hashrateChartDifficulty,
            color: Colors.white,
            markerSettings: MarkerSettings(
              height: 6,
              width: 6,
              shape: DataMarkerType.circle,
              borderColor: AppTheme.colorBitcoin,
              borderWidth: 1,
            ),
            xValueMapper: (Difficulty diff, _) =>
                DateTime.fromMillisecondsSinceEpoch(diff.time!.toInt() * 1000,
                    isUtc: true),
            yValueMapper: (Difficulty diff, _) => double.parse(
                (diff.difficulty! / 100000000000).toStringAsFixed(2)),
          ),
      ],
    );
  }
}
