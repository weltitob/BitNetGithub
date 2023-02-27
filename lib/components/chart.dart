import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexus_wallet/components/currencypicture.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/loaders.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:convert';
import 'package:http/http.dart';

class CryptoChartLine{
  final String crypto;
  final String interval;
  final String days;
  final String currency;

  CryptoChartLine({
    required this.crypto,
    required this.interval,
    required this.days,
    required this.currency,
  });

  List<ChartLine> chartLine  = [];
  Future<void> getChartData() async{
    var url = "https://api.coingecko.com/api/v3/coins/$crypto/market_chart?vs_currency=$currency&days=$days&interval=$interval";
    Response res = await get(Uri.parse(url));
    var jsonData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if(days == "max"){
        for(var i = 0; i < jsonData["prices"].length; i+=14) {
          dynamic element = jsonData["prices"][i];
          double time = element[0].toDouble();
          double price = element[1].toDouble();
          ChartLine chartData = ChartLine(
            time: time,
            price: price,
          );
          chartLine.add(chartData);
        }
      }
      else if (days == "30") {
        for (var i = 0; i < jsonData["prices"].length; i += 4) {
          dynamic element = jsonData["prices"][i];
          double time = element[0].toDouble();
          double price = element[1].toDouble();
          ChartLine chartData = ChartLine(
            time: time,
            price: price,
          );
          chartLine.add(chartData);
        }
      }
      else {
        jsonData["prices"].forEach((element) {
          double time = element[0].toDouble();
          double price = element[1].toDouble();
          ChartLine chartData = ChartLine(
            time: time,
            price: price,
          );
          chartLine.add(chartData);
        });
      }
    } else {
      throw "Unable to retrieve chart data from Coingecko.";
    }
  }
}


class ChartLine {
  final double time;
  final double price;

  ChartLine({
    required this.time,
    required this.price
  });
}

class buildChart extends StatefulWidget {
  const buildChart({
    Key? key,
  }) : super(key: key);

  @override
  _buildChartState createState() => _buildChartState();
}

class _buildChartState extends State<buildChart> {
  late TrackballBehavior _trackballBehavior;
  late List<ChartLine> chartData;
  late List<ChartLine> maxchart;
  late List<ChartLine> oneyearchart;
  late List<ChartLine> onemonthchart;
  late List<ChartLine> oneweekchart;
  late List<ChartLine> onedaychart;
  late List<ChartLine> currentline;
  late bool _loading;
  String timespan = "1D";

