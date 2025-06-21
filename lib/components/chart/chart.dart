import 'dart:async';

import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/bitcoin_controller.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/buttons/timechooserbutton.dart';
import 'package:bitnet/components/items/percentagechange_widget.dart';
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
import 'package:bitnet/components/items/colored_price_widget.dart';

Color initAnimationColor = Colors.blue;

class ChartWidget extends StatefulWidget {
  final Map<String, dynamic>? tokenData;
  
  const ChartWidget({
    Key? key,
    this.tokenData,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late bool _loading;
  Timer? timer;
  final GlobalKey<_CustomWidgetState> chartInfoKey = GlobalKey<_CustomWidgetState>();
  final GlobalKey<_ChartCoreState> chartCoreKey = GlobalKey<_ChartCoreState>();

  StreamController<ChartLine> _priceStreamController =
      StreamController<ChartLine>();

  getChartLine(String currency) async {
    setState(() {
      _loading = false;
    });
  }

  void setValues(BitcoinController ctrler) {
    // Check if the currentline is empty before accessing elements
    if (ctrler.currentline.value.isEmpty) {
      // Set default values when no data is available
      ctrler.new_lastpriceexact = 0;
      ctrler.new_lastimeeexact =
          DateTime.now().millisecondsSinceEpoch.toDouble();
      ctrler.new_lastpricerounded.value = 0;
      ctrler.new_firstpriceexact = 0;
      return;
    }

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
    
    // For tokens, skip the loading check
    if (widget.tokenData != null) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: AppTheme.cardPadding),
            child: CustomWidget(
              key: chartInfoKey,
              tokenData: widget.tokenData,
            ),
          ),
          Column(
            children: [
              Container(
                child: RepaintBoundary(
                  child: ChartCore(
                    key: chartCoreKey,
                    chartInfoKey: chartInfoKey,
                    tokenData: widget.tokenData,
                  ),
                ),
              ),
            ],
          ),
          // Time chooser for tokens
          CustomizableTimeChooser(
            timePeriods: ['1D', '1W', '1M', '1J', 'Max'],
            initialSelectedPeriod: '1D',
            onTimePeriodSelected: (String newTimeperiod) {
              // Update ChartCore's selected period
              chartCoreKey.currentState?.updateSelectedPeriod(newTimeperiod);
            },
            buttonBuilder: (context, period, isSelected, onPressed) {
              return TimeChooserButton(
                timeperiod: period,
                timespan: period,
                onPressed: onPressed,
              );
            },
          ),
        ],
      );
    }
    
    // Bitcoin chart
    return Obx(() {
      return bitcoinController.loading.value
          ? dotProgress(context)
          : Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
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
                          : RepaintBoundary(child: ChartCore(
                              chartInfoKey: chartInfoKey,
                              tokenData: widget.tokenData,
                            )),
                    ),
                  ],
                ),
                CustomizableTimeChooser(
                  timePeriods: ['1D', '1W', '1M', '1J', 'Max'],
                  initialSelectedPeriod:
                      bitcoinController.selectedtimespan.value,
                  onTimePeriodSelected: (String newTimeperiod) {
                    setState(() {
                      bitcoinController.selectedtimespan.value = newTimeperiod;
                      // Update price widget
                      // Safely switch to the selected timespan
                      try {
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
                      } catch (e) {
                        // If any error occurs, set to empty list to prevent crashing
                        print("Error switching timespan: $e");
                        bitcoinController.currentline.value = [];
                      }
                      setValues(bitcoinController);
                      // Update last price
                      bitcoinController.trackBallValuePrice =
                          bitcoinController.new_lastpricerounded.toString();
                      // Update percent
                      double priceChange =
                          bitcoinController.new_firstpriceexact == 0
                              ? 0
                              : (bitcoinController.new_lastpriceexact -
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
    });
  }

  void periodicCleanUp(Timer timer) {
    BitcoinController bitcoinController = Get.find<BitcoinController>();
    LoggerService logger = Get.find<LoggerService>();
    Duration dayDuration = Duration(days: 1);
    Duration weekDuration = Duration(days: 7);
    Duration monthDuration = Duration(days: 30);
    Duration yearDuration = Duration(days: 365);
    int amt = 0;

    // Check if arrays are empty before processing
    if (!bitcoinController.onedaychart.isEmpty) {
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
    }

    if (!bitcoinController.oneweekchart.isEmpty) {
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
    }

    if (!bitcoinController.onemonthchart.isEmpty) {
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
    }

    if (!bitcoinController.oneyearchart.isEmpty) {
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
    }

    setState(() {});
    logger
        .i("cleaning up old chart-data, successfully removed: ${amt} old data");
  }
}

class ChartCore extends StatefulWidget {
  final GlobalKey<_CustomWidgetState> chartInfoKey;
  final Map<String, dynamic>? tokenData;
  
  const ChartCore({
    Key? key, 
    required this.chartInfoKey,
    this.tokenData,
  }) : super(key: key);
  
  @override
  State<ChartCore> createState() => _ChartCoreState();
}

class _ChartCoreState extends State<ChartCore> {
  bool isTrackballActive = false;
  String selectedPeriod = '1D';
  
  void updateSelectedPeriod(String period) {
    setState(() {
      selectedPeriod = period;
    });
  }
  
  Widget _buildTokenChart(BuildContext context) {
    // Get token data
    final priceHistory = widget.tokenData!['priceHistory'] as Map<String, dynamic>;
    final currentPrice = widget.tokenData!['currentPrice'];
    final tokenSymbol = widget.tokenData!['tokenSymbol'];
    
    // Get data for selected period
    final periodData = priceHistory[selectedPeriod] as List<Map<String, dynamic>>;
    
    // Convert to ChartLine format
    final chartData = periodData.map((point) {
      return ChartLine(
        time: (point['time'] is int) ? (point['time'] as int).toDouble() : (point['time'] as double),
        price: double.parse(point['price'].toString()),
      );
    }).toList();
    
    // Calculate price changes
    final firstPrice = chartData.isNotEmpty ? chartData.first.price : currentPrice;
    final lastPrice = chartData.isNotEmpty ? chartData.last.price : currentPrice;
    final priceChange = firstPrice == 0 ? 0 : (lastPrice - firstPrice) / firstPrice;
    
    // Create trackball behavior with proper callbacks
    final trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      tooltipSettings: InteractiveTooltip(
        enable: false, // Disable tooltip since we update the header
      ),
      hideDelay: 1000,
      lineType: TrackballLineType.vertical,
      lineColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
      markerSettings: TrackballMarkerSettings(
        markerVisibility: TrackballVisibilityMode.visible,
        height: 8,
        width: 8,
        color: priceChange >= 0 ? AppTheme.successColor : AppTheme.errorColor,
        borderWidth: 2,
        borderColor: Colors.white,
      ),
    );
    
    // Use the SAME chart UI as Bitcoin
    return SizedBox(
      height: AppTheme.cardPadding * 16.h,
      child: SfCartesianChart(
        trackballBehavior: trackballBehavior,
        onChartTouchInteractionDown: (args) {
          isTrackballActive = true;
          setState(() {});
        },
        onTrackballPositionChanging: (args) {
          // Update price display when hovering
          if (args.chartPointInfo.yPosition != null) {
            final pointInfoPrice = double.parse(args.chartPointInfo.label!);
            final pointInfoTime = double.parse(args.chartPointInfo.header!);
            
            // Update the CustomWidget state with new price
            final customWidgetState = widget.chartInfoKey.currentState as _CustomWidgetState?;
            if (customWidgetState != null && mounted) {
              // Store the hover values in the state
              customWidgetState.setState(() {
                customWidgetState._hoverPrice = pointInfoPrice;
                customWidgetState._hoverTime = DateTime.fromMillisecondsSinceEpoch(pointInfoTime.round());
                customWidgetState._isHovering = true;
              });
            }
          }
        },
        onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
          isTrackballActive = false;
          setState(() {});
          
          // Reset to current price when interaction ends
          final customWidgetState = widget.chartInfoKey.currentState as _CustomWidgetState?;
          if (customWidgetState != null && mounted) {
            customWidgetState.setState(() {
              customWidgetState._isHovering = false;
            });
          }
        },
        plotAreaBorderWidth: 0,
        primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.none,
          isVisible: false,
          majorGridLines: MajorGridLines(width: 0),
          minorGridLines: MinorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          opposedPosition: true,
          isVisible: false,
          majorGridLines: MajorGridLines(width: 0),
          minorGridLines: MinorGridLines(width: 0),
        ),
        series: <AreaSeries<ChartLine, double>>[
          AreaSeries<ChartLine, double>(
            name: 'Price',
            dataSource: chartData,
            xValueMapper: (ChartLine line, _) => line.time,
            yValueMapper: (ChartLine line, _) => line.price,
            color: priceChange >= 0 ? AppTheme.successColor : AppTheme.errorColor,
            borderColor: priceChange >= 0 ? AppTheme.successColor : AppTheme.errorColor,
            borderWidth: 2,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: priceChange >= 0
                  ? [AppTheme.successColor.withOpacity(0.2), AppTheme.successColor.withOpacity(0.0)]
                  : [AppTheme.errorColor.withOpacity(0.2), AppTheme.errorColor.withOpacity(0.0)],
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    BitcoinController bitcoinController = Get.find<BitcoinController>();

    // If we have token data, build a token chart
    if (widget.tokenData != null) {
      return _buildTokenChart(context);
    }

    // Otherwise, build the Bitcoin chart
    return Obx(() {
      bitcoinController.liveChart.value;

      // Ensure the values are initialized even if we have empty data
      if (bitcoinController.currentline.value.isEmpty) {
        bitcoinController.setValues(); // This will set default values
      }

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
        double priceChange = bitcoinController.currentline.value.isEmpty ||
                bitcoinController.new_firstpriceexact == 0
            ? 0
            : (bitcoinController.new_lastpriceexact -
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
          if (mounted && widget.chartInfoKey.currentState != null) {
            widget.chartInfoKey.currentState!.refresh();
          }
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
                  double priceChange = _firstpriceexact == 0
                      ? 0
                      : (double.parse(bitcoinController.trackBallValuePrice) -
                              _firstpriceexact) /
                          _firstpriceexact;
                  bitcoinController.trackBallValuePricechange =
                      toPercent(priceChange);

                  widget.chartInfoKey.currentState!.refresh();
                }
              },
              onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
                isTrackballActive = false;
                setState(() {});
                //reset to current latest price when selection ends
                bitcoinController.trackBallValuePrice =
                    _lastpricerounded.toString();
                //reset to percent of screen
                double priceChange = _firstpriceexact == 0
                    ? 0
                    : (_lastpriceexact - _firstpriceexact) / _firstpriceexact;
                bitcoinController.trackBallValuePricechange =
                    toPercent(priceChange);
                widget.chartInfoKey.currentState!.refresh();
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
                        isVisible: !bitcoinController.currentline.value.isEmpty,
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
  final Map<String, dynamic>? tokenData;

  const CustomWidget({
    required this.key,
    this.tokenData,
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
  
  // Hover state for token charts
  bool _isHovering = false;
  double? _hoverPrice;
  DateTime? _hoverTime;

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

  // Helper method to format price based on value
  String _formatPrice(double price) {
    if (price >= 1000) {
      // For prices like 48,350
      return price.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
    } else if (price >= 1) {
      // For prices like 15.75
      return price.toStringAsFixed(2);
    } else {
      // For very small prices
      return price.toStringAsFixed(6);
    }
  }
  
  // Helper method to get token image path
  String _getTokenImage(String tokenSymbol) {
    switch (tokenSymbol) {
      case 'GENST':
        return 'assets/tokens/genisisstone.webp';
      case 'HTDG':
        return 'assets/tokens/hotdog.webp';
      case 'CAT':
        return 'assets/tokens/cat.webp';
      case 'EMRLD':
        return 'assets/tokens/emerald.webp';
      case 'LILA':
        return 'assets/tokens/lila.webp';
      case 'MINRL':
        return 'assets/tokens/mineral.webp';
      case 'TBLUE':
        return 'assets/tokens/token_blue.webp';
      default:
        return 'assets/images/bitcoin.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cache Theme to avoid multiple expensive calls
    final theme = Theme.of(context);
    
    // Check if we're displaying token data
    if (widget.tokenData != null) {
      final tokenSymbol = widget.tokenData!['tokenSymbol'];
      final tokenName = widget.tokenData!['tokenName'];
      final currentPrice = widget.tokenData!['currentPrice'];
      
      // Use hover values if hovering, otherwise use current values
      final displayPrice = _isHovering && _hoverPrice != null ? _hoverPrice! : currentPrice;
      final displayTime = _isHovering && _hoverTime != null ? _hoverTime! : DateTime.now();
      
      DateFormat dateFormat = DateFormat("dd.MM.yyyy");
      DateFormat timeFormat = DateFormat("HH:mm");
      String date = dateFormat.format(displayTime);
      String time = timeFormat.format(displayTime);
      
      return Column(
        children: [
          Row(
            children: [
              Container(
                height: AppTheme.elementSpacing * 3.75,
                width: AppTheme.elementSpacing * 3.75,
                child: ClipOval(
                  child: Image.asset(
                    _getTokenImage(tokenSymbol),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 7.5)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tokenName,
                            style: theme.textTheme.headlineMedium),
                        Text(
                          date,
                          style: theme.textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          tokenSymbol,
                          style: theme.textTheme.titleSmall,
                        ),
                        Text(
                          time,
                          style: theme.textTheme.titleSmall,
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
                  Text(
                    "\$${_formatPrice(displayPrice)}",
                    style: theme.textTheme.displaySmall,
                  ),
                ],
              ),
              Builder(
                builder: (context) {
                  // Get the current chart state if available
                  final chartCoreState = context.findAncestorStateOfType<_ChartCoreState>();
                  String percentage = '+0.00%';
                  bool isPositive = true;
                  
                  if (chartCoreState != null && widget.tokenData != null) {
                    final selectedPeriod = chartCoreState.selectedPeriod;
                    final priceHistory = widget.tokenData!['priceHistory'] as Map<String, dynamic>;
                    final periodData = priceHistory[selectedPeriod] as List<Map<String, dynamic>>;
                    
                    if (periodData.isNotEmpty) {
                      final firstPrice = double.parse(periodData.first['price'].toString());
                      // Use hover price if hovering, otherwise use last price
                      final comparePrice = _isHovering && _hoverPrice != null 
                          ? _hoverPrice! 
                          : double.parse(periodData.last['price'].toString());
                      final change = ((comparePrice - firstPrice) / firstPrice) * 100;
                      isPositive = change >= 0;
                      percentage = '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%';
                    }
                  }
                  
                  return BitNetPercentWidget(
                    priceChange: percentage,
                  );
                },
              ),
            ],
          ),
        ],
      );
    }
    
    // Bitcoin data display
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
                            style: theme.textTheme.headlineMedium),
                        Text(
                          trackDate,
                          style: theme.textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "BTC",
                          style: theme.textTheme.titleSmall,
                        ),
                        Text(
                          trackTime,
                          style: theme.textTheme.titleSmall,
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
                  Text(
                    "${bitcoinController.trackBallValuePrice}${getCurrency(currency!)}",
                    style: theme.textTheme.displaySmall,
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
