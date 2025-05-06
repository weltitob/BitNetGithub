import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
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
    // Create mock data for a price chart (last 7 days)
    final List<ChartLine> data = [];
    final now = DateTime.now();
    double basePrice = 0.032; // Base price in BTC

    // Generate data points for the last 7 days with some random fluctuations
    for (int i = 7; i >= 0; i--) {
      final time =
          now.subtract(Duration(days: i)).millisecondsSinceEpoch.toDouble();
      // Random fluctuation between -15% and +15%
      final randomFactor = 1.0 +
          (0.15 *
              (0.5 -
                  (DateTime(now.year, now.month, now.day)
                              .millisecondsSinceEpoch %
                          10) /
                      10));
      final price = basePrice * randomFactor;
      basePrice = price; // Each day builds on the previous price
      data.add(ChartLine(time: time, price: price));
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
          SizedBox(height: AppTheme.cardPadding * 1.h),
          _buildPriceHeader(),
          SizedBox(height: 8.h),
          _buildPriceChart(),
          SizedBox(height: AppTheme.cardPadding * 1.5.h),

          // Price Statistics Section
          Text(
            "Price Statistics",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12.h),

          // Statistics Card
          GlassContainer(
            opacity: 0.1,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatRow(context, "Floor Price", "0.025 BTC"),
                  SizedBox(height: 16.h),
                  _buildStatRow(context, "24h Volume", "0.021 BTC"),
                  SizedBox(height: 16.h),
                  _buildStatRow(context, "Total Volume", "1.0235 BTC"),
                  SizedBox(height: 16.h),
                  _buildStatRow(context, "Listed", "52"),
                  SizedBox(height: 16.h),
                  _buildStatRow(context, "Supply", "1000"),
                  SizedBox(height: 16.h),
                  _buildStatRow(context, "Owners", "250"),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Recent Sales Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Sales",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

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

    return GlassContainer(
      width: double.infinity,
      opacity: 0.1,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${lastPrice.toStringAsFixed(4)} BTC",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                PercentageChangeWidget(
                  percentage: priceChangeStr,
                  isPositive: isPositive,
                  fontSize: 14,
                ),
              ],
            ),
            Container(
              height: 200.h,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: DateTimeAxis(
                  dateFormat: null,
                  intervalType: DateTimeIntervalType.days,
                  isVisible: false,
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  isVisible: false,
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                trackballBehavior: TrackballBehavior(
                  enable: true,
                  activationMode: ActivationMode.singleTap,
                  tooltipSettings: InteractiveTooltip(
                    enable: false,
                  ),
                  lineType: TrackballLineType.vertical,
                  lineWidth: 1,
                  lineColor: Colors.grey.withOpacity(0.5),
                ),
                series: <ChartSeries>[
                  SplineSeries<ChartLine, DateTime>(
                    dataSource: chartData,
                    xValueMapper: (ChartLine data, _) =>
                        DateTime.fromMillisecondsSinceEpoch(data.time.toInt()),
                    yValueMapper: (ChartLine data, _) => data.price,
                    color: chartData.first.price <= chartData.last.price
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    width: 3,
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildTimeFrameButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeFrameButtons() {
    final timeframes = ["1D", "1W", "1M", "1Y", "Max"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: timeframes.map((timeframe) {
        final isSelected = selectedTimespan == timeframe;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTimespan = timeframe;
              // In a real implementation, we would update the chart data here
              // For now, we'll just update the UI state
            });
          },
          child: GlassContainer(
            opacity: isSelected ? 0.3 : 0.1,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.elementSpacing * 1,
                  vertical: AppTheme.elementSpacing * 0.5),
              child: Text(
                timeframe,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).textTheme.bodyMedium?.color
                      : Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
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
        return GlassContainer(
          opacity: 0.1,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 12.h),
          child: Padding(
            padding: EdgeInsets.all(12),
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
        );
      }).toList(),
    );
  }
}
