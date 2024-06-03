import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

GlobalKey<_HashRealTimeValuesState> hashKey =
    GlobalKey<_HashRealTimeValuesState>();
String hashTrackBallValuePrice = "-----.--";
String hashTrackBallValueTime = "${inital_time}";
String hashTrackBallValueDate = "${inital_date}";
String hashTrackBallValuePricechange = "+0";

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
    chartData = widget.chartData;
    print('ab ${widget.difficulty.length}');
    double _lastpriceexact =
        chartData.isEmpty ? 1 : chartData[chartData.length - 1].price;
    double _lastimeeexact =
        chartData.isEmpty ? 1 : chartData[chartData.length - 1].time;
    double _lastpricerounded =
        double.parse(_lastpriceexact.toString().substring(0, 2)) / 10;
    // double.parse((_lastpriceexact).toStringAsFixed(2))/1000000000000000000;
    double _firstpriceexact = chartData.isEmpty ? 0 : chartData[0].price;
    hashTrackBallValuePrice = _lastpricerounded.toString();
    var datetime = DateTime.fromMillisecondsSinceEpoch(
        (_lastimeeexact * 1000).round(),
        isUtc: false);
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");

    String date = dateFormat.format(datetime);
    hashTrackBallValueDate = date.toString();
    DateFormat timeFormat = DateFormat("HH:mm");
    String time = timeFormat.format(datetime);

    hashTrackBallValueTime = time.toString();

    return Column(
      children: [
        Container(
            margin:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: HashRealTimeValues(key: hashKey)),
        Divider(indent: 16, endIndent: 16),
        SizedBox(
          height: AppTheme.cardPadding * 16,
          child: SfCartesianChart(
              trackballBehavior: _trackballBehavior,
              onTrackballPositionChanging: (args) {
                // Print the y-value of the first series in the trackball.
                if (args.chartPointInfo.yPosition != null) {
                  final pointInfoPrice = args.chartPointInfo.label!;
                  //final pointInfoTime = double.parse(args.chartPointInfo.header!);

                  //update for CustomWidget
                  var datetime = DateTime.fromMillisecondsSinceEpoch(
                      (chartData[args.chartPointInfo.dataPointIndex!].time *
                              1000)
                          .round(),
                      isUtc: false);
                  DateFormat dateFormat = DateFormat("dd.MM.yyyy");
                  DateFormat timeFormat = DateFormat("HH:mm");
                  String time = timeFormat.format(datetime);
                  print(time);

                  hashTrackBallValueTime = time.toString();

                  String date = dateFormat.format(datetime);
                  hashTrackBallValueDate = date.toString();
                  hashTrackBallValuePrice = pointInfoPrice.replaceAll('K', '');
                  double priceChange = (double.parse(hashTrackBallValuePrice) -
                          _firstpriceexact) /
                      _firstpriceexact;
                  hashTrackBallValuePricechange = toPercent(priceChange);
                  hashKey.currentState!.refresh();
                }
              },
              onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
                //reset to current latest price when selection ends
                hashTrackBallValuePrice = _lastpricerounded.toString();
                //reset to percent of screen
                double priceChange =
                    (_lastpriceexact - _firstpriceexact) / _firstpriceexact;
                hashTrackBallValuePricechange = toPercent(priceChange);
                hashKey.currentState!.refresh();

                //key.currentState!.refresh();
                //reset to date of last value
                var datetime = DateTime.fromMillisecondsSinceEpoch(
                    (_lastimeeexact * 1000).round(),
                    isUtc: false);
                DateFormat dateFormat = DateFormat("dd.MM.yyyy");
                DateFormat timeFormat = DateFormat("HH:mm");
                String time = timeFormat.format(datetime);

                String date = dateFormat.format(datetime);
                hashTrackBallValueDate = date.toString();
                hashTrackBallValueTime = time.toString();
              },
              plotAreaBorderWidth: 0,
              enableAxisAnimation: true,
              primaryXAxis: DateTimeAxis(
                intervalType: DateTimeIntervalType.days,
                edgeLabelPlacement: EdgeLabelPlacement.none,
                isVisible: false,
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                axisLine: AxisLine(width: 0),
                plotOffset: 0,
                edgeLabelPlacement: EdgeLabelPlacement.none,
                isVisible: false,
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                numberFormat: NumberFormat.compact(),
              ),
              series: <CartesianSeries>[
                SplineSeries<ChartLine, DateTime>(
                  name: L10n.of(context)!.hashrate,
                  enableTooltip: true,
                  dataSource: widget.chartData,
                  splineType: SplineType.cardinal,
                  cardinalSplineTension: 0.7,
                  xValueMapper: (ChartLine sales, _) =>
                      DateTime.fromMillisecondsSinceEpoch(
                          sales.time.toInt() * 1000,
                          isUtc: true),
                  yValueMapper: (ChartLine sales, _) =>
                      double.parse(sales.price.toString().substring(0, 4)),
                ),
                SplineSeries<Difficulty, DateTime>(
                  name: L10n.of(context)!.difficulty,
                  enableTooltip: true,
                  splineType: SplineType.cardinal,
                  cardinalSplineTension: 0.3,
                  dataSource: widget.difficulty,
                  xValueMapper: (Difficulty sales, _) =>
                      DateTime.fromMillisecondsSinceEpoch(
                          sales.time!.toInt() * 1000,
                          isUtc: true),
                  yValueMapper: (Difficulty sales, _) => double.parse(
                      (sales.difficulty! / 10000000000)
                          .toStringAsFixed(2)), // Assuming price is double type
                ),
              ]),
        ),
      ],
    );
  }
}

class HashRealTimeValues extends StatefulWidget {
  final Key key;

  const HashRealTimeValues({
    required this.key,
  });

  @override
  State<HashRealTimeValues> createState() => _HashRealTimeValuesState();
}

class _HashRealTimeValuesState extends State<HashRealTimeValues>
    with SingleTickerProviderStateMixin {
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  late AnimationController _hashController;
  late Animation<Color?> _hashAnimation;
  bool _hashIsBlinking = false;

  void blinkAnimation() {
    if (mounted) {
      _hashController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 1000));
      _hashAnimation =
          ColorTween(begin: initAnimationColor, end: Colors.transparent)
              .animate(_hashController)
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                setState(() {
                  _hashIsBlinking = false;
                });
                _hashController.reverse();
              }
            });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${hashTrackBallValuePrice}K",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            Text(
              hashTrackBallValueDate,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ],
    );
  }
}
