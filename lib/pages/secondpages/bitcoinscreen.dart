//bitcoin screen

import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/model/fear_gear_chart_model.dart';
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
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  FearGearChartModel fearGearChartModel = FearGearChartModel();
// The fake data will be stored here
  String selectedMonth = '3M';
  String formattedDate = '';
  getData() async {
    var dio = Dio();
    try {
      var response = await dio.get(
          'https://mempool.space/api/v1/mining/hashrate/${selectedMonth.toLowerCase()}');
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
      print('----------===========----------');
    }
  }

  getFearChart() async {
    var dio = Dio();
    try {
      var response = await dio.get(
          'https://fear-and-greed-index.p.rapidapi.com/v1/fgi',
          options: Options(headers: {'X-RapidAPI-Key': 'd9329ded30msh2e4ed90bed55972p1162f9jsn68d0a91b20ff', 'X-RapidAPI-Host' : 'fear-and-greed-index.p.rapidapi.com'}));
      print(response.data);
      if (response.statusCode == 200) {
        print('2---------00000-');
        fearGearChartModel = FearGearChartModel.fromJson(response.data);
        if(fearGearChartModel.lastUpdated != null) {
          DateTime dateTime = DateTime.parse(
              fearGearChartModel.lastUpdated!.humanDate!);
          formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
        }
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
    getFearChart();
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
          Column(
            children: [
              ChartWidget(),
              SizedBox(
                height: AppTheme.elementSpacing * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 6.5,
                      customHeight: AppTheme.cardPadding * 2.5,
                      title: "Buy",
                      onTap: () {
                        BitNetBottomSheet(
                            context: context,
                            child: Column(
                              children: [
                                AmountWidget(
                                    enabled: true,
                                    amountController: TextEditingController(),
                                    focusNode: FocusNode(),
                                    context: context),
                              ],
                            ));
                      }),
                  SizedBox(
                    width: AppTheme.elementSpacing,
                  ),
                  LongButtonWidget(
                      buttonType: ButtonType.transparent,
                      customWidth: AppTheme.cardPadding * 6.5,
                      customHeight: AppTheme.cardPadding * 2.5,
                      title: "Sell",
                      onTap: () {
                        BitNetBottomSheet(
                            context: context,
                            child: Column(
                              children: [
                                AmountWidget(
                                    enabled: true,
                                    amountController: TextEditingController(),
                                    focusNode: FocusNode(),
                                    context: context),
                              ],
                            ));
                      }),
                ],
              )
            ],
          ),
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
              contentPadding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppTheme.cardPadding,
                        right: AppTheme.cardPadding,
                        top: AppTheme.cardPadding),
                    child: Row(
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
                                  setState(() {});
                                },
                                items: <String>[
                                  '3M',
                                  '6M',
                                  '1Y',
                                  '2Y',
                                  '3Y'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()),
                          ),
                        )),
                      ],
                    ),
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
          // freed chart
          RoundedContainer(
              contentPadding: const EdgeInsets.all(0),
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
                      "Fear & Greed Index",
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
                          text: "Now: ",
                          style: Theme.of(context).textTheme.titleLarge,
                          children: <TextSpan>[
                            TextSpan(
                              text: "${fearGearChartModel.fgi == null ? 0 : fearGearChartModel.fgi!.now!.valueText}",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith( color: Colors.green),
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
                          value: fearGearChartModel.fgi == null ? 0 : fearGearChartModel.fgi!.now!.value!.toDouble(),
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
                        child: Text('Last updated: $formattedDate'),
                      ))
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
