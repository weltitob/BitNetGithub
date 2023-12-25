import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/pages/secondpages/whalebehaviour.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';



class AnalysisWidget extends StatelessWidget {

  //Cloudservices
  IEXCloudServicePrice iexcloudprice = IEXCloudServicePrice();
  IEXCloudServiceAnalysts iexcloudanalysts = IEXCloudServiceAnalysts();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 300,
                child: Text(
                  "The stock is covered by 67 analysts. The average assesment is:",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  )),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "\$",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Container(
                        height: 7.5,
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 5,
                      )),

                  FutureBuilder<List<Analysts>>(
                      future: iexcloudanalysts.getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data![0].marketConsensusTargetPrice,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        if(snapshot.hasError){
                          return Text(
                            'N/A',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        else {
                          return const Text(
                            "---",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      }
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  )),
              ChildbuildAnalysis2("Highest assesment:", 1200.28),
              ChildbuildAnalysis2("Lowest assesment:", 321.1),
              Padding(
                padding: EdgeInsets.only(
                  top: 5,
                ),
              ),
            ],
          ),
        ),
        ChildbuildAnalysis(),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: MyDivider(),
        ),
        ChildbuildSentimentAnalysis(context, "News sentiment", "negative", "positive", 16),
        ChildbuildSentimentAnalysis(context, "Fear-Greed", "Extreme fear", "Extreme greed", 50),
        ChildbuildSentimentAnalysis(context, "Whale-Behaviour", "Bearish", "Bullish", 20),
      ],
    );
  }

  Widget ChildbuildSentimentAnalysis(BuildContext context,String text, String textred, String textgreen,
      double sentimentvalue) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              text,
              style: Theme.of(context).textTheme.bodyText2
          ),
          Padding(
              padding: EdgeInsets.only(
                right: 5,
              )),
          Container(
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SfLinearGauge(
                  showTicks: false,
                  showLabels: false,
                  useRangeColorForAxis: true,
                  axisTrackStyle: LinearAxisTrackStyle(
                      thickness: 5,
                      color: Colors.grey,
                      edgeStyle: LinearEdgeStyle.bothCurve,
                      gradient: LinearGradient(
                          colors: [Colors.redAccent, Colors.greenAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.1, 0.9],
                          tileMode: TileMode.clamp)),
                  minimum: 0,
                  maximum: 100,
                  markerPointers: [
                    LinearWidgetPointer(
                        value: sentimentvalue,
                        child: Container(
                          height: 15,
                          width: 7.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        textred,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        textgreen,
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
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

  Widget ChildbuildAnalysis() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 110,
            width: 110,
            child: Container(
                child: SfCircularChart(margin: const EdgeInsets.all(0),
                    // legend: Legend(
                    //     isVisible: true,
                    //     position: LegendPosition.right,
                    //     textStyle: TextStyle(
                    //         color: Colors.white, fontWeight: FontWeight.w500)),
                    series: <CircularSeries>[
                      DoughnutSeries<PieChartData, String>(
                          dataSource: getPieData(),
                          pointColorMapper: (PieChartData data, _) => data.color,
                          xValueMapper: (PieChartData data, _) => data.x,
                          yValueMapper: (PieChartData data, _) => data.y)
                    ])),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildChildbuildAnalysisChartLegend(
                  "Buy:", "121 Analysts", Colors.greenAccent),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
              ),
              ChildChildbuildAnalysisChartLegend(
                  "Sell:", "29 Analysts", Colors.redAccent),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
              ),
              ChildChildbuildAnalysisChartLegend(
                  "Hold:", "14 Analysts", Colors.white),
            ],
          )
        ],
      ),
    );
  }

  Widget ChildChildbuildAnalysisChartLegend(String text, String text2, color) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 14,
            color: color,
          ),
          Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            text2,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }


  Widget ChildbuildAnalysis2(String text, double assesment) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
              left: 5,
            )),
        Column(
          children: [
            Text(
              "\$",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Container(
              height: 5,
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.only(
              left: 2.5,
            )),
        Text(
          assesment.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class PieChartData {
  PieChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class ChartData {
  String x;
  double y;
  Color color;
  ChartData(this.x, this.y, this.color);
}

dynamic getColumnData() {
  List<ChartData> columnData = <ChartData>[
    ChartData("BMW", 54, Color.fromRGBO(65, 157, 120, 1)),
    ChartData("AMC", 19, Color.fromRGBO(65, 157, 120, 1)),
    ChartData("VW", 7, Color.fromRGBO(219, 80, 74, 1)),
    ChartData("BB", 5, Color.fromRGBO(65, 157, 120, 1)),
    ChartData("HITI", 3, Color.fromRGBO(219, 80, 74, 1)),
  ];
  return columnData;
}

dynamic getPieData() {
  List<PieChartData> piechartData = [
    PieChartData('positive mentions', 50, Color.fromRGBO(65, 157, 120, 1)),
    PieChartData('negative mentions', 20, Color.fromRGBO(219, 80, 74, 1)),
    PieChartData('neutral', 30, Color.fromRGBO(221, 209, 199, 1)),
  ];
  return piechartData;
}

