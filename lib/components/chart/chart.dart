import 'dart:async';

import 'package:bitnet/backbone/futures/cryptochartline.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/bitcoin_controller.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/buttons/timechooserbutton.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timezone/timezone.dart';

// var datetime = DateTime.now();
// DateFormat dateFormat = DateFormat("dd.MM.yyyy");
// DateFormat timeFormat = DateFormat("HH:mm");
// String inital_date = dateFormat.format(datetime);
// String inital_time = timeFormat.format(datetime);
GlobalKey<_CustomWidgetState> chartInfoKey = GlobalKey<_CustomWidgetState>();
// String trackBallValuePrice = "-----.--";
// String trackBallValueTime = "${inital_time}";
// String trackBallValueDate = "${inital_date}";
// String trackBallValuePricechange = "+0";
Color initAnimationColor = Colors.blue;

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late bool _loading;
  Timer? timer;

  // late double new_lastpriceexact;
  // late double new_lastimeeexact;
  // late double new_lastpricerounded;
  // late double new_firstpriceexact;

  StreamController<ChartLine> _priceStreamController =
      StreamController<ChartLine>();

  // String selectedtimespan = "1D";

  // List<String> timespans = ["1D", "1W", "1M", "1J", "Max"];

  // // Initialized the global variable

  getChartLine(String currency) async {
    // CryptoChartLine chartClassDay = CryptoChartLine(
    //   crypto: "bitcoin",
    //   currency: currency,
    //   days: "1",
    // );
    // CryptoChartLine chartClassWeek = CryptoChartLine(
    //   crypto: "bitcoin",
    //   currency: currency,
    //   days: "7",
    // );
    // CryptoChartLine chartClassMonth = CryptoChartLine(
    //   crypto: "bitcoin",
    //   currency: currency,
    //   days: "30",
    // );
    // CryptoChartLine chartClassYear = CryptoChartLine(
    //   crypto: "bitcoin",
    //   currency: currency,
    //   days: "365",
    // );
    // CryptoChartLine chartClassMax = CryptoChartLine(
    //   crypto: "bitcoin",
    //   currency: currency,
    //   days: "max",
    // );

    // // Call getChartData for each in parallel
    // await Future.wait([
    //   chartClassDay.getChartData(),
    //   chartClassWeek.getChartData(),
    //   chartClassMonth.getChartData(),
    //   chartClassYear.getChartData(),
    //   chartClassMax.getChartData(),
    // ]);

    // if (chartClassDay.chartLine.isNotEmpty) {
    //   Get.find<CryptoItemController>().firstPrice.value =
    //       chartClassDay.chartLine.first.price;

    //   Get.find<WalletsController>().chartLines.value =
    //       chartClassDay.chartLine.last;
    // }
    // final maxchartunfinished = chartClassMax.chartLine.toSet().toList();
    // final oneyearchartunfinished = chartClassYear.chartLine.toSet().toList();
    // final onemonthchartunfinished = chartClassMonth.chartLine.toSet().toList();
    // final oneweekchartunfinished = chartClassWeek.chartLine.toSet().toList();
    // final oneweekchartfinished = chartClassDay.chartLine.toSet().toList();

    // onedaychart = chartClassDay.chartLine.toSet().toList();
    // //get latest price from onedaychart
    // List<ChartLine> onedaychartlast = [onedaychart.last];
    // //add latest price to every chart
    // maxchart = maxchartunfinished + onedaychartlast;
    // oneyearchart = oneyearchartunfinished + onedaychartlast;
    // onemonthchart = onemonthchartunfinished + onedaychartlast;
    // oneweekchart = oneweekchartunfinished + onedaychartlast;
    // //standard current line should be onedaychart
    // currentline = onedaychart;

    // _latesttimeinit = currentline.value.last.time;
    // _lastpriceinit = double.parse((currentline.value.last.price).toStringAsFixed(2));
    // _firstpriceinit =
    //     double.parse((currentline.value.first.price).toStringAsFixed(2));

    //for custom widget define default value
    //price
    // trackBallValuePrice = _lastpriceinit.toString();
    // //date
    // var datetime = DateTime.fromMillisecondsSinceEpoch(_latesttimeinit.round(),
    //     isUtc: false);
    // DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    // DateFormat timeFormat = DateFormat("HH:mm");
    // String date = dateFormat.format(datetime);
    // String time = timeFormat.format(datetime);
    // trackBallValueTime = time.toString();
    // trackBallValueDate = date.toString();
    // //percent
    // double priceChange = (currentline.value.last.price - currentline.value.first.price) /
    //     currentline.value.first.price;
    // trackBallValuePricechange = toPercent(priceChange);

    setState(() {
      _loading = false;
    });
  }

  // // updateChart when new data arrives
  // void updateChart() {
  //   ChartLine newdata = onedaychart.last;
  //   setState(() {
  //     currentline.value.add(newdata);
  //     _chartSeriesController?.animate();
  //   });
  // }

  void setValues(BitcoinController ctrler) {
    ctrler.new_lastpriceexact = ctrler.currentline.value.last.price;
    ctrler.new_lastimeeexact = ctrler.currentline.value.last.time;
    ctrler.new_lastpricerounded.value =
        double.parse((ctrler.new_lastpriceexact).toStringAsFixed(2));
    ctrler.new_firstpriceexact = ctrler.currentline.value.first.price;
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    String? currency =
        Provider.of<CurrencyChangeProvider>(Get.context!).selectedCurrency;
    BitcoinController bitcoinController = Get.find<BitcoinController>();
    currency = currency ?? "USD";
    // bitcoinController.getChartLine(currency);
    // bitcoinController.loading.listen((data) => _loading = data);
    _loading = false;

    timer = Timer.periodic(Duration(minutes: 1), periodicCleanUp);
  }

  @override
  void dispose() {
    _priceStreamController.close();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BitcoinController bitcoinController = Get.find<BitcoinController>();

    return Column(
      children: [
        Container(
            margin:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: CustomWidget(key: chartInfoKey)),
        Column(
          children: [
            Container(
              child: _loading
                  ? Center(
                      child: Container(
                        height: AppTheme.cardPadding * 16,
                        child: avatarGlow(
                          context,
                          Icons.currency_bitcoin,
                        ),
                      ),
                    )
                  : ChartCore(),
            ),
          ],
        ),
        CustomizableTimeChooser(
          timePeriods: ['1D', '1W', '1M', '1J', 'Max'],
          initialSelectedPeriod: bitcoinController.selectedtimespan.value,
          onTimePeriodSelected: (String newTimeperiod) {
            setState(() {
              bitcoinController.selectedtimespan.value = newTimeperiod;
              // Update price widget
              switch (bitcoinController.selectedtimespan.value) {
                case "1D":
                  bitcoinController.currentline.value =
                      bitcoinController.onedaychart;
                  break;
                case "1W":
                  bitcoinController.currentline.value =
                      bitcoinController.oneweekchart;
                  break;
                case "1M":
                  bitcoinController.currentline.value =
                      bitcoinController.onemonthchart;
                  break;
                case "1J":
                  bitcoinController.currentline.value =
                      bitcoinController.oneyearchart;
                  break;
                case "Max":
                  bitcoinController.currentline.value =
                      bitcoinController.maxchart;
                  break;
              }
              setValues(bitcoinController);
              // Update last price
              bitcoinController.trackBallValuePrice =
                  bitcoinController.new_lastpricerounded.toString();
              // Update percent
              double priceChange = (bitcoinController.new_lastpriceexact -
                      bitcoinController.new_firstpriceexact) /
                  bitcoinController.new_firstpriceexact;
              bitcoinController.trackBallValuePricechange =
                  toPercent(priceChange);
              // Update date
              var datetime = DateTime.fromMillisecondsSinceEpoch(
                  bitcoinController.new_lastimeeexact.round(),
                  isUtc: false);
              DateFormat dateFormat = DateFormat("dd.MM.yyyy");
              DateFormat timeFormat = DateFormat("HH:mm");
              String date = dateFormat.format(datetime);
              String time = timeFormat.format(datetime);
              bitcoinController.trackBallValueTime = datetime;
              //bitcoinController.trackBallValueDate = date.toString();
              // Update the entire information widget
              chartInfoKey.currentState!.refresh();
            });
          },
          buttonBuilder: (context, period, isSelected, onPressed) {
            return TimeChooserButton(
              timeperiod: period,
              timespan: isSelected ? period : null,
              onPressed: onPressed,
            );
          },
        ),
      ],
    );
  }

  void periodicCleanUp(Timer timer) {
    BitcoinController bitcoinController = Get.find<BitcoinController>();
    LoggerService logger = Get.find<LoggerService>();
    Duration dayDuration = Duration(days: 1);
    Duration weekDuration = Duration(days: 7);
    Duration monthDuration = Duration(days: 30);
    Duration yearDuration = Duration(days: 365);
    int amt = 0;
    while (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
                bitcoinController.onedaychart[0].time.round())) >
            dayDuration &&
        !bitcoinController.onedaychart.isEmpty) {
      bitcoinController.onedaychart.removeAt(0);
      amt++;
      if (bitcoinController.onedaychart.isEmpty) {
        break;
      }
    }
    while (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
                bitcoinController.oneweekchart[0].time.round())) >
            weekDuration &&
        !bitcoinController.oneweekchart.isEmpty) {
      bitcoinController.oneweekchart.removeAt(0);
      amt++;
      if (bitcoinController.oneweekchart.isEmpty) {
        break;
      }
    }
    while (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
                bitcoinController.onemonthchart[0].time.round())) >
            monthDuration &&
        !bitcoinController.onemonthchart.isEmpty) {
      bitcoinController.onemonthchart.removeAt(0);
      amt++;
      if (bitcoinController.onemonthchart.isEmpty) {
        break;
      }
    }
    while (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(
                bitcoinController.oneyearchart[0].time.round())) >
            yearDuration &&
        !bitcoinController.oneyearchart.isEmpty) {
      bitcoinController.oneyearchart.removeAt(0);
      amt++;
      if (bitcoinController.oneyearchart.isEmpty) {
        break;
      }
    }
    setState(() {});
    logger
        .i("cleaning up old chart-data, successfully removed: ${amt} old data");
  }
}

