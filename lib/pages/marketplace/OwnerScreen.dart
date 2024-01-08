import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/FilterBtn.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;


class OwnerScreen extends StatefulWidget {
  const OwnerScreen({Key? key}) : super(key: key);
  @override
  State<OwnerScreen> createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen> {
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
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Header(
                      leftIconWidth: 36.w,
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
                      rightIcon: GestureDetector(
                        onTap: () {},
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
                                shareIcon,
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
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 38.h),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(
                              nftImage5,
                              width: size.width,
                              height: 185.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: SizedBox(
                            width: size.width,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: Image.asset(
                                  user1Image,
                                  width: 75.w,
                                  height: 75.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          route.kOwnerDetailScreenRoute
                        );
                      },
                      child: Text(
                        'Crypto-Pills',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        OwnerDataText(
                          ownerDataText: '78',
                          ownerDataTitle: 'Items',
                          hasText: true,
                        ),
                        OwnerDataText(
                          ownerDataText: '54',
                          ownerDataTitle: 'Owners',
                          hasText: true,
                        ),
                        OwnerDataText(
                          ownerDataText: '60',
                          ownerDataTitle: 'Floor Price',
                          hasText: true,
                        ),
                        OwnerDataText(
                          ownerDataText: '1.07k',
                          ownerDataTitle: 'Traded',
                          hasText: true,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const OwnerDataText(
                          ownerDataImg: discordIcon,
                          ownerDataTitle: 'Discord',
                          hasImage: true,
                        ),
                        const OwnerDataText(
                          ownerDataImg: twitterIcon,
                          ownerDataTitle: 'Twitter',
                          hasImage: true,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              route.kActivityScreenRoute
                            );
                          },
                          child: const OwnerDataText(
                            ownerDataImg: activityIcon,
                            ownerDataTitle: 'Activity',
                            hasImage: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonHeading(
                    headingText: 'Recently Listed',
                    hasButton: false,
                    isNormalChild: true,
                    isChild: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 4 / 5.7,
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
                            nftImage: gridListData[index].nftImage,
                            nftName: gridListData[index].nftName,
                            nftMainName: gridListData[index].nftMainName,
                            cryptoImage: gridListData[index].cryptoImage,
                            cryptoText: gridListData[index].cryptoText,
                            columnMargin: gridListData[index].columnMargin,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const FilterBtn(),
          const StatusBarBg()
        ],
      ),
    );
  }
}
