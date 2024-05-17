import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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

class _CryptoItemState extends State<CryptoItem> {
  final controllerCrypto = Get.find<CryptoItemController>();

  void didChangeDependencies() {
    super.didChangeDependencies();
    final chartLine = Provider.of<ChartLine?>(context, listen: true);
    final currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    if (chartLine != null) {
      controllerCrypto.priceOneTimestampAgo = controllerCrypto.currentPrice;
      controllerCrypto.currentPrice.value = chartLine.price;
      controllerCrypto.currentPriceString.value =
          "${chartLine.price.toStringAsFixed(2)}";
      controllerCrypto.priceChange.value =
          (controllerCrypto.currentPrice.value -
                  controllerCrypto.firstPrice.value) /
              controllerCrypto.firstPrice.value;
      controllerCrypto.priceChangeString.value =
          toPercent(controllerCrypto.priceChange.value);
      controllerCrypto.colorUpdater();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controllerCrypto.isBlinking.value = true;
      controllerCrypto.controller.forward();
      Logs().d("Cryptoitem (bitcoinchart) ui has been updated!");

       });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controllerCrypto.loading.value
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
                      chart(controllerCrypto.onedaychart),
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
          )
 ); }

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
              controllerCrypto.priceChange.value >= 0
                  ? FontAwesomeIcons.caretUp
                  : FontAwesomeIcons.caretDown,
              size: 16,
              color: controllerCrypto.priceChange.value >= 0
                  ? AppTheme.successColor
                  : AppTheme.errorColor,
            ),
            const SizedBox(width: AppTheme.elementSpacing / 4),
            Text(
              controllerCrypto.priceChangeString.value,
              style: TextStyle(
                color: controllerCrypto.priceChange.value >= 0
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
            if (controllerCrypto.isBlinking.value)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: controllerCrypto.animation,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500.0),
                        color: controllerCrypto.animation.value,
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
              "${controllerCrypto.currentPriceString}${getCurrency(currency)}", //bitcoinPrice!.price.toString(),
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
              color: controllerCrypto.priceChange >= 0
                  ? AppTheme.successColor
                  : AppTheme.errorColor,
            )
          ]),
    );
  }
}
