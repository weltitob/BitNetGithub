import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/timechooserbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/view/hashratechart.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class HashrateWidget extends StatefulWidget {
  const HashrateWidget({Key? key}) : super(key: key);

  @override
  State<HashrateWidget> createState() => _HashrateWidgetState();
}

class _HashrateWidgetState extends State<HashrateWidget> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  List<ChartLine> chartData = [];
  List<Difficulty> difficulty = [];
  List<ChartLine> currentChartData = [];
  List<Difficulty> currentDifficulty = [];
  String selectedMonth = '3M';
  bool isLoading = true;
  String? errorMessage;

  getData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    var dio = Dio();
    try {
      var response =
          await dio.get('https://mempool.space/api/v1/mining/hashrate/3Y');

      if (response.statusCode == 200) {
        List<ChartLine> line = [];
        line.clear();
        chartData.clear();
        difficulty.clear();

        HashChartModel hashChartModel = HashChartModel.fromJson(response.data);
        difficulty.addAll(hashChartModel.difficulty ?? []);
        for (int i = 0; i < hashChartModel.hashrates!.length; i++) {
          line.add(ChartLine(
            time:
                double.parse(hashChartModel.hashrates![i].timestamp.toString()),
            price: hashChartModel.hashrates![i].avgHashrate!,
          ));
        }
        chartData = line;
        setData();
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load hashrate data: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void setData() {
    DateTime range =
        DateTime.now().subtract(const Duration(days: 90)); // Default to 3M
    switch (selectedMonth) {
      case '3M':
        range = DateTime.now().subtract(const Duration(days: 90));
        break;
      case '6M':
        range = DateTime.now().subtract(const Duration(days: 180));
        break;
      case '1Y':
        range = DateTime.now().subtract(const Duration(days: 365));
        break;
    }

    currentChartData = chartData.where((test) {
      DateTime time = DateTime.fromMillisecondsSinceEpoch(
          (test.time * 1000).round(),
          isUtc: false);
      return time.isAfter(range) || time.isAtSameMomentAs(range);
    }).toList();

    currentDifficulty = difficulty.where((test) {
      if (test.time == null) {
        return false;
      }
      DateTime time = DateTime.fromMillisecondsSinceEpoch(
          (test.time! * 1000).round(),
          isUtc: false);
      return time.isAfter(range) || time.isAtSameMomentAs(range);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding,
        vertical: AppTheme.elementSpacing,
      ),
      height: 320, // Compact height as required
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.cardPadding),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.elementSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  L10n.of(context)!.hashrate,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    context.push('/wallet/bitcoinscreen/hashrate');
                  },
                  child: Text(
                    "View more",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Expanded(
              child: Center(
                child: dotProgress(context),
              ),
            )
          else if (errorMessage != null)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.elementSpacing),
                  child: Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: SizedBox(
                height: 180,
                child: HashrateChart(
                  chartData: currentChartData,
                  difficulty: currentDifficulty,
                ),
              ),
            ),
          CustomizableTimeChooser(
            timePeriods: ['3M', '6M', '1Y'],
            initialSelectedPeriod: selectedMonth,
            onTimePeriodSelected: (String newValue) {
              setState(() {
                selectedMonth = newValue;
                setData();
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
      ),
    );
  }
}
