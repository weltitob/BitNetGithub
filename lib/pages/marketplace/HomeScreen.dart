import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/MostView.dart';
import 'package:bitnet/components/marketplace_widgets/NftDropSlider.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:bitnet/components/marketplace_widgets/TrendingSellersSlider.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                  height: AppTheme.cardPadding * 1,
                ),
                CommonHeading(
                  hasButton: true,
                  headingText: 'Latest NFT Drops',
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    width: size.width,
                    height: 150.w,
                    margin: EdgeInsets.only(bottom: AppTheme.cardPadding),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          top: 0.0,
                          bottom: 0.0,
                          right: AppTheme.elementSpacing,
                          left: AppTheme.elementSpacing),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: nftDropSliderData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => context.goNamed(kNftProductScreenRoute,
                              pathParameters: {
                                'nft_id': nftDropSliderData[index].nftName
                              }),
                          child: NftDropSlider(
                            nftImage: nftDropSliderData[index].nftImage,
                            nftName: nftDropSliderData[index].nftName,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                CommonHeading(
                  hasButton: true,
                  headingText: 'Trending Collections',
                  onPress: route.kListScreenRoute,
                  isNormalChild: true,
                  isChild: Container(
                    width: size.width,
                    height: 185.h,
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
                  headingText: 'Hot New Items',
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
                      itemCount: nftHotProductSliderData.length,
                      itemBuilder: (context, index) {
                        return NftProductSlider(
                            nftImage: nftHotProductSliderData[index].nftImage,
                            cryptoImage:
                                nftHotProductSliderData[index].cryptoImage,
                            nftName: nftHotProductSliderData[index].nftName,
                            nftMainName:
                                nftHotProductSliderData[index].nftMainName,
                            cryptoText:
                                nftHotProductSliderData[index].cryptoText,
                            columnMargin:
                                nftHotProductSliderData[index].columnMargin,
                            rank: nftHotProductSliderData[index].rank);
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
                            nftImage:
                                nftExpireProductSliderData[index].nftImage,
                            cryptoImage:
                                nftExpireProductSliderData[index].cryptoImage,
                            nftName: nftExpireProductSliderData[index].nftName,
                            nftMainName:
                                nftExpireProductSliderData[index].nftMainName,
                            cryptoText:
                                nftExpireProductSliderData[index].cryptoText,
                            columnMargin:
                                nftExpireProductSliderData[index].columnMargin,
                            rank: nftExpireProductSliderData[index].rank);
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
                            nftImage:
                                nftExpensiveProductSliderData[index].nftImage,
                            cryptoImage: nftExpensiveProductSliderData[index]
                                .cryptoImage,
                            nftName:
                                nftExpensiveProductSliderData[index].nftName,
                            nftMainName: nftExpensiveProductSliderData[index]
                                .nftMainName,
                            cryptoText:
                                nftExpensiveProductSliderData[index].cryptoText,
                            columnMargin: nftExpensiveProductSliderData[index]
                                .columnMargin,
                            rank: nftExpensiveProductSliderData[index].rank);
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
                            nftImage:
                                nftTopSellersProductSliderData[index].nftImage,
                            cryptoImage: nftTopSellersProductSliderData[index]
                                .cryptoImage,
                            nftName:
                                nftTopSellersProductSliderData[index].nftName,
                            nftMainName: nftTopSellersProductSliderData[index]
                                .nftMainName,
                            cryptoText: nftTopSellersProductSliderData[index]
                                .cryptoText,
                            columnMargin: nftTopSellersProductSliderData[index]
                                .columnMargin,
                            rank: nftTopSellersProductSliderData[index].rank);
                      },
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding * 3.5),
              ],
            ),
          ),
          const StatusBarBg()
        ],
      ),
      context: context,
    );
  }
}
