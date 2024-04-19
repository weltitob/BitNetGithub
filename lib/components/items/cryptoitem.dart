import 'package:bitnet/backbone/futures/cryptochartline.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/streams/bitcoinpricestream.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/container/imagewithtext.dart';

import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/bitcoinscreen.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';
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
  String _currentPriceString = "";
  String _priceChangeString = "";

  double _firstPrice = 0.0;
  double _currentPrice = 0.0;
  double _priceOneTimestampAgo = 0.0;
  double priceChange = 0.0;

  late AnimationController _controller;
  late Animation<Color?> _animation;
  bool _isBlinking = false;

  @override
  void initState() {
    super.initState();
    //final chartLine = Provider.of<ChartLine?>(context, listen: true);
    //final currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;

    getChartLine("USD");
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animation = ColorTween(begin: _animationColor, end: Colors.transparent)
        .animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isBlinking = false;
          });
          _controller.reverse();
          setState(() {
            _animation =
                ColorTween(begin: _animationColor, end: Colors.transparent)
                    .animate(_controller);
            _controller.reset();
          });
        }
      });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    final chartLine = Provider.of<ChartLine?>(context, listen: true);
    final currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    if (chartLine != null) {
      if (mounted) {
        setState(() {
          //Perform your update logic here
          _priceOneTimestampAgo = _currentPrice;
          _currentPrice = chartLine.price;
          _currentPriceString = "${chartLine.price.toStringAsFixed(2)}";
          priceChange = (_currentPrice - _firstPrice) / _firstPrice;
          _priceChangeString = toPercent(priceChange);
          colorUpdater();
          _isBlinking = true;
          _controller.forward();
        });
      }
      Logs().d("Cryptoitem (bitcoinchart) ui has been updated!");
    }
  }

  getChartLine(String currency) async {
    CryptoChartLine chartClassDay = CryptoChartLine(
      crypto: "bitcoin",
      currency: currency,
      days: "1",
    );
    CryptoChartLine chartClassDayMin = CryptoChartLine(
      crypto: "bitcoin",
      currency: currency,
      days: "1",
    );
    try {
      await chartClassDay.getChartData();
      await chartClassDayMin.getChartData();

      onedaychart = chartClassDay.chartLine;

      _currentPrice = chartClassDayMin.chartLine.last.price;
      _currentPriceString = _currentPrice.toStringAsFixed(2);
      _priceOneTimestampAgo = double.parse(_currentPrice.toStringAsFixed(2));
      _firstPrice = chartClassDayMin.chartLine.first.price;

      priceChange = (_currentPrice - _firstPrice) / _firstPrice;
      _priceChangeString = toPercent(priceChange);

      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      Logs().e("Charts could not be created for cryptoitem resulting in error" +
          e.toString());
    }
  }

  void colorUpdater() {
    setState(() {
      if (_currentPrice < _priceOneTimestampAgo) {
        _animationColor = AppTheme.errorColor;
      } else if (_currentPrice > _priceOneTimestampAgo) {
        _animationColor = AppTheme.successColor;
      } else {
        _animationColor = Colors.transparent;
      }
    });
    //update animation color
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? GestureDetector(
            onTap: () => context.push('/wallet/bitcoinscreen'),
            child: GlassContainer(
              borderThickness: 1,
              height: AppTheme.cardPadding * 3,
              borderRadius: AppTheme.cardRadiusBig,
              child: Center(
                child: dotProgress(context),
              ),
            ),
          )
        : GlassContainer(
            borderThickness: 1,
            height: AppTheme.cardPadding * 3,
            borderRadius: AppTheme.cardRadiusBig,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing),
                  child: Row(
                    children: [
                      Container(
                          height: AppTheme.cardPadding * 1.75,
                          width: AppTheme.cardPadding * 1.75,
                          child: Image.asset("assets/images/bitcoin.png")),
                      //CustomIcon(icon: currency.icon),
                      const SizedBox(width: AppTheme.elementSpacing),
                      title(),
                      const Spacer(),
                      chart(onedaychart),
                      percentageChange(),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.push('/wallet/bitcoinscreen'),
                  ),
                )
              ],
            ),
          );
  }

  Widget title() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.currency.name,
            style: Theme.of(widget.context).textTheme.titleLarge),
        price()
      ],
    );
  }

  Widget percentageChange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: AppTheme.elementSpacing * 0.75,
              width: AppTheme.elementSpacing * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500.0),
                color: Colors.grey,
              ),
            ),
            if (_isBlinking)
              Positioned.fill(
                child: AnimatedBuilder(
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
      ],
    );
  }

  Widget price() {
    //final ChartLine? bitcoinPrice = Provider.of<ChartLine?>(context, listen: true);
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // const SizedBox(width: AppTheme.elementSpacing / 2),
            Text(
              "${_currentPriceString}${getCurrency(currency)}", //bitcoinPrice!.price.toString(),
              style: AppTheme.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget chart(onedaychart) {
    return Container(
      margin: EdgeInsets.only(right: AppTheme.elementSpacing),
      width: AppTheme.cardPadding * 3.75,
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
