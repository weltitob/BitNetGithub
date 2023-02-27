import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/components/chart.dart';
import 'package:nexus_wallet/components/currencypicture.dart';
import 'package:nexus_wallet/loaders.dart';
import 'package:nexus_wallet/pages/secondpages/bitcoinscreen.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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

class _CryptoItemState extends State<CryptoItem> {
  late List<ChartLine> onedaychart;
  bool _loading = true;
  late String _currentPriceString;
  late String _priceChangeString;
  late double priceChange;

  getChartLine() async {
    CryptoChartLine chartClassDay = CryptoChartLine(
      crypto: "bitcoin",
      currency: "eur",
      days: "1",
      interval: "hourly",
    );
    await chartClassDay.getChartData();

    onedaychart = chartClassDay.chartLine;

    final double lastprice = chartClassDay.chartLine.last.price;
    final double firstprice = chartClassDay.chartLine.first.price;
    _currentPriceString = lastprice.toStringAsFixed(2) + "€";

    priceChange = (lastprice - firstprice) / firstprice;
    _priceChangeString = toPercent(priceChange);

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getChartLine();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.cardPadding),
            child: Container(
                height: AppTheme.cardPadding * 3,
                color: lighten(Theme.of(context).backgroundColor, 10,),
              child: Center(
                child: dotProgress(context),
              ),
            )
    )
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _currentPriceString,
          style: AppTheme.textTheme.bodyMedium,
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
            const SizedBox(width: 3),
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
              color: onedaychart[0].price <
                  onedaychart[onedaychart.length - 1].price
                  ? AppTheme.successColor
                  : AppTheme.errorColor,
            )
          ]),
    );
  }
}
