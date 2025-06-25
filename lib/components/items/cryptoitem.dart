import 'dart:async';

import 'package:bitnet/backbone/helper/currency/getcurrency.dart';

import 'package:bitnet/backbone/helper/helpers.dart';

import 'package:bitnet/backbone/helper/theme/theme.dart';

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';

import 'package:bitnet/backbone/streams/currency_provider.dart';

import 'package:bitnet/components/appstandards/glasscontainer.dart';

import 'package:bitnet/components/items/crypto_item_controller.dart';

import 'package:bitnet/components/items/percentagechange_widget.dart';

import 'package:bitnet/models/bitcoin/chartline.dart';

import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import 'package:go_router/go_router.dart';

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

  final bool hasGlassContainer; // New bool added
  final List<ChartLine>? tokenChartData; // Token-specific chart data
  final String? tokenPrice; // Token-specific price
  final String? tokenPriceChange; // Token-specific price change
  final bool? tokenIsPositive; // Token-specific positive/negative change

  const CryptoItem({
    Key? key,
    required this.currency,
    required this.context,
    this.hasGlassContainer = true, // Default is true
    this.tokenChartData,
    this.tokenPrice,
    this.tokenPriceChange,
    this.tokenIsPositive,
  }) : super(key: key);

  @override
  State<CryptoItem> createState() => _CryptoItemState();
}

class _CryptoItemState extends State<CryptoItem> {
  final controllerCrypto = Get.find<CryptoItemController>();

  final LoggerService logger = Get.find();

  StreamSubscription? _chartLinesSubscription;
  WalletsController? _walletsController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // Initialize the controller before any usage
    try {
      _walletsController = Get.find<WalletsController>();
      _isInitialized = true;
    } catch (e) {
      logger.e("WalletsController not found: $e");
      _isInitialized = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Only proceed if controller is initialized
    if (!_isInitialized || _walletsController == null) {
      return;
    }

    updateChart();

    // Cancel previous subscription if exists
    _chartLinesSubscription?.cancel();

    // Create new subscription
    _chartLinesSubscription = _walletsController!.chartLines.listen((a) {
      logger.i("updated chart");

      updateChart();

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _chartLinesSubscription?.cancel();
    super.dispose();
  }

  void updateChart() {
    if (_walletsController == null) return;

    final chartLine = _walletsController!.chartLines.value;

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

        logger.d("Cryptoitem (bitcoinchart) ui has been updated!");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GlassContainer(
          opacity: widget.hasGlassContainer ? 0.1 : 0.0,
          height: AppTheme.cardPadding * 2.75,
          borderRadius: AppTheme.cardPadding * 2.75 / 3,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: AppTheme.cardPadding * 1.75,
                            width: AppTheme.cardPadding * 1.75,
                            child: ClipOval(child: widget.currency.icon)),
                        SizedBox(width: AppTheme.elementSpacing.w / 1.5),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.currency.name,
                                style: Theme.of(widget.context)
                                    .textTheme
                                    .titleLarge),
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: AppTheme.elementSpacing * 0.75,
                                      width: AppTheme.elementSpacing * 0.75,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(500.0),
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        500.0),
                                                color: controllerCrypto
                                                    .animation.value,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 4),
                                price(),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: AppTheme.elementSpacing.w / 2),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: RepaintBoundary(
                          child: SfCartesianChart(
                              enableAxisAnimation: true,
                              plotAreaBorderWidth: 0,
                              primaryXAxis: CategoryAxis(
                                  labelPlacement: LabelPlacement.onTicks,
                                  edgeLabelPlacement: EdgeLabelPlacement.none,
                                  isVisible: false,
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  majorTickLines:
                                      const MajorTickLines(width: 0)),
                              primaryYAxis: NumericAxis(
                                  plotOffset: 0,
                                  edgeLabelPlacement: EdgeLabelPlacement.none,
                                  isVisible: false,
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  majorTickLines:
                                      const MajorTickLines(width: 0)),
                              series: <ChartSeries>[
                                LineSeries<ChartLine, double>(
                                  dataSource: widget.tokenChartData ??
                                      controllerCrypto.onedaychart,
                                  animationDuration: 0,
                                  xValueMapper: (ChartLine crypto, _) =>
                                      crypto.time,
                                  yValueMapper: (ChartLine crypto, _) =>
                                      crypto.price,
                                  color: (widget.tokenIsPositive ??
                                          (controllerCrypto.priceChange >= 0))
                                      ? AppTheme.successColor
                                      : AppTheme.errorColor,
                                )
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(width: AppTheme.elementSpacing.w / 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Using reusable PercentageChangeWidget component

                        PercentageChangeWidget(
                          percentage: widget.tokenPriceChange ??
                              controllerCrypto.priceChangeString.value,
                          isPositive: widget.tokenIsPositive ??
                              (controllerCrypto.priceChange.value >= 0),
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Check if this is a token (not Bitcoin)
                    if (widget.currency.code != 'BTC' &&
                        widget.tokenChartData != null) {
                      // Create tokenData structure for navigation
                      final tokenData = {
                        'tokenSymbol': widget.currency.code,
                        'tokenName': widget.currency.name,
                        'currentPrice': double.tryParse(
                                widget.tokenPrice?.replaceAll(',', '') ??
                                    '0') ??
                            0.0,
                        'priceHistory': {
                          '1D': widget.tokenChartData!
                              .map((chartLine) => {
                                    'time': chartLine.time,
                                    'price': chartLine.price,
                                  })
                              .toList(),
                          '1W': widget.tokenChartData!
                              .map((chartLine) => {
                                    'time': chartLine.time,
                                    'price': chartLine.price,
                                  })
                              .toList(),
                          '1M': widget.tokenChartData!
                              .map((chartLine) => {
                                    'time': chartLine.time,
                                    'price': chartLine.price,
                                  })
                              .toList(),
                          '1J': widget.tokenChartData!
                              .map((chartLine) => {
                                    'time': chartLine.time,
                                    'price': chartLine.price,
                                  })
                              .toList(),
                          'Max': widget.tokenChartData!
                              .map((chartLine) => {
                                    'time': chartLine.time,
                                    'price': chartLine.price,
                                  })
                              .toList(),
                        },
                      };
                      context.push('/wallet/bitcoinscreen', extra: tokenData);
                    } else {
                      // For Bitcoin, navigate without tokenData
                      context.push('/wallet/bitcoinscreen');
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget price() {
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;

    currency = currency ?? "USD";

    return Obx(() {
      _walletsController?.chartLines.value;

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${widget.tokenPrice ?? controllerCrypto.currentPriceString}${getCurrency(currency!)}",
                style: (widget.tokenPrice ??
                                controllerCrypto.currentPriceString.value)
                            .length >
                        8
                    ? AppTheme.textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppTheme.black60
                            : AppTheme.white60)
                    : AppTheme.textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppTheme.black60
                            : AppTheme.white60),
              ),
            ],
          ),
        ],
      );
    });
  }
}
