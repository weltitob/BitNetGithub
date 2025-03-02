import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/model/fear_gear_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

class FearAndGreedWidget extends StatefulWidget {
  const FearAndGreedWidget({super.key});

  @override
  State<FearAndGreedWidget> createState() => _FearAndGreedWidgetState();
}

class _FearAndGreedWidgetState extends State<FearAndGreedWidget> {
  String formattedDate = '';
  bool _loading = false;
  FearGearChartModel fearGearChartModel = FearGearChartModel();

  @override
  void initState() {
    super.initState();
    getFearChart();
  }

  getFearChart() async {
    Location loc =
        Provider.of<TimezoneProvider>(context, listen: false).timeZone;
    var dio = Dio();
    try {
      setState(() {
        _loading = true;
      });
      var response =
          await dio.get('https://fear-and-greed-index.p.rapidapi.com/v1/fgi',
              options: Options(headers: {
                'X-RapidAPI-Key':
                    'd9329ded30msh2e4ed90bed55972p1162f9jsn68d0a91b20ff',
                'X-RapidAPI-Host': 'fear-and-greed-index.p.rapidapi.com'
              }));
      
      if (response.statusCode == 200) {
        fearGearChartModel = FearGearChartModel.fromJson(response.data);
        if (fearGearChartModel.lastUpdated != null) {
          DateTime dateTime =
              DateTime.parse(fearGearChartModel.lastUpdated!.humanDate!)
                  .toUtc()
                  .add(Duration(milliseconds: loc.currentTimeZone.offset));
          formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
        }
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 280, // A compact height between 250-300
      customShadow: Theme.of(context).brightness == Brightness.dark ? [] : null,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and View More Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  L10n.of(context)!.fearAndGreedIndex,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    context.push('/wallet/bitcoinscreen/fearandgreed');
                  },
                  child: Text(
                    'View more',
                    style: TextStyle(color: AppTheme.colorBitcoin),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: AppTheme.elementSpacing),
            
            // Content
            _loading
                ? Center(child: dotProgress(context))
                : Column(
                    children: [
                      // Value indicator text
                      Align(
                        alignment: (fearGearChartModel.fgi?.now?.value ?? 0) >= 25
                            ? (fearGearChartModel.fgi?.now?.value ?? 0) > 75
                                ? Alignment.topRight
                                : Alignment.topCenter
                            : Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            text: L10n.of(context)!.now,
                            style: Theme.of(context).textTheme.titleMedium,
                            children: <TextSpan>[
                              TextSpan(
                                text: fearGearChartModel.fgi?.now?.valueText ?? "N/A",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: (fearGearChartModel.fgi?.now?.value ?? 0) >= 25
                                            ? (fearGearChartModel.fgi?.now?.value ?? 0) > 75
                                                ? AppTheme.successColor
                                                : AppTheme.colorBitcoin
                                            : AppTheme.errorColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: AppTheme.elementSpacing),
                      
                      // Gauge
                      AnimatedRadialGauge(
                        duration: const Duration(seconds: 1),
                        curve: Curves.elasticOut,
                        radius: 80, // More compact size
                        value: fearGearChartModel.fgi?.now?.value?.toDouble() ?? 0,
                        axis: GaugeAxis(
                          min: 0,
                          max: 100,
                          degrees: 180,
                          style: GaugeAxisStyle(
                            thickness: 12, // Slightly thinner
                            background: Theme.of(context).brightness == Brightness.dark
                                ? AppTheme.white70
                                : AppTheme.black60,
                            segmentSpacing: 2, // Slightly reduced spacing
                          ),
                          progressBar: GaugeProgressBar.rounded(
                            color: (fearGearChartModel.fgi?.now?.value ?? 0) >= 25
                                ? (fearGearChartModel.fgi?.now?.value ?? 0) > 75
                                    ? AppTheme.successColor
                                    : AppTheme.colorBitcoin
                                : AppTheme.errorColor,
                          ),
                        ),
                        builder: (context, child, value) => RadialGaugeLabel(
                          value: value,
                          style: Theme.of(context).textTheme.headlineMedium, // Smaller text
                        ),
                      ),
                      
                      // Last updated date
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '${L10n.of(context)!.lastUpdated} $formattedDate',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}