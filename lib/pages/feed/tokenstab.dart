import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
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
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: ScrollController()..addListener(() {}),
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 0.1,
                ),
                CommonHeading(
                  hasButton: false,
                  headingText: 'Trending',
                  isNormalChild: true,
                  isChild: SizedBox(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          height: 30.h,
                                          width: 30.w,
                                          child: Image.asset(
                                              'assets/images/bitcoin.png'),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          "btc",
                                          style: AppTheme.textTheme.titleLarge,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40.h,
                                      child: Container(
                                        margin: EdgeInsets.only(
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
                                        Icon(
                                          Icons.arrow_upward,
                                          color: Colors.green,
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
                                    Text(
                                      '2.224232',
                                      style: AppTheme.textTheme.titleLarge,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(height: 10.h,),
                CommonHeading(
                  hasButton: false,
                  headingText: 'Top 5 by Market Cap',
                  isNormalChild: true,
                  isChild: Column(
                    children: [
                      TopFiveMarketCapWidget(),
                      TopFiveMarketCapWidget(),
                      TopFiveMarketCapWidget(),
                      TopFiveMarketCapWidget(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                 CommonHeading(
                  hasButton: false,
                  headingText: 'Total Market Cap Today',
                  isNormalChild: true,
                  isChild: SizedBox(
                    height: 140.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: GlassContainer(
                              width: size.width - 230.w,
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
                                        margin: EdgeInsets.only(
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
                                        Icon(
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
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          // const StatusBarBg()
        ],
      ),
      context: context,
    );
  }
}

class TopFiveMarketCapWidget extends StatelessWidget {
  const TopFiveMarketCapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: GlassContainer(
          borderThickness: 1,
          height: AppTheme.cardPadding * 2.75,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
            child: Row(
              children: [
                Container(
                  height: AppTheme.cardPadding * 1.75,
                  width: AppTheme.cardPadding * 1.75,
                  child: Image.asset("assets/images/bitcoin.png"),
                ),
                SizedBox(
                  width: AppTheme.elementSpacing.w / 1.5,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("whatever",
                        style: Theme.of(context).textTheme.titleLarge),
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: AppTheme.elementSpacing * 0.75,
                              width: AppTheme.elementSpacing * 0.75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500.0),
                                color: Colors.grey,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(500.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'BTC',
                          style: AppTheme.textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(width: AppTheme.elementSpacing.w / .5),
                SizedBox(
                  height: 50.h,
                  child: Container(
                    margin: EdgeInsets.only(right: AppTheme.elementSpacing),
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
                            ChartLine(time: 23, price: 23),
                            ChartLine(time: 5, price: 40),
                            ChartLine(time: 12, price: 13),
                            ChartLine(time: 42, price: 14),
                            ChartLine(time: 12, price: 34),
                            ChartLine(time: 12, price: 23),
                          ],
                          animationDuration: 0,
                          xValueMapper: (ChartLine crypto, _) => crypto.time,
                          yValueMapper: (ChartLine crypto, _) => crypto.price,
                          color: AppTheme.errorColor,
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$332.32',
                      style: AppTheme.textTheme.titleMedium,
                    ),
                    Text(
                      '+5.2%',
                      style: AppTheme.textTheme.titleSmall!
                          .copyWith(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
