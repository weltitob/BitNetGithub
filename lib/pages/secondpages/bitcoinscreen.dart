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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
          Column(
            children: [
               ChartWidget(),
              SizedBox(height: AppTheme.elementSpacing * 1.5,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 6.5,
                      customHeight: AppTheme.cardPadding * 2.5,
                      title: "Buy", onTap: (){
                        BitNetBottomSheet(context: context, child:
                        PurchaseSheet()
                        );
                  }),
                  SizedBox(width: AppTheme.elementSpacing,),
                  LongButtonWidget(
                      buttonType: ButtonType.transparent,
                      customWidth: AppTheme.cardPadding * 6.5,
                      customHeight: AppTheme.cardPadding * 2.5,
                      title: "Sell",
                      onTap: (){
                        BitNetBottomSheet(context: context, child:
                        Column(
                        children: [
                        AmountWidget(
                            enabled: true,
                            btcController: TextEditingController(),
                            currController: TextEditingController(),
                        focusNode: FocusNode(),
                        context: context
                        ),
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
                    padding: const EdgeInsets.only(left:AppTheme.cardPadding,
                    right: AppTheme.cardPadding ,
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

class PurchaseSheet extends StatefulWidget {
  const PurchaseSheet({
    super.key,
  });

  @override
  State<PurchaseSheet> createState() => _PurchaseSheetState();
}

class _PurchaseSheetState extends State<PurchaseSheet> with TickerProviderStateMixin{
  late TabController controller;
  @override
 void initState() {
  controller = TabController(length: 3, vsync: this);
  super.initState();
 }
 @override 
 void dispose() {
  controller.dispose();
  super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: controller,
      children:[ 
        
        Column(
        children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                        left: AppTheme.cardPadding,
                        right: AppTheme.cardPadding,
                        top: AppTheme.elementSpacing),
                                        child: Text(
                                                                      "Purchase Bitcoin",
                                                                      style: Theme.of(context).textTheme.titleSmall,
                                                                    ),
                                      ),

          AmountWidget(
              enabled: true,
              btcController: TextEditingController(),
              currController: TextEditingController(),
              focusNode: FocusNode(),
              context: context
          ),
          SizedBox(height: AppTheme.cardPadding * 2,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text('Payment Method',
                style: Theme.of(context).textTheme.titleSmall,
            
                ),                
              ],
            ),
          ),
          SizedBox(height: 16),

          PaymentCardHorizontalWidget(controller: controller),
                          SizedBox(height: AppTheme.elementSpacing * 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LongButtonWidget(title: "Buy Bitcoin", onTap: (){}, customWidth: double.infinity,))

        ],
      ),

      Column(children: [
                                   Padding(
                                        padding: EdgeInsets.only(
                        left: AppTheme.cardPadding,
                        right: AppTheme.cardPadding,
                        top: AppTheme.elementSpacing),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(icon: Icon(Icons.arrow_back), onPressed: (){controller.animateTo(0);},),
                                            Text(
                                                                          "Purchase Bitcoin",
                                                                          style: Theme.of(context).textTheme.titleSmall,
                                                                        ),
                                           SizedBox(width: 32)
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: AppTheme.elementSpacing * 2,),
                                      Container(
                                        height: 400,
                                        child: ListView(children: [
                                                    PaymentCardHorizontalWidget(controller: controller, check: true),
                                        
                                                    SizedBox(height: AppTheme.elementSpacing,),
                                                                                                      PaymentCardHorizontalWidget(controller: controller, forward: false,),
                                        
                                                    SizedBox(height: AppTheme.elementSpacing,),
                                                    PaymentCardHorizontalWidget(controller: controller, forward: false,),
                                        
                                                    SizedBox(height: AppTheme.elementSpacing,),
                                                    NewPaymentCardHorizontalWidget(controller: controller)
                                        
                                        ],),
                                      )

      ],),
      Column(children: [
        Padding(
padding: EdgeInsets.only(
                        left: AppTheme.cardPadding,
                        right: AppTheme.cardPadding,
                        top: AppTheme.elementSpacing),          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
          IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: (){
            controller.animateTo(1);
          },),
           Text(
                                                                            "Save Card",
                                                                            style: Theme.of(context).textTheme.titleSmall,
                                                                          ),
                                             SizedBox(width: 48)
          ],),
        ),
        SizedBox(height: 15),
        CardFormField(style: CardFormStyle(textColor: Colors.white,placeholderColor: Colors.white )),
                SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: LongButtonWidget(title: "Save Card", onTap: (){}, customWidth: double.infinity,),
        )
      ],)
      ]
    );
  }
}

class NewPaymentCardHorizontalWidget extends StatelessWidget {
    final TabController controller;
NewPaymentCardHorizontalWidget({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: (){
          controller.animateTo(2);
        },
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
        
          borderRadius: BorderRadius.circular(12),
        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: AppTheme.elementSpacing),
                        Text("Add New Card", style: Theme.of(context).textTheme.titleSmall)
                    ],)
        ),
      ),
    );
  }
}

class PaymentCardHorizontalWidget extends StatelessWidget {
  const PaymentCardHorizontalWidget({
    super.key,
    required this.controller,
    this.check = false,
    this.forward = true
  });

  final TabController controller;
  final bool check;
  final bool forward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
      
        borderRadius: BorderRadius.circular(12),
      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset("assets/images/paypal.png",
                      height: 48),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("**** **** **** 4531"),
                        Text('03/2030'),
                      ],
                    ),
                   SizedBox(width: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: check ? Icon(Icons.check, color: Colors.blue): forward ? IconButton(icon: Icon(Icons.arrow_right,), onPressed: (){
                        print("controller is moving");
                        controller.animateTo(1);
  },) : SizedBox(width: 32,),
                    )
                    
                  ],)
      ),
    );
  }
}