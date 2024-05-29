import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/MostView.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:bitnet/components/marketplace_widgets/TrendingSellersSlider.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return bitnetScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 0.1,
                ),
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
                          autoPlay: true,
                          viewportFraction: 0.6,
                          enlargeCenterPage: true,
                          height: 244.w),
                      // padding: EdgeInsets.only(
                      //     top: 0.0,
                      //     bottom: 0.0,
                      //     right: AppTheme.elementSpacing,
                      //     left: AppTheme.elementSpacing),
                      // shrinkWrap: true,
                      // physics: const BouncingScrollPhysics(),
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
                  headingText: 'Most Viewed',
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
                  headingText: 'Spotlight Projects',
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
                  headingText: 'Hot New Items',
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
                  headingText: 'For sale',
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
                  headingText: 'Most Hyped New Deals',
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
                  headingText: 'New Top Sellers',
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
                          // encodedData:
                          //     nftTopSellersProductSliderData[index].nftImage,

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
