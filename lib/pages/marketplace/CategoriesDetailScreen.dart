import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/FilterBtn.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/components/marketplace_widgets/TrendingSellersSlider.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CategoriesDetailScreen extends StatefulWidget {
  const CategoriesDetailScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesDetailScreen> createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  bool likeNft = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: const Color.fromRGBO(24, 31, 39, 1),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Header(
                      leftIconWidth: 50.w,
                      leftIcon: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 0.1),
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              padding: EdgeInsets.all(10.w),
                              child: Image.asset(
                                backArrowIcon,
                                width: 18.w,
                                height: 15.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      L10n.of(context)!.art,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur volutpat hendrerit turpis sed maximus.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                  ),
                  CommonHeading(
                    headingText: L10n.of(context)!.trendingSellers,
                    hasButton: true,
                    onPress: route.kListScreenRoute,
                    isNormalChild: true,
                    isChild: Container(
                      width: size.width,
                      height: 166.w,
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
                            userImage:
                                trendingSellersSliderData[index].userImage,
                            nftName: trendingSellersSliderData[index].nftName,
                          );
                        },
                      ),
                    ),
                  ),
                  CommonHeading(
                    headingText: L10n.of(context)!.allItems,
                    hasButton: false,
                    isNormalChild: true,
                    isChild: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 4 / 5.9,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          crossAxisCount: 2,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: gridListData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NftProductSlider(
                              encodedData: gridListData[index].nftImage,
                              nftName: gridListData[index].nftName,
                              nftMainName: gridListData[index].nftMainName,
                              cryptoText: gridListData[index].cryptoText,
                              rank: gridListData[index].rank);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const FilterBtn(),
          // const StatusBarBg()
        ],
      ),
    );
  }
}
