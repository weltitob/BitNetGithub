import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/components/currencypicture.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/loaders.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:convert';
import 'package:http/http.dart';

GlobalKey<_CustomWidgetState> key = GlobalKey<_CustomWidgetState>();
String trackBallValuePrice = "";
String trackBallValueTime = "";

class CryptoChartLine {
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

  List<ChartLine> chartLine = [];
  Future<void> getChartData() async {
    var url =
        "https://api.coingecko.com/api/v3/coins/$crypto/market_chart?vs_currency=$currency&days=$days&interval=$interval";
    Response res = await get(Uri.parse(url));
    var jsonData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (days == "max") {
        for (var i = 0; i < jsonData["prices"].length; i += 14) {
          dynamic element = jsonData["prices"][i];
          double time = element[0].toDouble();
          double price = element[1].toDouble();
          ChartLine chartData = ChartLine(
            time: time,
            price: price,
          );
          chartLine.add(chartData);
        }
      } else if (days == "30") {
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
      } else {
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

  ChartLine({required this.time, required this.price});
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

  late double _latestprice;
  late double _latesttime;

  String timespan = "1D";

  getChartLine() async {
    CryptoChartLine chartClassDay = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "1",
      interval: "minuetly",
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

    final maxchartunfinished = chartClassMax.chartLine;
    final oneyearchartunfinished = chartClassYear.chartLine;
    final onemonthchartunfinished = chartClassMonth.chartLine;
    final oneweekchartunfinished = chartClassWeek.chartLine;
    onedaychart = chartClassDay.chartLine;

    maxchart = maxchartunfinished + onedaychart;
    oneyearchart = oneyearchartunfinished + onedaychart;
    onemonthchart = onemonthchartunfinished + onedaychart;
    oneweekchart = oneweekchartunfinished + onedaychart;
    //standard current line should be onedaychart
    currentline = onedaychart;

    _latesttime = double.parse((onedaychart.last.time).toString());
    _latestprice = double.parse((onedaychart.last.price).toStringAsFixed(2));

    trackBallValuePrice = _latestprice.toString();
    trackBallValueTime = _latesttime.toString();

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
      activationMode: ActivationMode.singleTap,
      lineWidth: 2,
      lineType: TrackballLineType.horizontal,
      tooltipSettings: InteractiveTooltip(enable: false),
      markerSettings: const TrackballMarkerSettings(
          color: Colors.grey,
          borderColor: Colors.grey,
          markerVisibility: TrackballVisibilityMode.visible),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    DateFormat timeFormat = DateFormat("HH:mm");
    String date = dateFormat.format(DateTime.now());
    String timeincomp = timeFormat.format(DateTime.now());
    String timecomp = timeincomp + " Uhr";
    late double lastpriceexact = currentline.last.price;
    late double firstprice = currentline.first.price;
    late final priceChange = (lastpriceexact - firstprice) / firstprice;
    late final _priceChangeString = toPercent(priceChange);

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
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              date.toString(),
                              style: Theme.of(context).textTheme.titleSmall,
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
                              timecomp,
                              style: Theme.of(context).textTheme.titleSmall,
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
                      CustomWidget(
                        key: key,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppTheme.cardPadding * 2),
                              color: _loading
                                  ? 10 < 0
                                      ? AppTheme.successColor.withOpacity(0.625)
                                      : AppTheme.errorColor.withOpacity(0.625)
                                  : currentline[0].price <
                                          currentline[currentline.length - 1]
                                              .price
                                      ? AppTheme.successColor.withOpacity(0.625)
                                      : AppTheme.errorColor.withOpacity(0.625)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppTheme.elementSpacing * 0.75,
                                horizontal: AppTheme.elementSpacing,
                              ),
                              child: Text(
                                  _loading ? "0.00%" : _priceChangeString,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: AppTheme.white100)),
                            ),
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
                        child: avatarGlow(
                          context,
                          Icons.currency_bitcoin,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: AppTheme.cardPadding * 15,
                      child: SfCartesianChart(
                          trackballBehavior: _trackballBehavior,
                          onTrackballPositionChanging: (args) {
                            // Print the y-value of the first series in the trackball.
                            if (args.chartPointInfo.yPosition != null) {
                              final pointInfoPrice =
                                  double.parse(args.chartPointInfo.label!)
                                      .toStringAsFixed(2);
                              final pointInfoTime =
                                  double.parse(args.chartPointInfo.header!)
                                      .toString();
                              print(pointInfoTime);
                              //update for CustomWidget

                              trackBallValuePrice = pointInfoPrice;
                              key.currentState!.refresh();
                            }
                          },
                          onChartTouchInteractionUp:
                              (ChartTouchInteractionArgs args) {
                            //reset to current latest price when selection ends
                            trackBallValuePrice = _latestprice.toString();
                            key.currentState!.refresh();
                          },
                          enableAxisAnimation: true,
                          plotAreaBorderWidth: 0,
                          primaryXAxis: DateTimeAxis(
                              //labelPlacement: LabelPlacement.onTicks,
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
                            LineSeries<ChartLine, DateTime>(
                              dataSource: currentline,
                              animationDuration: 0,
                              xValueMapper: (ChartLine crypto, _) =>
                                  DateTime.fromMicrosecondsSinceEpoch(crypto.time.toInt()),
                              yValueMapper: (ChartLine crypto, _) =>
                                  crypto.price,
                              color: currentline[0].price <
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
        padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2),
        child: timespan == timeperiod
            ? Glassmorphism(
                blur: 20,
                opacity: 0.1,
                radius: 50.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.elementSpacing * 0.5,
                      horizontal: AppTheme.elementSpacing,
                    ),
                    child: Text(timeperiod,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: timespan == timeperiod
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                    .withOpacity(0.6))),
                  ),
                ),
              )
            : TextButton(
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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: timespan == timeperiod
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer
                                .withOpacity(0.6)),
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildChildTimeChooser(String timeperiod) {
    return GestureDetector(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
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
                    color: timespan == timeperiod
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer
                            .withOpacity(0.6))),
          ),
        ),
      ),
    );
  }
}

//Helper

getaverage(dynamic currentline) {
  return currentline.map((m) => m.price).reduce((a, b) => a + b) /
      currentline.length;
}

class CustomWidget extends StatefulWidget {
  final Key key;
  const CustomWidget({required this.key});

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${trackBallValuePrice}€",
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
