import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/model/fear_gear_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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
              DateTime.parse(fearGearChartModel.lastUpdated!.humanDate!);
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
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.fearAndGreed,
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
          : RoundedContainer(
              contentPadding:
                  const EdgeInsets.only(top: AppTheme.cardPadding * 2.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppTheme.cardPadding,
                        right: AppTheme.cardPadding,
                        top: AppTheme.cardPadding,
                        bottom: AppTheme.cardPadding),
                    child: Text(
                      L10n.of(context)!.fearAndGreedIndex,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: AppTheme.cardPadding),
                  Align(
                    alignment: Alignment.topRight,
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
                                  ?.copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AnimatedRadialGauge(
                          duration: const Duration(seconds: 1),
                          curve: Curves.elasticOut,
                          radius: 150,
                          value: fearGearChartModel.fgi == null
                              ? 0
                              : fearGearChartModel.fgi!.now!.value!.toDouble(),
                          axis: GaugeAxis(
                            min: 0,
                            max: 100,
                            degrees: 180,
                            style: const GaugeAxisStyle(
                              thickness: 20,
                              background: Color(0xFFDFE2EC),
                              segmentSpacing: 4,
                            ),
                            progressBar: GaugeProgressBar.rounded(
                              color: AppTheme.colorBitcoin,
                            ),
                          ),
                          builder: (context, child, value) => RadialGaugeLabel(
                            value: value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 46,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
                  Divider(),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${L10n.of(context)!.lastUpdated} $formattedDate'),
                      ))
                ],
              )),
    );
  }
}
