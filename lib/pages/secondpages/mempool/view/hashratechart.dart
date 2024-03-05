//hashchart rate

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/analystsassesment.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_echarts/flutter_echarts.dart' as echarts;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:universal_html/html.dart';

class HashrateChart extends StatefulWidget {
  List<ChartLine> chartData = []; // The fake data will be stored here
  List<Difficulty> difficulty = [];

  HashrateChart({required this.chartData, required this.difficulty, super.key});

  @override
  State<HashrateChart> createState() => _HashrateChartState();
}

class _HashrateChartState extends State<HashrateChart> {
  late TrackballBehavior _trackballBehavior;

  List<ChartLine> chartData = [];

  @override
  void initState() {
    super.initState();
    _trackballBehavior = TrackballBehavior(
      lineColor: Colors.grey[400],
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineWidth: 2,
      lineType: TrackballLineType.horizontal,
      tooltipSettings: InteractiveTooltip(enable: false),
      markerSettings: const TrackballMarkerSettings(
          color: Colors.white,
          borderColor: Colors.white,
          markerVisibility: TrackballVisibilityMode.visible),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('ab ${widget.difficulty.length}');
    return SizedBox(
      height: AppTheme.cardPadding * 16,
      child: SfCartesianChart(
          trackballBehavior: _trackballBehavior,
          primaryXAxis: DateTimeAxis(
            intervalType: DateTimeIntervalType.days,
            majorGridLines: MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            axisLine: AxisLine(width: 1),
            majorTickLines: MajorTickLines(size: 0),
            numberFormat: NumberFormat.compact(),
          ),
          series: <CartesianSeries>[
            StackedLineSeries<ChartLine, DateTime>(
              name: 'Hashrate',
              enableTooltip: true,
              dataSource: widget.chartData,
              xValueMapper: (ChartLine sales, _) =>
                  DateTime.fromMillisecondsSinceEpoch(
                      sales.time.toInt() * 1000,
                      isUtc: true),
              yValueMapper: (ChartLine sales, _) =>
                  double.parse(sales.price.toString().substring(0, 4)),
            ),
            StackedLineSeries<Difficulty, DateTime>(
              name: 'Difficulty',
              enableTooltip: true,
              dataSource: widget.difficulty,
              xValueMapper: (Difficulty sales, _) =>
                  DateTime.fromMillisecondsSinceEpoch(sales.time! * 1000,
                      isUtc: true),
              yValueMapper: (Difficulty sales, _) => double.parse(
                  (sales.difficulty! / 100000000000).toStringAsFixed(
                      2)), // Assuming price is double type
            ),
          ]),
    );
  }
}
