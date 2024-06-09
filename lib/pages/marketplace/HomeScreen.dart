import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/MostView.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/components/marketplace_widgets/TrendingSellersSlider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController? ctrler;
  const HomeScreen({Key? key, this.ctrler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return bitnetScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: ctrler,
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: AppTheme.cardPadding * 0.1,
                // ),
                // CommonHeading(
                //   hasButton: false,
                //   headingText: 'Trending',
                //   isNormalChild: true,
                //   isChild: SizedBox(
                //     height: 150.h,
                //     child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: 3,
                //         itemBuilder: (context, index) {
                //           return Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 10.w),
                //             child: GlassContainer(
                //               width: size.width - 200.w,
                //               child: Padding(
                //                 padding: EdgeInsets.symmetric(
                //                   horizontal: 20.w,
                //                   vertical: 10.h,
                //                 ),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Row(
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.center,
                //                       children: [
                //                         Container(
                //                           margin: EdgeInsets.only(top: 5),
                //                           height: 30.h,
                //                           width: 30.w,
                //                           child: Image.asset(
                //                               'assets/images/bitcoin.png'),
                //                         ),
                //                         SizedBox(
                //                           width: 8.w,
                //                         ),
                //                         Text(
                //                           L10n.of(context)!.bitcoin,
                //                           style: AppTheme.textTheme.titleLarge,
                //                         )
                //                       ],
                //                     ),
                //                     SizedBox(
                //                       height: 50.h,
                //                       child: Container(
                //                         margin: EdgeInsets.only(
                //                             right: AppTheme.elementSpacing),
                //                         width: AppTheme.cardPadding * 3.75.w,
                //                         color: Colors.transparent,
                //                         child: SfCartesianChart(
                //                           enableAxisAnimation: true,
                //                           plotAreaBorderWidth: 0,
                //                           primaryXAxis: CategoryAxis(
                //                               labelPlacement:
                //                                   LabelPlacement.onTicks,
                //                               edgeLabelPlacement:
                //                                   EdgeLabelPlacement.none,
                //                               isVisible: false,
                //                               majorGridLines:
                //                                   const MajorGridLines(
                //                                       width: 0),
                //                               majorTickLines:
                //                                   const MajorTickLines(
                //                                       width: 0)),
                //                           primaryYAxis: NumericAxis(
                //                             plotOffset: 0,
                //                             edgeLabelPlacement:
                //                                 EdgeLabelPlacement.none,
                //                             isVisible: false,
                //                             majorGridLines:
                //                                 const MajorGridLines(width: 0),
                //                             majorTickLines:
                //                                 const MajorTickLines(width: 0),
                //                           ),
                //                           series: <ChartSeries>[
                //                             LineSeries<ChartLine, double>(
                //                               dataSource: [
                //                                 ChartLine(time: 2, price: 3),
                //                                 ChartLine(time: 3, price: 24),
                //                                 ChartLine(time: 4, price: 5),
                //                                 ChartLine(time: 3, price: 34),
                //                                 ChartLine(time: 1, price: 4),
                //                                 ChartLine(time: 1, price: 14),
                //                                 ChartLine(time: 23, price: 23),
                //                                 ChartLine(time: 5, price: 40),
                //                                 ChartLine(time: 12, price: 13),
                //                                 ChartLine(time: 42, price: 14),
                //                                 ChartLine(time: 12, price: 34),
                //                                 ChartLine(time: 12, price: 23),
                //                               ],
                //                               animationDuration: 0,
                //                               xValueMapper:
                //                                   (ChartLine crypto, _) =>
                //                                       crypto.time,
                //                               yValueMapper:
                //                                   (ChartLine crypto, _) =>
                //                                       crypto.price,
                //                               color: AppTheme.errorColor,
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       children: [
                //                         Icon(
                //                           Icons.arrow_upward,
                //                           color: Colors.green,
                //                           size: 20,
                //                         ),
                //                         SizedBox(
                //                           width: 5.w,
                //                         ),
                //                         Text(
                //                           '5.2%',
                //                           style: AppTheme.textTheme.titleMedium,
                //                         )
                //                       ],
                //                     ),
                //                     Text(
                //                       '2.224232',
                //                       style: AppTheme.textTheme.titleLarge,
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           );
                //         }),
                //   ),
                // ),
                // SizedBox(height: 10.h,),
                // CommonHeading(
                //   hasButton: false,
                //   headingText: 'Top 5 by Market Cap',
                //   isNormalChild: true,
                //   isChild: Column(
                //     children: [
                //       TopFiveMarketCapWidget(),
                //       TopFiveMarketCapWidget(),
                //       TopFiveMarketCapWidget(),
                //       TopFiveMarketCapWidget(),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10.h,
                // ),
                //  CommonHeading(
                //   hasButton: false,
                //   headingText: 'Total Market Cap Today',
                //   isNormalChild: true,
                //   isChild: SizedBox(
                //     height: 120.h,
                //     child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: 3,
                //         itemBuilder: (context, index) {
                //           return Padding(
                //             padding: EdgeInsets.symmetric(horizontal: 10.w),
                //             child: GlassContainer(
                //               width: size.width - 230.w,
                //               child: Padding(
                //                 padding: EdgeInsets.symmetric(
                //                   horizontal: 20.w,
                //                   vertical: 10.h,
                //                 ),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                      Text(
                //                        '5.22334%',
                //                        style: AppTheme.textTheme.displaySmall,
                //                      ),
                //                     SizedBox(
                //                       height: 50.h,
                //                       child: Container(
                //                         margin: EdgeInsets.only(
                //                             right: AppTheme.elementSpacing),
                //                         width: AppTheme.cardPadding * 3.75.w,
                //                         color: Colors.transparent,
                //                         child: SfCartesianChart(
                //                           enableAxisAnimation: true,
                //                           plotAreaBorderWidth: 0,
                //                           primaryXAxis: CategoryAxis(
                //                               labelPlacement:
                //                                   LabelPlacement.onTicks,
                //                               edgeLabelPlacement:
                //                                   EdgeLabelPlacement.none,
                //                               isVisible: false,
                //                               majorGridLines:
                //                                   const MajorGridLines(
                //                                       width: 0),
                //                               majorTickLines:
                //                                   const MajorTickLines(
                //                                       width: 0)),
                //                           primaryYAxis: NumericAxis(
                //                             plotOffset: 0,
                //                             edgeLabelPlacement:
                //                                 EdgeLabelPlacement.none,
                //                             isVisible: false,
                //                             majorGridLines:
                //                                 const MajorGridLines(width: 0),
                //                             majorTickLines:
                //                                 const MajorTickLines(width: 0),
                //                           ),
                //                           series: <ChartSeries>[
                //                             LineSeries<ChartLine, double>(
                //                               dataSource: [
                //                                 ChartLine(time: 2, price: 3),
                //                                 ChartLine(time: 3, price: 24),
                //                                 ChartLine(time: 4, price: 5),
                //                                 ChartLine(time: 3, price: 34),
                //                                 ChartLine(time: 1, price: 4),
                //                                 ChartLine(time: 1, price: 14),
                //                                 ChartLine(time: 23, price: 23),
                //                                 ChartLine(time: 5, price: 40),
                //                                 ChartLine(time: 12, price: 13),
                //                                 ChartLine(time: 42, price: 14),
                //                                 ChartLine(time: 12, price: 34),
                //                                 ChartLine(time: 12, price: 23),
                //                               ],
                //                               animationDuration: 0,
                //                               xValueMapper:
                //                                   (ChartLine crypto, _) =>
                //                                       crypto.time,
                //                               yValueMapper:
                //                                   (ChartLine crypto, _) =>
                //                                       crypto.price,
                //                               color: AppTheme.errorColor,
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //
                //                      Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.start,
                //                       children: [
                //                         Icon(
                //                           Icons.arrow_upward,
                //                           color: Colors.green,
                //                           size: 20,
                //                         ),
                //                         SizedBox(
                //                           width: 5.w,
                //                         ),
                //                         Text(
                //                           '5.2%',
                //                           style: AppTheme.textTheme.titleMedium,
                //                         )
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           );
                //         }),
                //   ),
                // ),
                //
                 CommonHeading(
                  hasButton: false,
                  headingText: '',
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    width: size.width,
                    height: 244.w,
                    margin: EdgeInsets.only(bottom: AppTheme.cardPadding),
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                          autoPlay: kDebugMode ? false : true,
                          viewportFraction: 0.6,
                          enlargeCenterPage: true,
                          height: 244.w),
                      itemCount: nftHotProductSliderData.length,
                      itemBuilder: (context, index, index2) {
                        return NftProductSlider(
                          hasLikeButton: true,
                          hasPrice: true,
                          nftName: nftHotProductSliderData[index].nftName,
                          nftMainName:
                              nftHotProductSliderData[index].nftMainName,
                          cryptoText: nftHotProductSliderData[index].cryptoText,
                        );
                      },
                    ),
                  ),
                ),
                CommonHeading(
                  hasButton: true,
                  headingText: L10n.of(context)!.mostViewed,
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(bottom: 30.h),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 15 / 4.2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: mostViewListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MostView(
                          nftImg: mostViewListData[index].nftImg,
                          nftName: mostViewListData[index].nftName,
                          nftPrice: mostViewListData[index].nftPrice,
                        );
                      },
                    ),
                  ),
                ),
                CommonHeading(
                  hasButton: true,
                  customButtonIcon: Icons.info,
                  headingText: L10n.of(context)!.spotlightProjects,
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    width: size.width,
                    height: 170.h,
                    margin: EdgeInsets.only(bottom: 30.h),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          top: 0.0, bottom: 0.0, right: 12.w, left: 12.w),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: trendingSellersSliderData.length,
                      itemBuilder: (context, index) {
                        return TrendingSellersSlider(
                          nftImage: trendingSellersSliderData[index].nftImage,
                          userImage: trendingSellersSliderData[index].userImage,
                          nftName: trendingSellersSliderData[index].nftName,
                        );
                      },
                    ),
                  ),
                ),
                CommonHeading(
                  hasButton: true,
                  headingText: L10n.of(context)!.hotNewItems,
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    width: size.width,
                    height: 245.w,
                    margin: EdgeInsets.only(bottom: AppTheme.cardPadding.h),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          top: 0.0,
                          bottom: 0.0,
                          right: AppTheme.elementSpacing.w,
                          left: AppTheme.elementSpacing.w),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: nftHotProductSliderData.length,
                      itemBuilder: (context, index) {
                        return NftProductSlider(
                            encodedData:
                                nftHotProductSliderData[index].nftImage,
                            nftName: nftHotProductSliderData[index].nftName,
                            nftMainName:
                                nftHotProductSliderData[index].nftMainName,
                            cryptoText:
                                nftHotProductSliderData[index].cryptoText,
                            rank:
                                nftHotProductSliderData[index].rank.toString());
                      },
                    ),
                  ),
                ),
                CommonHeading(
                  hasButton: true,
                  headingText: L10n.of(context)!.forSale,
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    width: size.width,
                    height: 245.w,
                    margin: EdgeInsets.only(
                      bottom: 30.h,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          top: 0.0, bottom: 0.0, right: 12.w, left: 12.w),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: nftExpireProductSliderData.length,
                      itemBuilder: (context, index) {
                        return NftProductSlider(
                            encodedData:
                                nftExpireProductSliderData[index].nftImage,
                            nftName: nftExpireProductSliderData[index].nftName,
                            nftMainName:
                                nftExpireProductSliderData[index].nftMainName,
                            cryptoText:
                                nftExpireProductSliderData[index].cryptoText,
                            rank: nftExpireProductSliderData[index]
                                .rank
                                .toString());
                      },
                    ),
                  ),
                ),
                CommonHeading(
                  hasButton: true,
                  headingText: L10n.of(context)!.mostHypedNewDeals,
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    width: size.width,
                    height: 245.w,
                    margin: EdgeInsets.only(bottom: 30.h),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          top: 0.0, bottom: 0.0, right: 12.w, left: 12.w),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: nftExpensiveProductSliderData.length,
                      itemBuilder: (context, index) {
                        return NftProductSlider(
                            encodedData:
                                nftExpensiveProductSliderData[index].nftImage,
                            nftName:
                                nftExpensiveProductSliderData[index].nftName,
                            nftMainName: nftExpensiveProductSliderData[index]
                                .nftMainName,
                            cryptoText:
                                nftExpensiveProductSliderData[index].cryptoText,
                            rank: nftExpensiveProductSliderData[index]
                                .rank
                                .toString());
                      },
                    ),
                  ),
                ),
                CommonHeading(
                  hasButton: true,
                  headingText: L10n.of(context)!.newTopSellers,
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    width: size.width,
                    height: 245.w,
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          top: 0.0, bottom: 0.0, right: 12.w, left: 12.w),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: nftTopSellersProductSliderData.length,
                      itemBuilder: (context, index) {
                        return NftProductSlider(
                          medias: [],
                          nftName:
                              nftTopSellersProductSliderData[index].nftName,
                          nftMainName:
                              nftTopSellersProductSliderData[index].nftMainName,
                          cryptoText:
                              nftTopSellersProductSliderData[index].cryptoText,
                          rank: nftTopSellersProductSliderData[index]
                              .rank
                              .toString(),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 3.5,
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
                    child: Image.asset("assets/images/bitcoin.png")),
                SizedBox(width: AppTheme.elementSpacing.w / 1.5),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.of(context)!.bitcoin,
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
                        const SizedBox(width: 4),
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
                    ),Text(
                      '+5.2%',
                      style: AppTheme.textTheme.titleSmall!.copyWith(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