  getChartLine() async {
    CryptoChartLine chartClassDay = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "1",
      interval: "minutely",
    );
    CryptoChartLine chartClassWeek = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "7",
      interval: "hourly",
    );
    CryptoChartLine chartClassMonth = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "30",
      interval: "hourly",
    );
    CryptoChartLine chartClassYear = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "365",
      interval: "daily",
    );
    CryptoChartLine chartClassMax = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "max",
      interval: "daily",
    );
    await chartClassDay.getChartData();
    await chartClassWeek.getChartData();
    await chartClassMonth.getChartData();
    await chartClassYear.getChartData();
    await chartClassMax.getChartData();

    maxchart = chartClassMax.chartLine;
    oneyearchart = chartClassYear.chartLine;
    onemonthchart = chartClassMonth.chartLine;
    oneweekchart = chartClassWeek.chartLine;
    onedaychart = chartClassDay.chartLine;
    currentline = onedaychart;

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    getChartLine();
    _trackballBehavior = TrackballBehavior(
        lineColor: Colors.grey[400],
        enable: true,
        tooltipDisplayMode: TrackballDisplayMode.none,
        activationMode: ActivationMode.singleTap,
        lineWidth: 2,
        lineType: TrackballLineType.horizontal,
        markerSettings: const TrackballMarkerSettings(
            color: Colors.grey,
            borderColor:  Colors.grey,
            markerVisibility: TrackballVisibilityMode.visible));
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeFormat = DateFormat("HH:mm:ss");
    String date = dateFormat.format(DateTime.now());
    String time = timeFormat.format(DateTime.now());

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            children: [
              Row(
                children: [
                  currencyPicture(context),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 7.5)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "BTC",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              date.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              "Bitcoin",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _loading ? "" : "${double.parse((onedaychart[onedaychart.length-1].price).toStringAsFixed(2))}€",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    child: InkWell(
                      child: Container(
                          width: 80,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: _loading
                                  ? 10 < 0
                                  ? AppTheme.successColor.withOpacity(0.5)
                                  : AppTheme.errorColor.withOpacity(0.5)
                                  : currentline[0].price < currentline[currentline.length - 1].price
                                  ? AppTheme.successColor.withOpacity(0.5)
                                  : AppTheme.errorColor.withOpacity(0.5)),
                          child: Center(
                            child: Text(
                                _loading
                                    ? formatpercentvalue("")
                                    : formatpercentvalue(
                                  percent_of_change(
                                      currentline[0].price,
                                      currentline[currentline.length - 1].price)
                                      .toStringAsFixed(2),
                                ),
                                style:
                                Theme.of(context).textTheme.subtitle2),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              child: _loading
                  ? Center(
                child: Container(
                  color: AppTheme.colorBackground,
                  height: AppTheme.cardPadding * 15,
                  child: avatarGlow(context, Icons.currency_bitcoin,),
                ),
              )
                  : SizedBox(
                    height: AppTheme.cardPadding * 15,
                    child: SfCartesianChart(
                        trackballBehavior: _trackballBehavior,
                        enableAxisAnimation: true,
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(
                            labelPlacement: LabelPlacement.onTicks,
                            edgeLabelPlacement: EdgeLabelPlacement.none,
                            isVisible: false,
                            majorGridLines: const MajorGridLines(width: 0),
                            majorTickLines: const MajorTickLines(width: 0)),
                        primaryYAxis: NumericAxis(
                            plotBands: <PlotBand>[
                              PlotBand(
                                  isVisible: true,
                                  dashArray: const <double>[2, 5],
                                  start: getaverage(currentline),
                                  end: getaverage(currentline),
                                  horizontalTextAlignment: TextAnchor.start,
                                  textStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  borderColor: Colors.grey,
                                  borderWidth: 1.5)
                            ],
                            plotOffset: 0,
                            edgeLabelPlacement: EdgeLabelPlacement.none,
                            isVisible: false,
                            majorGridLines: const MajorGridLines(width: 0),
                            majorTickLines: const MajorTickLines(width: 0)),
                        series: <ChartSeries>[
                          // Renders line chart
                          LineSeries<ChartLine, double>(
                            dataSource: currentline,
                            animationDuration: 0,
                            xValueMapper: (ChartLine crypto, _) => crypto.time,
                            yValueMapper: (ChartLine crypto, _) => crypto.price,
                            color:
                            currentline[0].price <
                                currentline[currentline.length - 1].price
                                ? AppTheme.successColor
                                : AppTheme.errorColor,
                          )
                        ]),
                  ),
            ),
          ],
        ),
        buildTimeChooser(),
      ],
    );
  }

  Widget buildTimeChooser() {
    return Container(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          glassButton("1D"),
          glassButton("1W"),
          glassButton("1M"),
          glassButton("1Y"),
          glassButton("Max")
        ],
      ),
    );
  }

  Widget glassButton(String timeperiod) {
    return GestureDetector(
      onTap: () {
        setState(() {
          timespan = timeperiod;
          switch (timespan) {
            case "1D":
              currentline = onedaychart;
              break;
            case "1W":
              currentline = oneweekchart;
              break;
            case "1M":
              currentline = onemonthchart;
              break;
            case "1Y":
              currentline = oneyearchart;
              break;
            case "Max":
              currentline = maxchart;
              break;
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2),
        child: timespan == timeperiod ?
        Glassmorphism(
          blur: 20,
          opacity: 0.1,
          radius: 50.0,
          child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft),
            onPressed: () {
              // handle push to HomeScreen
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppTheme.elementSpacing * 0.5,
                horizontal: AppTheme.elementSpacing,
              ),
              child: Text(
                timeperiod,
                style:
                Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: timespan == timeperiod ? Theme.of(context).colorScheme.
                    onPrimaryContainer : Theme.of(context).colorScheme.
                    onPrimaryContainer.withOpacity(0.6)
                )
              ),
            ),
          ),
        ) :
        TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 20),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft),
          onPressed: () {
            setState(() {
              timespan = timeperiod;
              switch (timespan) {
                case "1D":
                  currentline = onedaychart;
                  break;
                case "1W":
                  currentline = oneweekchart;
                  break;
                case "1M":
                  currentline = onemonthchart;
                  break;
                case "1Y":
                  currentline = oneyearchart;
                  break;
                case "Max":
                  currentline = maxchart;
                  break;
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppTheme.elementSpacing * 0.5,
              horizontal: AppTheme.elementSpacing,
            ),
            child: Text(
                timeperiod,
                style:
                Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: timespan == timeperiod ? Theme.of(context).colorScheme.
                    onPrimaryContainer : Theme.of(context).colorScheme.
                    onPrimaryContainer.withOpacity(0.6)
                ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChildTimeChooser(String timeperiod) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: Container(
          decoration: BoxDecoration(
            color: timespan == timeperiod
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
            child: Text(timeperiod,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: timespan == timeperiod ? Theme.of(context).colorScheme.
                    onPrimaryContainer : Theme.of(context).colorScheme.
                    onPrimaryContainer.withOpacity(0.6)
                )
            ),
          ),
        ),
      ),

    );
  }
}

//Helper

getaverage(dynamic currentline){
  return currentline.map((m) => m.price).reduce((a, b) => a + b) / currentline.length;
}

double percent_of_change(num num1, num num2) => ((num2 - num1) / num1) * 100;

formatpercentvalue(String percent) {
  if (percent.contains('-')) {
    if(percent.length > 7){
      String percentwithoutminus = percent.replaceAll('-', '');
      double toolongpercent = double.parse(percentwithoutminus);
      String formattedpercent = "- ${toolongpercent.toStringAsFixed(0)}%";
      return formattedpercent;
    } else {
      String percentwithoutminus = percent.replaceAll('-', '');
      String formattedpercent = "- ${percentwithoutminus}%";
      return formattedpercent;
    }
  }
  else {
    if(percent.length > 7){
      double toolongpercent = double.parse(percent);
      String formattedpercent = "+ ${toolongpercent.toStringAsFixed(0)}%";
      return formattedpercent;
    }
    else {
      String formattedpercent = "+ ${percent}%";
      return formattedpercent;
    }
  }
}