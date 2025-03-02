import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/components/marketplace_widgets/FilterBtn.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: const Color.fromRGBO(24, 31, 39, 1),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Header(
                      leftIconWidth: 50.w,
                      leftIcon: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, route.kMainScreenRoute);
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
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: Text(
                      L10n.of(context)!.search,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              searchLineIcon,
                              width: 24.w,
                              height: 24.w,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20.w,
                          bottom: 12.h,
                          top: 12.h,
                          right: 20.w,
                        ),
                        hintText: L10n.of(context)!.searchItemsAndCollections,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(255, 255, 255, 0.5),
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
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
                      return AssetCard(
                          encodedData: gridListData[index].nftImage,
                          nftName: gridListData[index].nftName,
                          nftMainName: gridListData[index].nftMainName,
                          cryptoText: gridListData[index].cryptoText,
                          rank: gridListData[index].rank);
                    },
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