class ChartCore extends StatefulWidget {
  @override
  State<ChartCore> createState() => _ChartCoreState();
}

class _ChartCoreState extends State<ChartCore> {
  bool isTrackballActive = false;
  @override
  Widget build(BuildContext context) {
    BitcoinController bitcoinController = Get.find<BitcoinController>();

    return Obx(() {
      bitcoinController.liveChart.value;
      double _lastpriceexact = bitcoinController.currentline.value.isEmpty
          ? 0
          : bitcoinController.currentline.value.last.price;
      double _lastimeeexact = bitcoinController.currentline.value.isEmpty
          ? 0
          : bitcoinController.currentline.value.last.time;
      double _lastpricerounded =
          double.parse((_lastpriceexact).toStringAsFixed(2));
      double _firstpriceexact = bitcoinController.currentline.value.isEmpty
          ? 0
          : bitcoinController.currentline.value.first.price;
      if (!isTrackballActive) {
        bitcoinController.trackBallValuePrice =
            bitcoinController.new_lastpricerounded.toString();
        // Update percent
        double priceChange = (bitcoinController.new_lastpriceexact -
                bitcoinController.new_firstpriceexact) /
            bitcoinController.new_firstpriceexact;
        bitcoinController.trackBallValuePricechange = toPercent(priceChange);
        // Update date
        var datetime = DateTime.fromMillisecondsSinceEpoch(
            bitcoinController.new_lastimeeexact.round(),
            isUtc: false);
        DateFormat dateFormat = DateFormat("dd.MM.yyyy");
        DateFormat timeFormat = DateFormat("HH:mm");
        String date = dateFormat.format(datetime);
        String time = timeFormat.format(datetime);
        bitcoinController.trackBallValueTime = datetime;
        //bitcoinController.trackBallValueDate = date.toString();
        // Update the entire information widget
        WidgetsBinding.instance.addPostFrameCallback((_) {
          chartInfoKey.currentState!.refresh();
        });
      }
      return SizedBox(
        height: AppTheme.cardPadding * 16.h,
        child: Obx(
          () => SfCartesianChart(
              trackballBehavior: bitcoinController.trackballBehavior,
              onChartTouchInteractionDown: (args) {
                isTrackballActive = true;
                setState(() {});
              },
              onTrackballPositionChanging: (args) {
                // Print the y-value of the first series in the trackball.
                if (args.chartPointInfo.yPosition != null) {
                  final pointInfoPrice =
                      double.parse(args.chartPointInfo.label!)
                          .toStringAsFixed(2);
                  final pointInfoTime =
                      double.parse(args.chartPointInfo.header!);
                  var datetime = DateTime.fromMillisecondsSinceEpoch(
                      pointInfoTime.round(),
                      isUtc: false);
                  DateFormat dateFormat = DateFormat("dd.MM.yyyy");
                  DateFormat timeFormat = DateFormat("HH:mm");
                  String date = dateFormat.format(datetime);
                  String time = timeFormat.format(datetime);
                  //update for CustomWidget
                  bitcoinController.trackBallValueTime = datetime;
                  // bitcoinController.trackBallValueDate = date.toString();
                  bitcoinController.trackBallValuePrice = pointInfoPrice;
                  double priceChange =
                      (double.parse(bitcoinController.trackBallValuePrice) -
                              _firstpriceexact) /
                          _firstpriceexact;
                  bitcoinController.trackBallValuePricechange =
                      toPercent(priceChange);

                  chartInfoKey.currentState!.refresh();
                }
              },
              onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
                isTrackballActive = false;
                setState(() {});
                //reset to current latest price when selection ends
                bitcoinController.trackBallValuePrice =
                    _lastpricerounded.toString();
                //reset to percent of screen
                double priceChange =
                    (_lastpriceexact - _firstpriceexact) / _firstpriceexact;
                bitcoinController.trackBallValuePricechange =
                    toPercent(priceChange);
                chartInfoKey.currentState!.refresh();
                //reset to date of last value
                var datetime = DateTime.fromMillisecondsSinceEpoch(
                    _lastimeeexact.round(),
                    isUtc: false);
                DateFormat dateFormat = DateFormat("dd.MM.yyyy");
                DateFormat timeFormat = DateFormat("HH:mm");
                String date = dateFormat.format(datetime);
                String time = timeFormat.format(datetime);
                bitcoinController.trackBallValueTime = datetime;
                //bitcoinController.trackBallValueDate = date.toString();
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
                        start: bitcoinController.currentline.value.isEmpty
                            ? 0
                            : getaverage(bitcoinController.currentline.value),
                        end: bitcoinController.currentline.value.isEmpty
                            ? 1
                            : getaverage(bitcoinController.currentline.value),
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
                SplineSeries<ChartLine, double>(
                  onRendererCreated: (ChartSeriesController controller) {
                    bitcoinController.chartSeriesController = controller;
                  },
                  dataSource: bitcoinController.currentline.value,
                  splineType: SplineType.natural,
                  cardinalSplineTension: 0.6,
                  animationDuration: 0,
                  xValueMapper: (ChartLine crypto, _) => crypto.time,
                  yValueMapper: (ChartLine crypto, _) => crypto.price,
                  color: bitcoinController.currentline.value.isEmpty
                      ? AppTheme.black100
                      : bitcoinController.currentline.value[0].price <
                              bitcoinController
                                  .currentline
                                  .value[bitcoinController
                                          .currentline.value.length -
                                      1]
                                  .price
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                )
              ]),
        ),
      );
    });
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

class _CustomWidgetState extends State<CustomWidget>
    with SingleTickerProviderStateMixin {
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
      _controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1000));
      _animation =
          ColorTween(begin: initAnimationColor, end: Colors.transparent)
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
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;

    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    BitcoinController bitcoinController = Get.find<BitcoinController>();
    //final currencyEquivalent = bitcoinPrice != null ? (double.parse(balance) / 100000000 * bitcoinPrice).toStringAsFixed(2) : "0.00";
    Location loc = Provider.of<TimezoneProvider>(context).timeZone;
    var datetime = bitcoinController.trackBallValueTime
        .toUtc()
        .add(Duration(milliseconds: loc.currentTimeZone.offset));
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    DateFormat timeFormat = DateFormat("HH:mm");
    String date = dateFormat.format(datetime);
    String time = timeFormat.format(datetime);
    String trackTime = time.toString();
    String trackDate = date.toString();
    return Obx(() {
      Get.find<WalletsController>().chartLines.value;
      return Column(
        children: [
          Row(
            children: [
              Container(
                height: AppTheme.elementSpacing * 3.75,
                width: AppTheme.elementSpacing * 3.75,
                child: Image.asset("assets/images/bitcoin.png"),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 7.5)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bitcoin",
                            style: Theme.of(context).textTheme.headlineMedium),
                        Text(
                          trackDate,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "BTC",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          trackTime,
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
                  // Stack(
                  //   children: [
                  //     Container(
                  //       height: AppTheme.elementSpacing * 0.75,
                  //       width: AppTheme.elementSpacing * 0.75,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(500.0),
                  //         color: Colors.white10,
                  //       ),
                  //     ),
                  //     if (_isBlinking)
                  //       Positioned.fill(
                  //         child:  AnimatedBuilder(
                  //           animation: _animation,
                  //           builder: (context, child) {
                  //             return Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(500.0),
                  //                 color: _animation.value,
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //   ],
                  // ),
                  // SizedBox(width: AppTheme.elementSpacing,),
                  Text(
                    "${bitcoinController.trackBallValuePrice}${getCurrency(currency!)}",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
              BitNetPercentWidget(
                  priceChange: bitcoinController.trackBallValuePricechange),
            ],
          ),
        ],
      );
    });
  }
}

class BitNetPercentWidget extends StatelessWidget {
  final String priceChange;

  const BitNetPercentWidget({super.key, required this.priceChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: AppTheme.elementSpacing,
        bottom: AppTheme.elementSpacing,
      ),
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: AppTheme.cardRadiusSmall,
            color: priceChange.contains("-")
                ? AppTheme.errorColor
                : AppTheme.successColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppTheme.elementSpacing * 0.625,
                horizontal: AppTheme.elementSpacing,
              ),
              child: Text(
                priceChange,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: priceChange.contains("-")
                          ? darken(AppTheme.errorColor, 90)
                          : darken(AppTheme.successColor, 90),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
