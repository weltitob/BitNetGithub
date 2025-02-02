import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/informationwidget.dart';
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

class FearAndGreed extends StatefulWidget {
  const FearAndGreed({super.key});

  @override
  State<FearAndGreed> createState() => _FearAndGreedState();
}

class _FearAndGreedState extends State<FearAndGreed> {
  String formattedDate = '';

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getFearChart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  FearGearChartModel fearGearChartModel = FearGearChartModel();

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
      print(response.data);
      if (response.statusCode == 200) {
        print('2---------00000-');
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
      print(e);
      setState(() {
        _loading = false;
      });
      print('----------===========----------');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool) {
        if (bool) {
          context.pop();
        }
      },
      child: bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          text: L10n.of(context)!.fearAndGreedIndex,
          context: context,
          onTap: () {
            context.pop();
          },
        ),
        body: _loading
            ? Center(
                child: Container(
                  height: AppTheme.cardPadding * 10,
                  child: dotProgress(context),
                ),
              )
            : ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: AppTheme.cardPadding * 3),
                      Align(
                        alignment: (fearGearChartModel.fgi!.now!.value! >= 25)
                            ? (fearGearChartModel.fgi!.now!.value! > 75)
                                ? Alignment.topRight
                                : Alignment.topCenter
                            : Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: AppTheme.cardPadding,
                              right: AppTheme.cardPadding,
                              bottom: AppTheme.cardPadding),
                          child: RichText(
                            text: TextSpan(
                              text: L10n.of(context)!.now,
                              style: Theme.of(context).textTheme.titleLarge,
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "${fearGearChartModel.fgi == null ? 0 : fearGearChartModel.fgi!.now!.valueText}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          color: (fearGearChartModel
                                                      .fgi!.now!.value! >=
                                                  25)
                                              ? (fearGearChartModel
                                                          .fgi!.now!.value! >
                                                      75)
                                                  ? AppTheme.successColor
                                                  : AppTheme.colorBitcoin
                                              : AppTheme.errorColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: AnimatedRadialGauge(
                              duration: const Duration(seconds: 1),
                              curve: Curves.elasticOut,
                              radius: 150,
                              value: fearGearChartModel.fgi == null
                                  ? 0
                                  : fearGearChartModel.fgi!.now!.value!
                                      .toDouble(),
                              axis: GaugeAxis(
                                min: 0,
                                max: 100,
                                degrees: 180,
                                style: GaugeAxisStyle(
                                  thickness: 20,
                                  background: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppTheme.white70
                                      : AppTheme.black60,
                                  segmentSpacing: 4,
                                ),
                                progressBar: GaugeProgressBar.rounded(
                                  color: (fearGearChartModel.fgi!.now!.value! >=
                                          25)
                                      ? (fearGearChartModel.fgi!.now!.value! >
                                              75)
                                          ? AppTheme.successColor
                                          : AppTheme.colorBitcoin
                                      : AppTheme.errorColor,
                                ),
                              ),
                              builder: (context, child, value) =>
                                  RadialGaugeLabel(
                                value: value,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            )),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing,
                                vertical: AppTheme.cardPadding),
                            child: Text(
                                '${L10n.of(context)!.lastUpdated} $formattedDate'),
                          )),
                      const SizedBox(
                        height: AppTheme.cardPadding * 2,
                      ),
                    ],
                  ),
                  const InformationWidget(
                      title: "Information",
                      description:
                          "The Fear and Greed Index is a tool used to measure the overall sentiment of investors in the stock market. It gauges whether the market is driven more by fear or greed at any given time."),
                ],
              ),
      ),
    );
  }
}
