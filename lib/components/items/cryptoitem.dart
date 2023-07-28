import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/backbone/streams/bitcoinpricestream.dart';
import 'package:BitNet/backbone/streams/cryptochartline.dart';
import 'package:BitNet/components/chart/chart.dart';
import 'package:BitNet/components/container/currencypicture.dart';
import 'package:BitNet/components/loaders/loaders.dart';
import 'package:BitNet/pages/secondpages/bitcoinscreen.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Currency {
  final String code;
  final String name;
  final Image icon;

  Currency({
    required this.code,
    required this.name,
    required this.icon,
  });
}

class MockFavorites {
  static final data = [
    Currency(
      code: 'BTC',
      name: 'Bitcoin',
      icon: Image.asset('assets/images/ada_icon.png'),
    ),
  ];
}

class CryptoItem extends StatefulWidget {
  final Currency currency;
  final BuildContext context;

  const CryptoItem({
    Key? key,
    required this.currency,
    required this.context,
  }) : super(key: key);

  @override
  State<CryptoItem> createState() => _CryptoItemState();
}

class _CryptoItemState extends State<CryptoItem>
    with SingleTickerProviderStateMixin {
  late List<ChartLine> onedaychart;
  bool _loading = true;
  Color _animationColor = Colors.transparent;
  late String _currentPriceString;
  late String _priceChangeString;

  late double _firstPrice;
  late double _currentPrice;
  late double _priceOneTimestampAgo;
  late double priceChange;

  getChartLine() async {
    CryptoChartLine chartClassDay = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "1",
      interval: "hourly",
    );
    CryptoChartLine chartClassDayMin = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "1",
      interval: "minuetly",
    );

    await chartClassDay.getChartData();
    await chartClassDayMin.getChartData();

    onedaychart = chartClassDay.chartLine;

    _currentPrice = chartClassDayMin.chartLine.last.price;
    _currentPriceString = _currentPrice.toStringAsFixed(2) + "€";
    _priceOneTimestampAgo = double.parse(_currentPrice.toStringAsFixed(2));
    _firstPrice = chartClassDayMin.chartLine.first.price;

    priceChange = (_currentPrice - _firstPrice) / _firstPrice;
    _priceChangeString = toPercent(priceChange);

    setState(() {
      _loading = false;
    });
  }

  late AnimationController _controller;
  late Animation<Color?> _animation;
  bool _isBlinking = false;

  BitcoinPriceStream _priceStream = BitcoinPriceStream();

  void colorUpdater() {
    setState(() {
      if (_currentPrice < _priceOneTimestampAgo) {
        _animationColor = AppTheme.errorColor;
      }
      else if (_currentPrice > _priceOneTimestampAgo) {
        _animationColor = AppTheme.successColor;
      }
      else {
        _animationColor = Colors.transparent;
      }
    });
    //update animation color
  }

  @override
  void initState() {
    super.initState();
    getChartLine();
    // _priceStream.start();
    // _controller =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    // _animation = ColorTween(
    //     begin: _animationColor, end: Colors.transparent)
    //     .animate(_controller)
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       setState(() {
    //         _isBlinking = false;
    //       });
    //       _controller.reverse();
    //       setState(() {
    //         _animation = ColorTween(begin: _animationColor, end: Colors.transparent)
    //             .animate(_controller);
    //         _controller.reset();
    //       });
    //     }
    //   });
    // _priceStream.priceStream.listen((newChartLine) {
    //   setState(() {
    //     //vor dem updaten preis erstmal speichern
    //     _priceOneTimestampAgo = _currentPrice;
    //     print("Preis vor update: $_priceOneTimestampAgo");
    //     //neuen preis anzeigen lassen
    //     _currentPrice = newChartLine.price;
    //     print("Preis nach update: $_currentPrice");
    //     _currentPriceString = newChartLine.price.toStringAsFixed(2) + "€";
    //     //auch prozentanzeige updaten
    //     priceChange = (_currentPrice - _firstPrice) / _firstPrice;
    //     _priceChangeString = toPercent(priceChange);
    //     //blinken
    //     colorUpdater();
    //     _isBlinking = true;
    //   });
    //   _controller.forward();
    // });
  }

  @override
  void dispose() {
    _priceStream.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.cardPadding),
            child: Container(
              height: AppTheme.cardPadding * 3,
              color: lighten(
                Theme.of(context).backgroundColor,
                10,
              ),
              child: Center(
                child: dotProgress(context),
              ),
            ))
        : ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.cardPadding),
            child: Container(
              height: AppTheme.cardPadding * 3,
              color: lighten(Theme.of(context).backgroundColor, 10),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing),
                    child: Row(
                      children: [
                        currencyPicture(context),
                        //CustomIcon(icon: currency.icon),
                        const SizedBox(width: AppTheme.elementSpacing),
                        title(),
                        const Spacer(),
                        chart(onedaychart),
                        price(),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BitcoinScreen(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget title() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.currency.code,
          style: Theme.of(widget.context).textTheme.titleSmall,
        ),
        Text(widget.currency.name,
            style: Theme.of(widget.context).textTheme.titleLarge),
      ],
    );
  }

  Widget price() {
    final ChartLine? bitcoinPrice = Provider.of<ChartLine?>(context);
    print(bitcoinPrice);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
            // const SizedBox(width: AppTheme.elementSpacing / 2),
            Text(
              _currentPriceString,
              style: AppTheme.textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              priceChange >= 0
                  ? FontAwesomeIcons.caretUp
                  : FontAwesomeIcons.caretDown,
              size: 16,
              color: priceChange >= 0
                  ? AppTheme.successColor
                  : AppTheme.errorColor,
            ),
            const SizedBox(width: AppTheme.elementSpacing / 4),
            Text(
              _priceChangeString,
              style: TextStyle(
                color: priceChange >= 0
                    ? AppTheme.successColor
                    : AppTheme.errorColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget chart(onedaychart) {
    return Container(
      margin: EdgeInsets.only(right: AppTheme.elementSpacing),
      width: AppTheme.cardPadding * 4,
      color: Colors.transparent,
      child: SfCartesianChart(
          enableAxisAnimation: true,
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
              labelPlacement: LabelPlacement.onTicks,
              edgeLabelPlacement: EdgeLabelPlacement.none,
              isVisible: false,
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(width: 0)),
          primaryYAxis: NumericAxis(
              plotOffset: 0,
              edgeLabelPlacement: EdgeLabelPlacement.none,
              isVisible: false,
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(width: 0)),
          series: <ChartSeries>[
            // Renders line chart
            LineSeries<ChartLine, double>(
              dataSource: onedaychart,
              animationDuration: 0,
              xValueMapper: (ChartLine crypto, _) => crypto.time,
              yValueMapper: (ChartLine crypto, _) => crypto.price,
              color: priceChange >= 0
                  ? AppTheme.successColor
                  : AppTheme.errorColor,
            )
          ]),
    );
  }
}
