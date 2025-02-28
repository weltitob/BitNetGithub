import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TokensTab extends StatefulWidget {
  const TokensTab({super.key});

  @override
  State<TokensTab> createState() => _TokensTabState();
}

class _TokensTabState extends State<TokensTab> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return bitnetScaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          const SizedBox(height: AppTheme.cardPadding * 0.1),
          
          // Trending section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text(
              'Trending',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14.sp, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 15),
          
          SizedBox(
            height: 150.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: GlassContainer(
                    width: size.width - 200.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                height: 30.h,
                                width: 30.w,
                                child: Image.asset('assets/images/bitcoin.png'),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "btc",
                                style: AppTheme.textTheme.titleLarge,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: AppTheme.elementSpacing),
                              width: AppTheme.cardPadding * 3.75.w,
                              color: Colors.transparent,
                              child: SfCartesianChart(
                                enableAxisAnimation: true,
                                plotAreaBorderWidth: 0,
                                primaryXAxis: CategoryAxis(
                                    labelPlacement: LabelPlacement.onTicks,
                                    edgeLabelPlacement: EdgeLabelPlacement.none,
                                    isVisible: false,
                                    majorGridLines: const MajorGridLines(width: 0),
                                    majorTickLines: const MajorTickLines(width: 0)),
                                primaryYAxis: NumericAxis(
                                  plotOffset: 0,
                                  edgeLabelPlacement: EdgeLabelPlacement.none,
                                  isVisible: false,
                                  majorGridLines: const MajorGridLines(width: 0),
                                  majorTickLines: const MajorTickLines(width: 0),
                                ),
                                series: <ChartSeries>[
                                  LineSeries<ChartLine, double>(
                                    dataSource: [
                                      ChartLine(time: 2, price: 3),
                                      ChartLine(time: 3, price: 24),
                                      ChartLine(time: 4, price: 5),
                                      ChartLine(time: 3, price: 34),
                                      ChartLine(time: 1, price: 4),
                                      ChartLine(time: 1, price: 14),
                                    ],
                                    animationDuration: 0,
                                    xValueMapper: (ChartLine crypto, _) =>
                                        crypto.time,
                                    yValueMapper: (ChartLine crypto, _) =>
                                        crypto.price,
                                    color: AppTheme.errorColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.arrow_upward,
                                color: Colors.green,
                                size: 20,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                '5.2%',
                                style: AppTheme.textTheme.titleMedium,
                              )
                            ],
                          ),
                          Text(
                            '2.224232',
                            style: AppTheme.textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          
          SizedBox(height: AppTheme.cardPadding.h * 1.5),
          
          // Top 3 by Market Cap section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text(
              'Top 3 by Market Cap',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14.sp, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 15),
          
          // A single GlassContainer containing all crypto items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              child: Column(
                children: [
                  // First crypto item
                  CryptoItem(
                    hasGlassContainer: false,
                    currency: Currency(
                      code: 'Hotdog',
                      name: 'Hotdog',
                      icon: Image.asset("./assets/tokens/hotdog.webp"),
                    ),
                    context: context,
                  ),
                  
                  // Second crypto item
                  CryptoItem(
                    hasGlassContainer: false,
                    currency: Currency(
                      code: 'GENST',
                      name: 'Genisis Stone',
                      icon: Image.asset("./assets/tokens/genisisstone.webp"),
                    ),
                    context: context,
                  ),
                  
                  // Third crypto item
                  CryptoItem(
                    hasGlassContainer: false,
                    currency: Currency(
                      code: 'HTDG',
                      name: 'Hotdog',
                      icon: Image.asset("./assets/tokens/hotdog.webp"),
                    ),
                    context: context,
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 10.h),
          
          // Total Market Cap Today section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text(
              'Total Market Cap Today',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14.sp, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 15),
          
          SizedBox(
            height: 140.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GlassContainer(
                width: size.width - AppTheme.cardPadding * 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '5.24%',
                        style: AppTheme.textTheme.displaySmall,
                      ),
                      SizedBox(
                        height: 40.h,
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: AppTheme.elementSpacing),
                          width: AppTheme.cardPadding * 3.75.w,
                          color: Colors.transparent,
                          child: SfCartesianChart(
                            enableAxisAnimation: true,
                            plotAreaBorderWidth: 0,
                            primaryXAxis: CategoryAxis(
                                labelPlacement:
                                    LabelPlacement.onTicks,
                                edgeLabelPlacement:
                                    EdgeLabelPlacement.none,
                                isVisible: false,
                                majorGridLines:
                                    const MajorGridLines(
                                        width: 0),
                                majorTickLines:
                                    const MajorTickLines(
                                        width: 0)),
                            primaryYAxis: NumericAxis(
                              plotOffset: 0,
                              edgeLabelPlacement:
                                  EdgeLabelPlacement.none,
                              isVisible: false,
                              majorGridLines:
                                  const MajorGridLines(width: 0),
                              majorTickLines:
                                  const MajorTickLines(width: 0),
                            ),
                            series: <ChartSeries>[
                              LineSeries<ChartLine, double>(
                                dataSource: [
                                  ChartLine(time: 2, price: 3),
                                  ChartLine(time: 3, price: 24),
                                  ChartLine(time: 4, price: 5),
                                  ChartLine(time: 3, price: 34),
                                  ChartLine(time: 1, price: 4),
                                  ChartLine(time: 1, price: 14),
                                  ChartLine(time: 23, price: 23),
                                  ChartLine(time: 5, price: 40),
                                  ChartLine(time: 12, price: 13),
                                  ChartLine(time: 42, price: 14),
                                  ChartLine(time: 12, price: 34),
                                  ChartLine(time: 12, price: 23),
                                ],
                                animationDuration: 0,
                                xValueMapper:
                                    (ChartLine crypto, _) =>
                                        crypto.time,
                                yValueMapper:
                                    (ChartLine crypto, _) =>
                                        crypto.price,
                                color: AppTheme.errorColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            '5.2%',
                            style: AppTheme.textTheme.titleMedium,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      context: context,
    );
  }
}