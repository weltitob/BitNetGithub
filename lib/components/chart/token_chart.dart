import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/timechooserbutton.dart';
import 'package:bitnet/components/items/colored_price_widget.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

// Token chart widget for displaying token price history (to be deleted later only to mock user workflow)
class TokenChartWidget extends StatefulWidget {
  final String tokenSymbol;
  final Map<String, dynamic> priceHistory;
  final double currentPrice;
  
  const TokenChartWidget({
    Key? key,
    required this.tokenSymbol,
    required this.priceHistory,
    required this.currentPrice,
  }) : super(key: key);

  @override
  _TokenChartWidgetState createState() => _TokenChartWidgetState();
}

class _TokenChartWidgetState extends State<TokenChartWidget> {
  String selectedPeriod = '1D';
  late List<ChartData> chartData;
  late double firstPrice;
  late double lastPrice;
  late double priceChange;
  late String percentageChange;
  late bool isPositive;
  
  @override
  void initState() {
    super.initState();
    _updateChartData();
  }
  
  void _updateChartData() {
    // Get data for selected period
    final periodData = widget.priceHistory[selectedPeriod] as List<Map<String, dynamic>>;
    
    // Convert to chart data
    chartData = periodData.map((point) {
      return ChartData(
        DateTime.fromMillisecondsSinceEpoch(point['time'] as int),
        double.parse(point['price'].toString()),
      );
    }).toList();
    
    // Calculate price change
    if (chartData.isNotEmpty) {
      firstPrice = chartData.first.price;
      lastPrice = chartData.last.price;
      priceChange = lastPrice - firstPrice;
      double percentChange = (priceChange / firstPrice) * 100;
      percentageChange = '${percentChange >= 0 ? '+' : ''}${percentChange.toStringAsFixed(2)}%';
      isPositive = priceChange >= 0;
    } else {
      firstPrice = widget.currentPrice;
      lastPrice = widget.currentPrice;
      priceChange = 0;
      percentageChange = '+0.00%';
      isPositive = true;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Price info header
        Container(
          margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColoredPriceWidget(
                    price: lastPrice.toStringAsFixed(2),
                    isPositive: isPositive,
                  ),
                  SizedBox(height: 4.h),
                  PercentageChangeWidget(
                    percentage: percentageChange,
                    isPositive: isPositive,
                  ),
                ],
              ),
              // Time period selector
              Row(
                children: ['1D', '1W', '1M', '1Y'].map((period) {
                  return Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: TimeChooserButton(
                      timeperiod: period,
                      timespan: selectedPeriod,
                      onPressed: () {
                        setState(() {
                          selectedPeriod = period;
                          _updateChartData();
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        
        // Chart
        Container(
          height: 250.h,
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: DateTimeAxis(
              isVisible: true,
              majorGridLines: MajorGridLines(width: 0),
              minorGridLines: MinorGridLines(width: 0),
              axisLine: AxisLine(width: 0),
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5),
                fontSize: 10,
              ),
              dateFormat: _getDateFormat(),
            ),
            primaryYAxis: NumericAxis(
              isVisible: true,
              majorGridLines: MajorGridLines(
                width: 0.5,
                color: Theme.of(context).dividerColor.withOpacity(0.3),
              ),
              minorGridLines: MinorGridLines(width: 0),
              axisLine: AxisLine(width: 0),
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5),
                fontSize: 10,
              ),
              numberFormat: NumberFormat.currency(symbol: '\$', decimalDigits: 2),
            ),
            series: <ChartSeries>[
              AreaSeries<ChartData, DateTime>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.time,
                yValueMapper: (ChartData data, _) => data.price,
                color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                borderColor: isPositive ? AppTheme.successColor : AppTheme.errorColor,
                borderWidth: 2,
                gradient: LinearGradient(
                  colors: [
                    (isPositive ? AppTheme.successColor : AppTheme.errorColor).withOpacity(0.3),
                    (isPositive ? AppTheme.successColor : AppTheme.errorColor).withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ],
            trackballBehavior: TrackballBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
              tooltipSettings: InteractiveTooltip(
                enable: true,
                color: Theme.of(context).colorScheme.surface,
                textStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                borderColor: Theme.of(context).dividerColor,
                borderWidth: 1,
              ),
              lineWidth: 1,
              lineColor: Theme.of(context).dividerColor,
              markerSettings: TrackballMarkerSettings(
                markerVisibility: TrackballVisibilityMode.visible,
                height: 8,
                width: 8,
                borderWidth: 2,
                borderColor: isPositive ? AppTheme.successColor : AppTheme.errorColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  DateFormat _getDateFormat() {
    switch (selectedPeriod) {
      case '1D':
        return DateFormat.Hm(); // Hours:Minutes
      case '1W':
        return DateFormat.MMMd(); // Month Day
      case '1M':
        return DateFormat.MMMd(); // Month Day
      case '1Y':
        return DateFormat.MMM(); // Month
      default:
        return DateFormat.MMMd();
    }
  }
}

class ChartData {
  final DateTime time;
  final double price;
  
  ChartData(this.time, this.price);
}