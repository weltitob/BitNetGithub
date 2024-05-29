import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/FilterBtn.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerDetailScreen extends StatefulWidget {
  const OwnerDetailScreen({Key? key}) : super(key: key);
  @override
  State<OwnerDetailScreen> createState() => _OwnerDetailScreenState();
}

class _OwnerDetailScreenState extends State<OwnerDetailScreen> {
  bool likeNft1 = false;
  bool likeNft2 = false;
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
                    child: Text(
                      'Crypto-Pills',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(bottom: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0x316f0fe93ca9dc1e119c2...',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(255, 255, 255, 0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              const ClipboardData(
                                  text: "0x316f0fe93ca9dc1e119c2..."),
                            );
                          },
                          child: Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.1),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 7.w),
                            margin: EdgeInsets.only(left: 19.w),
                            child: Image.asset(
                              paperPlusIcon,
                              width: 10.w,
                              height: 12.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(bottom: 30.h),
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
                            left: 20.w, bottom: 12.h, top: 12.h, right: 20.w),
                        hintText: "Search items and collections",
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
                  Container(
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
                      itemCount: gridListData.length.clamp(0, 2),
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
