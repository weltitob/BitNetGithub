import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceSalesTabView extends StatefulWidget {
  const PriceSalesTabView({Key? key}) : super(key: key);

  @override
  State<PriceSalesTabView> createState() => _PriceSalesTabViewState();
}

class _PriceSalesTabViewState extends State<PriceSalesTabView> {
  String searchQuery = '';
  late List<ChartLine> chartData;
  String selectedTimespan = "1W";

  @override
  void initState() {
    super.initState();
    // Generate mock chart data
    chartData = generateMockChartData();
    // Set initial timespan
    selectedTimespan = "1W";
  }

  List<ChartLine> generateMockChartData() {
    final List<ChartLine> data = [];
    final now = DateTime.now();

    // Define floor price trends for different timeframes (straight lines with slight variations)
    switch (selectedTimespan) {
      case "1D":
        // 24 hours - very stable floor price
        const floorPrice = 0.0325;
        for (int i = 24; i >= 0; i--) {
          final time = now
              .subtract(Duration(hours: i))
              .millisecondsSinceEpoch
              .toDouble();
          // Very minimal variation (±0.5%)
          final variation = (i % 3 - 1) * 0.005 * floorPrice;
          data.add(ChartLine(time: time, price: floorPrice + variation));
        }
        break;

      case "1W":
        // 7 days - steady upward trend
        const startPrice = 0.031;
        const endPrice = 0.0335;
        for (int i = 7; i >= 0; i--) {
          final time =
              now.subtract(Duration(days: i)).millisecondsSinceEpoch.toDouble();
          final progress = (7 - i) / 7;
          final price = startPrice + (endPrice - startPrice) * progress;
          // Small random variation (±1%)
          final variation = ((i % 5) - 2) * 0.01 * price / 4;
          data.add(ChartLine(time: time, price: price + variation));
        }
        break;

      case "1M":
        // 30 days - gradual increase with plateaus
        const startPrice = 0.0280;
        const endPrice = 0.0335;
        for (int i = 30; i >= 0; i--) {
          final time =
              now.subtract(Duration(days: i)).millisecondsSinceEpoch.toDouble();
          final progress = (30 - i) / 30;
          // Create stepped increases (plateaus)
          final stepped = (progress * 4).floor() / 4;
          final price = startPrice + (endPrice - startPrice) * stepped;
          // Minimal variation for clean lines
          final variation = ((i % 4) - 1.5) * 0.008 * price / 3;
          data.add(ChartLine(time: time, price: price + variation));
        }
        break;

      case "1Y":
        // 365 days - significant upward trend with some dips
        const startPrice = 0.0180;
        const endPrice = 0.0335;
        for (int i = 365; i >= 0; i -= 7) {
          // Weekly data points for performance
          final time =
              now.subtract(Duration(days: i)).millisecondsSinceEpoch.toDouble();
          final progress = (365 - i) / 365;
          // Add some realistic market movements
          double multiplier = 1.0;
          if (progress > 0.3 && progress < 0.5)
            multiplier = 0.85; // Mid-year dip
          if (progress > 0.7) multiplier = 1.1; // Late year pump

          final price =
              (startPrice + (endPrice - startPrice) * progress) * multiplier;
          final variation = ((i % 7) - 3) * 0.01 * price / 6;
          data.add(ChartLine(time: time, price: price + variation));
        }
        break;

      case "Max":
        // 2 years - long-term growth story
        const startPrice = 0.0120;
        const endPrice = 0.0335;
        for (int i = 730; i >= 0; i -= 14) {
          // Bi-weekly data points
          final time =
              now.subtract(Duration(days: i)).millisecondsSinceEpoch.toDouble();
          final progress = (730 - i) / 730;
          // Exponential-like growth curve
          final exponentialProgress =
              progress * progress * 0.7 + progress * 0.3;
          final price =
              startPrice + (endPrice - startPrice) * exponentialProgress;
          final variation = ((i % 14) - 7) * 0.015 * price / 10;
          data.add(ChartLine(time: time, price: price + variation));
        }
        break;

      default:
        // Fallback to 1W
        return generateMockChartData();
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding.w, vertical: AppTheme.cardPadding.h),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed([
          // Collection Price Chart
          SizedBox(height: AppTheme.cardPadding.h),
          _buildPriceHeader(),
          SizedBox(height: 12.h),
          _buildPriceChart(),
          SizedBox(height: AppTheme.cardPadding * 2.h),

          // Price Statistics Section
          Text(
            "Analytics",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),

          // Statistics Card - Improved Design
          GlassContainer(
            opacity: 0.08,
            width: double.infinity,
            borderRadius: AppTheme.borderRadiusMid,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildStatRow(context, "Floor Price", "0.0335 BTC",
                      isFloorPrice: true),
                  SizedBox(height: 18.h),
                  _buildStatRow(context, "24h Volume", "2.47 BTC"),
                  SizedBox(height: 18.h),
                  _buildStatRow(context, "Total Volume", "847.32 BTC"),
                  SizedBox(height: 18.h),
                  _buildStatRow(context, "Listed", "52 / 1000"),
                  SizedBox(height: 18.h),
                  _buildStatRow(context, "Unique Owners", "673"),
                  SizedBox(height: 18.h),
                  _buildStatRow(context, "Owner Percentage", "67.3%"),
                ],
              ),
            ),
          ),
          SizedBox(height: AppTheme.cardPadding * 2.h),

