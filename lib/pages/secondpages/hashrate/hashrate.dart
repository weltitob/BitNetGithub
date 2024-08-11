import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
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

  @override
  void dispose() {
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,

      appBar: bitnetAppBar(
        text: L10n.of(context)!.hashrate,
        context: context,
        onTap: (){
          context.pop();
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 3.5,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                value: selectedMonth,
                onChanged: (String? newValue) {
                  selectedMonth = newValue!;
                  getData();
                  setState(() {});
                },
                items: <String>['3M', '6M', '1Y', '2Y', '3Y']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
          ),
          SizedBox(
            height: AppTheme.elementSpacing,
          ),
          HashrateChart(
            chartData: chartData,
            difficulty: difficulty,
          ),
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          GlassContainer(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
              child: Column(
                children: [
                  Text("The hashrate shows the...", style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
