//bitcoin screen

import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/view/hashratechart.dart';
import 'package:bitnet/pages/secondpages/mempool/view/mempoolhome.dart';
import 'package:bitnet/pages/secondpages/analystsassesment.dart';
import 'package:bitnet/pages/secondpages/keymetrics.dart';
import 'package:bitnet/pages/secondpages/mempool/view/recentreplacements.dart';
import 'package:bitnet/pages/secondpages/mempool/view/recenttransactions.dart';
import 'package:bitnet/pages/secondpages/whalebehaviour.dart';
import 'package:bitnet/pages/transactions/model/hash_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/pages/secondpages/newsscreen.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:get/get.dart';

class BitcoinScreen extends StatefulWidget {
  const BitcoinScreen({
    Key? key,
  }) : super(key: key);

  @override
  _BitcoinScreenState createState() => _BitcoinScreenState();
}

class _BitcoinScreenState extends State<BitcoinScreen>
    with SingleTickerProviderStateMixin {
  //TickerProviderStateMixin
  final _controller = PageController(viewportFraction: 0.9);
  late TabController _tabController;
  List<ChartLine> chartData = [];
  List<Difficulty> difficulty = [];
// The fake data will be stored here
  String selectedMonth = '3M';
  getData() async {
    var dio = Dio();
    try {
      var response =
      await dio.get('https://mempool.space/api/v1/mining/hashrate/${selectedMonth.toLowerCase()}');
      print(response.data);
      if (response.statusCode == 200) {
        print('2---------00000-');
        List<ChartLine> line = [];
        line.clear();
        chartData.clear();
        difficulty.clear();
        HashChartModel hashChartModel = HashChartModel.fromJson(response.data);
        difficulty.addAll(hashChartModel.difficulty ?? []);
        for (int i = 0; i < hashChartModel.hashrates!.length; i++) {
          line.add(ChartLine(
              time: double.parse(
                  hashChartModel.hashrates![i].timestamp.toString()),
              price: hashChartModel.hashrates![i].avgHashrate!,
          ));
        }
        chartData = line;
        print(chartData.length);
        setState(() {});
      }
    } catch (e) {
      print(e);
      print('----------===========----------');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return bitnetScaffold(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: bitnetAppBar(
          text: "Bitcoin chart",
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          }),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: [
          ChartWidget(),
          RoundedContainer(
            contentPadding: const EdgeInsets.all(0),
            child: Obx(() => controller.isLoading.isTrue
                ? Center(
              child: CircularProgressIndicator(),
            )
                : MempoolHome()),
          ),
          RoundedContainer(
            contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Recent Transactions'),
                    Tab(text: 'Recent Replacements'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(child: RecentTransactions()),
                      SingleChildScrollView(child: RecentReplacements()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          RoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hashrate & Difficulty chart",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      GlassContainer(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: selectedMonth,
                                  onChanged: (String? newValue) {
                                    selectedMonth = newValue!;
                                    getData();
                                    setState(() {
                                    });
                                  },
                                  items: <String>['3M', '6M', '1Y', '2Y', '3Y']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList()),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: AppTheme.elementSpacing,
                  ),
                  HashrateChart(
                    chartData: chartData,
                    difficulty: difficulty,
                  ),
                ],
              )),
          RoundedContainer(
            contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppTheme.cardPadding),
                  child: Text(
                    "Key metrics",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding,
                ),
                buildKeymetrics(),
              ],
            ),
          ),
          RoundedContainer(
            contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppTheme.cardPadding),
                  child: Text(
                    "Analysis",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding,
                ),
                AnalysisWidget(),
              ],
            ),
          ),
          RoundedContainer(
            contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppTheme.cardPadding),
                  child: Text(
                    "Whale behaviour",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding,
                ),
                WhaleBehaviour(),
              ],
            ),
          ),
          RoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "News",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: AppTheme.elementSpacing,
                  ),
                  buildNews(),
                ],
              )),
        ],
      ),
    );
  }
}