          // Recent Sales Section
          Text(
            "Recent Sales",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),

          // Search bar
          SearchFieldWidget(
            hintText: "Search sales...",
            isSearchEnabled: true,
            handleSearch: (value) {
              // Handle search submission
            },
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          SizedBox(height: 16.h),

          // Sales List
          _buildRecentSalesList(context),
        ]),
      ),
    );
  }

  Widget _buildPriceHeader() {
    // Calculate price change

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Collection Price",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        SizedBox(height: AppTheme.elementSpacing.h),
      ],
    );
  }

  Widget _buildPriceChart() {
    final firstPrice = chartData.first.price;
    final lastPrice = chartData.last.price;
    final priceChange = (lastPrice - firstPrice) / firstPrice;
    final priceChangeStr = "${(priceChange * 100).toStringAsFixed(2)}%";
    final isPositive = priceChange >= 0;

    return Column(
      children: [
        // Main Chart Container
        GlassContainer(
          width: double.infinity,
          opacity: 0.08,
          borderRadius: AppTheme.borderRadiusMid,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Price Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Floor Price",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.7),
                                  ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${lastPrice.toStringAsFixed(4)} BTC",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    PercentageChangeWidget(
                      percentage: priceChangeStr,
                      isPositive: isPositive,
                      fontSize: 16,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Chart
                Container(
                  height: 240.h,
                  child: SfCartesianChart(
                    margin: EdgeInsets.zero,
                    plotAreaBorderWidth: 0,
                    enableAxisAnimation:
                        false, // Disable animation for consistent UX
                    primaryXAxis: DateTimeAxis(
                      isVisible: false,
                      majorGridLines: const MajorGridLines(width: 0),
                      axisLine: const AxisLine(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      isVisible: false,
                      majorGridLines: const MajorGridLines(width: 0),
                      axisLine: const AxisLine(width: 0),
                    ),
                    trackballBehavior: TrackballBehavior(
                      enable: true,
                      activationMode: ActivationMode.singleTap,
                      tooltipSettings: InteractiveTooltip(
                        enable: true,
                        canShowMarker: true,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      lineType: TrackballLineType.vertical,
                      lineWidth: 2,
                      lineColor:
                          Theme.of(context).dividerColor.withOpacity(0.3),
                      markerSettings: TrackballMarkerSettings(
                        markerVisibility: TrackballVisibilityMode.visible,
                        color: isPositive
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        borderColor: isPositive
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        borderWidth: 2,
                        width: 8,
                        height: 8,
                      ),
                    ),
                    series: <CartesianSeries>[
                      // Main price line
                      LineSeries<ChartLine, DateTime>(
                        dataSource: chartData,
                        xValueMapper: (ChartLine data, _) =>
                            DateTime.fromMillisecondsSinceEpoch(
                                data.time.toInt()),
                        yValueMapper: (ChartLine data, _) => data.price,
                        color: isPositive
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        width: 3,
                        animationDuration:
                            0, // Disable animation for consistent UX
                      ),
                      // Area fill for better visual appeal
                      AreaSeries<ChartLine, DateTime>(
                        dataSource: chartData,
                        xValueMapper: (ChartLine data, _) =>
                            DateTime.fromMillisecondsSinceEpoch(
                                data.time.toInt()),
                        yValueMapper: (ChartLine data, _) => data.price,
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
                          ],
                        ),
                        borderColor: isPositive
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        borderWidth: 0,
                        animationDuration:
                            0, // Disable animation for consistent UX
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Separate Timeframe Selector
        _buildTimeFrameSelector(),
      ],
    );
  }

  Widget _buildTimeFrameSelector() {
    final timeframes = ["1D", "1W", "1M", "1Y", "Max"];

    return GlassContainer(
      width: double.infinity,
      opacity: 0.08,
      borderRadius: AppTheme.borderRadiusSmall,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Timeframe",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: timeframes.map((timeframe) {
                final isSelected = selectedTimespan == timeframe;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTimespan = timeframe;
                          // Regenerate chart data for new timeframe
                          chartData = generateMockChartData();
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 10.h,
                          ),
                          child: Text(
                            timeframe,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color!
                                          .withOpacity(0.8),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Keep the old method for backwards compatibility but make it call the new one
  Widget _buildTimeFrameButtons() {
    return _buildTimeFrameSelector();
  }

  Widget _buildStatRow(BuildContext context, String label, String value,
      {bool isFloorPrice = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
        ),
        Container(
          padding: isFloorPrice
              ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h)
              : null,
          decoration: isFloorPrice
              ? BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                )
              : null,
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isFloorPrice
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSalesList(BuildContext context) {
    final allSalesData = [
      {
        "id": "#2390",
        "price": "0.024 BTC",
        "date": "2 hours ago",
        "from": "User1",
        "to": "User2"
      },
      {
        "id": "#1872",
        "price": "0.031 BTC",
        "date": "5 hours ago",
        "from": "User3",
        "to": "User4"
      },
      {
        "id": "#2103",
        "price": "0.018 BTC",
        "date": "1 day ago",
        "from": "User5",
        "to": "User6"
      },
      {
        "id": "#1945",
        "price": "0.027 BTC",
        "date": "2 days ago",
        "from": "User7",
        "to": "User8"
      },
      {
        "id": "#2287",
        "price": "0.022 BTC",
        "date": "3 days ago",
        "from": "User9",
        "to": "User10"
      },
    ];

    // Filter sales based on search query
    final salesData = allSalesData.where((sale) {
      if (searchQuery.isEmpty) return true;

      final query = searchQuery.toLowerCase();
      return sale["id"]!.toLowerCase().contains(query) ||
          sale["price"]!.toLowerCase().contains(query) ||
          sale["from"]!.toLowerCase().contains(query) ||
          sale["to"]!.toLowerCase().contains(query);
    }).toList();

    if (salesData.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Text(
            "No sales found matching your search",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    return Column(
      children: salesData.map((sale) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: GlassContainer(
            opacity: 0.08,
            width: double.infinity,
            borderRadius: AppTheme.borderRadiusSmall,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  // Asset image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      nftImage1,
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Sale details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inscription ${sale["id"]}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${sale["from"]} → ${sale["to"]}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  // Price and time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(sale["price"].toString(),
                          style: Theme.of(context).textTheme.titleMedium),
                      SizedBox(height: 4.h),
                      Text(
                        sale["date"].toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
