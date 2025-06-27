import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketCapWidget extends StatelessWidget {
  final String marketCap;
  final String changePercentage;
  final bool isPositive;
  final String tradingVolume;
  final String btcDominance;
  final List<ChartLine>? chartData;

  const MarketCapWidget({
    Key? key,
    required this.marketCap,
    required this.changePercentage,
    this.isPositive = true,
    required this.tradingVolume,
    required this.btcDominance,
    this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Default chart data if none provided
    final List<ChartLine> dataPoints = chartData ??
        [
          ChartLine(time: 0, price: 2200000000000),
          ChartLine(time: 1, price: 2250000000000),
          ChartLine(time: 2, price: 2300000000000),
          ChartLine(time: 3, price: 2280000000000),
          ChartLine(time: 4, price: 2320000000000),
          ChartLine(time: 5, price: 2350000000000),
          ChartLine(time: 6, price: 2400000000000),
          ChartLine(time: 7, price: 2420000000000),
        ];

    return GlassContainer(
      boxShadow: isDarkMode ? [] : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with value and percentage
          Padding(
            padding: EdgeInsets.only(
              left: AppTheme.cardPadding * 0.75,
              right: AppTheme.cardPadding * 0.75,
              top: AppTheme.cardPadding * 0.75,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Market cap value
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        marketCap,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 26.sp,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Global crypto market cap',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: isDarkMode
                                  ? AppTheme.white60
                                  : AppTheme.black60,
                            ),
                      ),
                    ],
                  ),
                ),

                // Percentage change badge using reusable component
                PercentageChangeWidget(
                  percentage: changePercentage,
                  isPositive: isPositive,
                  showIcon: true,
                  fontSize: 14,
                ),
              ],
            ),
          ),

          // Chart area
          SizedBox(
            height: 120.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                margin: EdgeInsets.zero,
                primaryXAxis: CategoryAxis(
                  isVisible: false,
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  isVisible: false,
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(width: 0),
                ),
                series: <ChartSeries>[
                  // Area series with gradient
                  AreaSeries<ChartLine, double>(
                    dataSource: dataPoints,
                    animationDuration: 0, // Disable animation for consistent UX
                    xValueMapper: (ChartLine data, _) => data.time,
                    yValueMapper: (ChartLine data, _) => data.price,
                    color: (isPositive
                            ? AppTheme.successColor
                            : AppTheme.errorColor)
                        .withOpacity(0.3),
                    borderWidth: 2.5,
                    borderColor: isPositive
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        (isPositive
                                ? AppTheme.successColor
                                : AppTheme.errorColor)
                            .withOpacity(0.3),
                        (isPositive
                                ? AppTheme.successColor
                                : AppTheme.errorColor)
                            .withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // Stats row
          Padding(
            padding: EdgeInsets.all(AppTheme.cardPadding * 0.75),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '24h Trading Volume',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: isDarkMode
                                  ? AppTheme.white60
                                  : AppTheme.black60,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        tradingVolume,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BTC Dominance',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: isDarkMode
                                  ? AppTheme.white60
                                  : AppTheme.black60,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        btcDominance,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
