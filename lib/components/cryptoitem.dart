import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/chart.dart';
import 'package:nexus_wallet/components/currencypicture.dart';
import 'package:nexus_wallet/pages/secondpages/bitcoinscreen.dart';
import 'package:nexus_wallet/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Currency {
  final String code;
  final String name;
  final Image icon;
  final double currentAmount;
  final double profit;
  final List<double> priceHistory;
  final List<Trade> tradeHistory;

  Currency({
    required this.code,
    required this.name,
    required this.icon,
    required this.priceHistory,
    this.currentAmount = 0.0,
    this.profit = 0.0,
    this.tradeHistory = const [],
  });

  String get usdAmountString =>
      NumberFormat.simpleCurrency().format(currentAmount * priceHistory.last);

  String _toPercent(double value) =>
      NumberFormat('+#.##%; -#.##%').format(value);

  String get profitString => _toPercent(profit);

  String get currentPriceString =>
      NumberFormat.simpleCurrency().format(priceHistory.last);

  double get priceChange =>
      (priceHistory.last - priceHistory.first) / priceHistory.first;

  String get priceChangeString => _toPercent(priceChange);
}


enum TradeDirection {
  buy,
  sell,
}

class Trade {
  final TradeDirection tradeDirection;
  final String date;
  final double amount;

  Trade({
    required this.tradeDirection,
    required this.date,
    required this.amount,
  });

  String get dateFormatted =>
      DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd').parse(date));

  String get amountString {
    final amountSign = tradeDirection == TradeDirection.buy ? '+' : '-';

    return '$amountSign${NumberFormat('#,###.####').format(amount)}';
  }
}

class MockFavorites {
  static final data = [
    Currency(
      code: 'BTC',
      name: 'Bitcoin',
      icon: Image.asset('assets/images/ada_icon.png'),
      priceHistory: [
        0.52543,
        0.51538,
        0.51715,
        0.52900,
        0.53250,
        0.53423,
        0.52864,
        0.52598,
        0.52986,
        0.53392,
        0.54404,
        0.52392,
        0.51803,
        0.52535,
        0.53479,
        0.53129,
        0.52307,
        0.51462,
        0.52479,
        33333.52220,
        50000.52730,
        40000.52730,
        22203.53318,
        200.53318,
      ],
      tradeHistory: [
        Trade(
          tradeDirection: TradeDirection.sell,
          date: '2022-05-22',
          amount: 850,
        ),
        Trade(
          tradeDirection: TradeDirection.buy,
          date: '2022-04-19',
          amount: 350,
        ),
        Trade(
          tradeDirection: TradeDirection.buy,
          date: '2022-04-14',
          amount: 500,
        ),
      ],
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

  late bool _loading;

  getChartLine() async {
    CryptoChartLine chartClassDay = CryptoChartLine(
      crypto: "bitcoin",
      currency: "usd",
      days: "1",
      interval: "hourly",
    );
    await chartClassDay.getChartData();

    onedaychart = chartClassDay.chartLine;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    getChartLine();
  }

  Widget title() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.currency.code,
          style: Theme.of(widget.context).textTheme.subtitle2,
        ),
        Text(
          widget.currency.name,
          style: Theme.of(widget.context).textTheme.headline6
        ),
      ],
    );
  }

  Widget price() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.currency.currentPriceString,
          style: AppTheme.textTheme.bodyText2,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              widget.currency.priceChange >= 0
                  ? FontAwesomeIcons.caretUp
                  : FontAwesomeIcons.caretDown,
              size: 16,
              color: AppTheme.successColor,
            ),
            const SizedBox(width: 3),
            Text(
              widget.currency.priceChangeString,
              style: const TextStyle(
                color: AppTheme.successColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget chart(onedaychart){
    return Container(
      width: 95,
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
              color: AppTheme.successColor,
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.cardPadding),
      child: Container(
        height: AppTheme.cardPadding * 3,
        color: lighten(Theme.of(context).backgroundColor, 10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
              child: Row(
                children: [
                  currencyPicture(context),
                  //CustomIcon(icon: currency.icon),
                  const SizedBox(width: AppTheme.elementSpacing),
                  title(),
                  const Spacer(),
                  _loading ? Container() : chart(onedaychart),
                  price(),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                const BitcoinScreen(),
              ),
            ),),
            )
          ],
        ),
      ),
    );
  }
}