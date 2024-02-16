//hashchart rate

import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_echarts/flutter_echarts.dart' as echarts;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
 
 
class HashrateChart extends StatefulWidget {
  List<ChartLine> chartData = []; // The fake data will be stored here

  HashrateChart({required this.chartData, super.key});

  @override
  State<HashrateChart> createState() => _HashrateChartState();
}

class _HashrateChartState extends State<HashrateChart> {
  late TrackballBehavior _trackballBehavior;

  // Generate fake data for the chart
  // void generateFakeData() {
  //   chartData = List.generate(100, (index) {
  //     double fakeTime = index.toDouble();
  //     double fakePrice = index * 5.0;
  //     return ChartLine(time: fakeTime, price: fakePrice);
  //   });
  // }

  List<ChartLine> chartData = [];

  @override
  void initState() {
    super.initState();
    // generateFakeData();
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
    return  Container(height: 400,child: Column(
      children: [
        Row(children: [
          Text('Price'),
          Spacer(),
          Text('  Time'),
          Spacer()
        ]),
        Expanded(
          child: ListView.builder(
            itemCount: widget.chartData.length,
             itemBuilder: (context,index)=>Row(children: [
              Text((widget.chartData[index].price).toString().substring(0,3)+' EH/s'),
              SizedBox(width: 100,),
               Text(DateFormat('d MMM').format( DateTime.fromMillisecondsSinceEpoch(int.parse(((widget.chartData[index].time*1000).round()).toString()))))
              ],),
              ),
        )
       ],
    ),);
    // SfCartesianChart(
    //   trackballBehavior: _trackballBehavior,
    //   series: <ChartSeries>[
    //     LineSeries<ChartLine, double>(
    //         dataSource: widget.chartData,
    //         xValueMapper: (ChartLine data, _) =>  data.time,
    //         yValueMapper: (ChartLine data, _) =>
    //             data.price / 1000000000000000000),
    //   ],
    // );

    // return SfCartesianChart(
    //   trackballBehavior: _trackballBehavior,
    // series: <ChartSeries>[
    //     LineSeries<ChartLine, double>(
    //       dataSource: chartData,
    //       xValueMapper: (ChartLine data, _) => data.time,
    //       yValueMapper: (ChartLine data, _) => data.price,
    //       // Other series settings
    //     )
    //   ],
    //   // Other chart settings
    // );
  }
}

