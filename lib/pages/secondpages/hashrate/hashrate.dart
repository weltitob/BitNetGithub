import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/informationwidget.dart';
import 'package:bitnet/components/buttons/timechooserbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/view/hashratechart.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class HashrateScreen extends StatefulWidget {
  const HashrateScreen({super.key});

  @override
  State<HashrateScreen> createState() => _HashrateScreenState();
}
class _HashrateScreenState extends State<HashrateScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  static const hashrateExplanation = """
The hashrate is a key metric in the Bitcoin network, measuring the computing power dedicated to mining and securing the blockchain. It represents the number of hash operations performed per second by all miners.

A higher hashrate indicates more miners are participating, making the network more secure against potential attacks. As hashrate increases, the network automatically adjusts mining difficulty to maintain a consistent block time. As the hashrate grows, so does the cost and difficulty of attempting to manipulate the blockchain, thereby enhancing Bitcoin's security and immutability.
  """;



  List<ChartLine> chartData = [];
  List<Difficulty> difficulty = [];
  String selectedMonth = '3Y';

  getData() async {
    var dio = Dio();
    try {
      var response = await dio.get(
          'https://mempool.space/api/v1/mining/hashrate/${selectedMonth.toLowerCase()}');
      print(response.data);
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
        print(chartData.length);
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool) {
        if(bool) {
          context.pop();
        }
      },
      child: bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          text: L10n.of(context)!.hashrate,
          context: context,
          onTap: () {
            context.pop();
          },
        ),
        body: ListView(
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 2,
            ),

            HashrateChart(
              chartData: chartData,
              difficulty: difficulty,
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            CustomizableTimeChooser(
              timePeriods: ['3M', '6M', '1Y', '2Y', '3Y'],
              initialSelectedPeriod: selectedMonth,
              onTimePeriodSelected: (String newValue) {
                setState(() {
                  selectedMonth = newValue;
                  getData();
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
            //a widget that calculated how man raspberry pi 4s the current hashrate equals to
            SizedBox(
              height: AppTheme.cardPadding * 2,
            ),
            InformationWidget(
              title: "Information",
              description: hashrateExplanation,
            ),
            SizedBox(
              height: AppTheme.cardPadding * 2,
            ),

          ],
        ),
      ),
    );
  }
}