
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart' as echarts;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HashrateChart extends StatefulWidget {
  const HashrateChart({super.key});

  @override
  State<HashrateChart> createState() => _HashrateChartState();
}

class _HashrateChartState extends State<HashrateChart> {
  late TrackballBehavior _trackballBehavior;

  // Generate fake data for the chart
  void generateFakeData() {
    widget.chartData = List.generate(100, (index) {
      double fakeTime = index.toDouble();
      double fakePrice = index * 5.0; // Incrementing price for each data point
      return ChartLine(time: fakeTime, price: fakePrice);
    });
  }

  @override
  void initState() {
    super.initState();
    generateFakeData(); // Generate fake data on init
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
    return SfCartesianChart(
      trackballBehavior: _trackballBehavior,
      series: <ChartSeries>[
        LineSeries<ChartLine, double>(
          dataSource: chartData,
          xValueMapper: (ChartLine data, _) => data.time,
          yValueMapper: (ChartLine data, _) => data.price,
          // Other series settings
        )
      ],
      // Other chart settings
    );
  }
}

