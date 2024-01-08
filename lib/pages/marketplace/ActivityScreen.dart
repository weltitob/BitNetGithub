import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/BarChart.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:bitnet/components/marketplace_widgets/TradingHistoryList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);
  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  bool openChart = true;
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                    margin: EdgeInsets.only(bottom: 5.h),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    width: size.width,
                    child: Text(
                      'Activities',
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
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum text of the printing and typesetting industry.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: const CommonHeading(
                      headingText: 'Price History',
                      hasButton: false,
                      collapseBtn: true,
                      child: BarChart()
                    ),
                  ),
                  CommonHeading(
                    headingText: 'Trading History',
                    hasButton: false,
                    isNormalChild: true,
                    isChild: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0.0),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: tradingHistoryListData.length,
                        itemBuilder: (context, index) {
                          return TradingHistoryList(
                            nftImage: tradingHistoryListData[index].nftImage,
                            nftName: tradingHistoryListData[index].nftName,
                            fromText: tradingHistoryListData[index].fromText,
                            toText: tradingHistoryListData[index].toText,
                            cryptoIcon: tradingHistoryListData[index].cryptoIcon,
                            cryptoText: tradingHistoryListData[index].cryptoText,
                            dateText: tradingHistoryListData[index].dateText,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const StatusBarBg()
        ],
      ),
    );
  }
}
