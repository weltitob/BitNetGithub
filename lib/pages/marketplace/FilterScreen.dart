import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/CoinPillLabel.dart';
import 'package:bitnet/components/marketplace_widgets/CollectionList.dart';
import 'package:bitnet/components/marketplace_widgets/CommonBtn.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/FilterPillList.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String dropDownValue = 'United States Dollar (USD)';
  var items = [
    'United States Dollar (USD)',
    'Last 1 Month',
    'Last 6 Months',
    'Last 1 Year',
  ];
  bool openPrice = true;
  bool openCollections = true;
  bool openChain = true;
  bool openOnSale = true;
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
              padding: EdgeInsets.only(bottom: 80.w, left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
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
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FilterPillList(
                    headingText: 'Status',
                    listDataText: statusPillListData,
                  ),
                  CommonHeading(
                    headingText: 'Price',
                    hasButton: false,
                    collapseBtn: true,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30.h),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: const Color.fromRGBO(255, 255, 255, 0.1),
                            ),
                            width: size.width,
                            margin: EdgeInsets.only(bottom: 15.h),
                            child: DropdownButton(
                              value: dropDownValue,
                              icon: Container(
                                width: 18.w,
                                height: 18.w,
                                padding: EdgeInsets.symmetric(
                                    vertical: 7.w, horizontal: 5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.1),
                                ),
                                child: Image.asset(
                                  bottomArrowIcon,
                                  width: 7.w,
                                  height: 3.5.w,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              dropdownColor:
                                  const Color.fromRGBO(24, 31, 39, 1),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    width: size.width - 78.w,
                                    child: Text(
                                      items,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.5),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.7),
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 20.w,
                                      bottom: 12.h,
                                      top: 12.h,
                                      right: 20.w,
                                    ),
                                    hintText: "Min",
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.7),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.1),
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
                                margin:
                                    EdgeInsets.only(left: 10.w, right: 11.w),
                                child: Text(
                                  'To',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.5),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.7),
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 20.w,
                                      bottom: 12.h,
                                      top: 12.h,
                                      right: 20.w,
                                    ),
                                    hintText: "Max",
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.7),
                                    ),
                                    filled: true,
                                    fillColor: const Color.fromRGBO(
                                        255, 255, 255, 0.1),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  FilterPillList(
                    headingText: 'Sort By',
                    listDataText: sortByPillListData,
                  ),
                  CommonHeading(
                    headingText: 'Collections',
                    hasButton: false,
                    collapseBtn: true,
                    child: Column(
                      children: [
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
                              hintText: "Filter",
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromRGBO(255, 255, 255, 0.1),
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
                          width: size.width,
                          margin: EdgeInsets.only(bottom: 15.h),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: collectionListData.length,
                            itemBuilder: (context, index) {
                              return CollectionList(
                                collectionImg:
                                    collectionListData[index].collectionImg,
                                collectionName:
                                    collectionListData[index].collectionName,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonHeading(
                    headingText: 'Chains',
                    hasButton: false,
                    collapseBtn: true,
                    child: Container(
                      width: size.width,
                      margin: EdgeInsets.only(bottom: 30.h),
                      child: Wrap(
                        spacing: 15.w,
                        runSpacing: 15.w,
                        children: List.generate(
                          chainListData.length,
                          (index) {
                            return CoinPillLabel(
                              coinImg: chainListData[index].coinImg,
                              labelText: chainListData[index].labelText,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  FilterPillList(
                    headingText: 'Categories',
                    listDataText: categoriesLabelListData,
                  ),
                  CommonHeading(
                    headingText: 'On Sale In',
                    hasButton: false,
                    collapseBtn: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  right: 20.w),
                              hintText: "Filter",
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromRGBO(255, 255, 255, 0.1),
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
                          margin: EdgeInsets.only(bottom: 15.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: const Color.fromRGBO(255, 255, 255, 0.1),
                          ),
                          padding: EdgeInsets.only(
                              top: 5.w, bottom: 4.w, left: 10.w, right: 10.w),
                          child: Text(
                            'Bitcoin',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(255, 255, 255, 0.7),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: const Color.fromRGBO(255, 255, 255, 0.1),
                          ),
                          padding: EdgeInsets.only(
                              top: 5.w, bottom: 4.w, left: 10.w, right: 10.w),
                          child: Text(
                            'Ethereum',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(255, 255, 255, 0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            child: Container(
              width: size.width - 40.w,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: const CommonBtn(
                  hasOnPress: false, text: 'Apply', hasBackPress: true),
            ),
          ),
          const StatusBarBg()
        ],
      ),
    );
  }
}
