import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/backbone/streams/bitcoinpricestream.dart';
import 'package:nexus_wallet/components/currencypicture.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/backbone/loaders.dart';
import 'package:nexus_wallet/backbone/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:http/http.dart';

var datetime = DateTime.now();
DateFormat dateFormat = DateFormat("dd.MM.yyyy");
DateFormat timeFormat = DateFormat("HH:mm");
String inital_date = dateFormat.format(datetime);
String inital_time = timeFormat.format(datetime);
GlobalKey<_CustomWidgetState> key = GlobalKey<_CustomWidgetState>();
String trackBallValuePrice = "-----.--";
String trackBallValueTime = "${inital_time}";
String trackBallValueDate = "${inital_date}";
String trackBallValuePricechange = "+0";
Color initAnimationColor = Colors.blue;

class ChartLine {
  final double time;
  final double price;

  ChartLine({required this.time, required this.price});
}

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

  //fetch chartdatas from coingecko api
  List<ChartLine> chartLine = [];
  Future<void> getChartData() async {
    var url =
        "https://api.coingecko.com/api/v3/coins/$crypto/market_chart?vs_currency=$currency&days=$days&interval=$interval";
    Response res = await get(Uri.parse(url));
    var jsonData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      if (days == "max") {
        for (var i = 0; i < jsonData["prices"].length; i += 15) {
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

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late TrackballBehavior _trackballBehavior;
  late List<ChartLine> chartData;
  late List<ChartLine> maxchart;
  late List<ChartLine> oneyearchart;
  late List<ChartLine> onemonthchart;
  late List<ChartLine> oneweekchart;
  late List<ChartLine> onedaychart;
  late List<ChartLine> currentline;
  late bool _loading;
  late double _lastpriceinit;
  late double _firstpriceinit;
  late double _latesttimeinit;

  StreamController<ChartLine> _priceStreamController = StreamController<ChartLine>();
  String timespan = "1T";
  // Initialized the global variable
  ChartSeriesController? _chartSeriesController;

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

    final maxchartunfinished = chartClassMax.chartLine.toSet().toList();
    final oneyearchartunfinished = chartClassYear.chartLine.toSet().toList();
    final onemonthchartunfinished = chartClassMonth.chartLine.toSet().toList();
    final oneweekchartunfinished = chartClassWeek.chartLine.toSet().toList();
    onedaychart = chartClassDay.chartLine.toSet().toList();
    //get latest price from onedaychart
    List<ChartLine> onedaychartlast = [onedaychart.last];
    //add latest price to every chart
    maxchart = maxchartunfinished + onedaychartlast;
    oneyearchart = oneyearchartunfinished + onedaychartlast;
    onemonthchart = onemonthchartunfinished + onedaychartlast;
    oneweekchart = oneweekchartunfinished + onedaychartlast;
    //standard current line should be onedaychart
    currentline = onedaychart;

    _latesttimeinit = currentline.last.time;
    _lastpriceinit = double.parse((currentline.last.price).toStringAsFixed(2));
    _firstpriceinit =
        double.parse((currentline.first.price).toStringAsFixed(2));

    //for custom widget define default value
    //price
    trackBallValuePrice = _lastpriceinit.toString();
    //date
    var datetime = DateTime.fromMillisecondsSinceEpoch(
        _latesttimeinit.round(),
        isUtc: false);
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    DateFormat timeFormat = DateFormat("HH:mm");
    String date = dateFormat.format(datetime);
    String time = timeFormat.format(datetime);
    trackBallValueTime = time.toString();
    trackBallValueDate = date.toString();
    //percent
    double priceChange =
        (double.parse(_lastpriceinit.toStringAsFixed(2)) - _firstpriceinit) /
            _firstpriceinit;
    trackBallValuePricechange = toPercent(priceChange);

    setState(() {
      _loading = false;
    });
  }

  // updateChart when new data arrives
  void updateChart() {
    ChartLine newdata = onedaychart.last;
    setState(() {
      currentline.add(newdata);
      _chartSeriesController?.animate();
    });
  }

  BitcoinPriceStream _priceStream = BitcoinPriceStream();

  @override
  void initState() {
    super.initState();
    getChartLine();
    _loading = true;
    _priceStream.start();
    print('Bitcoin pricestream started');
    _priceStream.priceStream.listen((newChartLine) {
      print('pricestream changes detected...');
      key.currentState!.blinkAnimation();
    });
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
  void dispose(){
    _priceStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin:
            const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: CustomWidget(key: key)),
        Column(
          children: [
            Container(
              child: _loading
                  ? Center(
                child: Container(
                  color: AppTheme.colorBackground,
                  height: AppTheme.cardPadding * 16,
                  child: avatarGlow(
                    context,
                    Icons.currency_bitcoin,
                  ),
                ),
              )
                  : buildChart(),
            ),
          ],
        ),
        buildTimeChooser(),
      ],
    );
  }

  Widget buildChart() {
    double _lastpriceexact = currentline.last.price;
    double _lastimeeexact = currentline.last.time;
    double _lastpricerounded =
    double.parse((_lastpriceexact).toStringAsFixed(2));
    double _firstpriceexact = currentline.first.price;

    return SizedBox(
      height: AppTheme.cardPadding * 16,
      child: SfCartesianChart(
          trackballBehavior: _trackballBehavior,
          onTrackballPositionChanging: (args) {
            // Print the y-value of the first series in the trackball.
            if (args.chartPointInfo.yPosition != null) {
              final pointInfoPrice =
              double.parse(args.chartPointInfo.label!).toStringAsFixed(2);
              final pointInfoTime = double.parse(args.chartPointInfo.header!);
              var datetime = DateTime.fromMillisecondsSinceEpoch(
                  pointInfoTime.round(),
                  isUtc: false);
              DateFormat dateFormat = DateFormat("dd.MM.yyyy");
              DateFormat timeFormat = DateFormat("HH:mm");
              String date = dateFormat.format(datetime);
              String time = timeFormat.format(datetime);
              //update for CustomWidget
              trackBallValueTime = time.toString();
              trackBallValueDate = date.toString();
              trackBallValuePrice = pointInfoPrice;
              double priceChange =
                  (double.parse(trackBallValuePrice) - _firstpriceexact) /
                      _firstpriceexact;
              trackBallValuePricechange = toPercent(priceChange);
              key.currentState!.refresh();
            }
          },
          onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
            //reset to current latest price when selection ends
            trackBallValuePrice = _lastpricerounded.toString();
            //reset to percent of screen
            double priceChange =
                (_lastpriceexact - _firstpriceexact) / _firstpriceexact;
            trackBallValuePricechange = toPercent(priceChange);
            key.currentState!.refresh();
            //reset to date of last value
            var datetime = DateTime.fromMillisecondsSinceEpoch(
                _lastimeeexact.round(),
                isUtc: false);
            DateFormat dateFormat = DateFormat("dd.MM.yyyy");
            DateFormat timeFormat = DateFormat("HH:mm");
            String date = dateFormat.format(datetime);
            String time = timeFormat.format(datetime);
            trackBallValueTime = time.toString();
            trackBallValueDate = date.toString();
          },
          enableAxisAnimation: true,
          plotAreaBorderWidth: 0,
          primaryXAxis: NumericAxis(
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
            LineSeries<ChartLine, double>(
              onRendererCreated: (ChartSeriesController controller){
                _chartSeriesController = controller;
              },
              dataSource: currentline,
              animationDuration: 0,
              xValueMapper: (ChartLine crypto, _) => crypto.time,
              yValueMapper: (ChartLine crypto, _) => crypto.price,
              color: currentline[0].price <
                  currentline[currentline.length - 1].price
                  ? AppTheme.successColor
                  : AppTheme.errorColor,
            )
          ]),
    );
  }

  Widget buildTimeChooser() {
    return Container(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          glassButton(
            "1T",
          ),
          glassButton(
            "1W",
          ),
          glassButton(
            "1M",
          ),
          glassButton(
            "1J",
          ),
          glassButton(
            "Max",
          )
        ],
      ),
    );
  }

  Widget glassButton(
      String timeperiod,
      ) {
    return Padding(
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
                        ? Theme.of(context).colorScheme.onPrimaryContainer
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
            //update price widget
            switch (timespan) {
              case "1T":
                currentline = onedaychart;
                break;
              case "1W":
                currentline = oneweekchart;
                break;
              case "1M":
                currentline = onemonthchart;
                break;
              case "1J":
                currentline = oneyearchart;
                break;
              case "Max":
                currentline = maxchart;
                break;
            }
            //define for currentline
            double _lastpriceexact = currentline.last.price;
            double _lastpricerounded =
            double.parse((_lastpriceexact).toStringAsFixed(2));
            double _firstpriceexact = currentline.first.price;
            double _lastimeeexact = currentline.last.time;
            //update last price
            trackBallValuePrice = _lastpricerounded.toString();
            //update percent
            double priceChange =
                (_lastpriceexact - _firstpriceexact) / _firstpriceexact;
            trackBallValuePricechange = toPercent(priceChange);
            //update date
            var datetime = DateTime.fromMillisecondsSinceEpoch(
                _lastimeeexact.round(),
                isUtc: false);
            DateFormat dateFormat = DateFormat("dd.MM.yyyy");
            DateFormat timeFormat = DateFormat("HH:mm");
            String date = dateFormat.format(datetime);
            String time = timeFormat.format(datetime);
            trackBallValueTime = time.toString();
            trackBallValueDate = date.toString();
            //update the entire information widget
            key.currentState!.refresh();
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

class CustomWidget extends StatefulWidget {
  final Key key;

  const CustomWidget({
    required this.key,
  });

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> with SingleTickerProviderStateMixin{
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  late AnimationController _controller;
  late Animation<Color?> _animation;
  bool _isBlinking = false;

  void blinkAnimation() {
    if (mounted) {
      _controller =
          AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
      _animation = ColorTween(
          begin: initAnimationColor, end: Colors.transparent)
          .animate(_controller)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _isBlinking = false;
            });
            _controller.reverse();
          }
        });
      setState(() {
        print("Blink animation in Custom widget tiggered");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        trackBallValueDate,
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
                        "${trackBallValueTime} Uhr",
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
                Stack(
                  children: [
                    Container(
                      height: AppTheme.elementSpacing * 0.75,
                      width: AppTheme.elementSpacing * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500.0),
                        color: Colors.white10,
                      ),
                    ),
                    if (_isBlinking)
                      Positioned.fill(
                        child:  AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500.0),
                                color: _animation.value,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
                SizedBox(width: AppTheme.elementSpacing,),
                Text(
                  "${trackBallValuePrice}€",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: InkWell(
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(AppTheme.cardPadding * 2),
                        color: trackBallValuePricechange.contains("-")
                            ? AppTheme.errorColor.withOpacity(0.625)
                            : AppTheme.successColor.withOpacity(0.625)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppTheme.elementSpacing * 0.75,
                          horizontal: AppTheme.elementSpacing,
                        ),
                        child: Text(trackBallValuePricechange,
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
    );
  }
}
