
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradingHistoryList extends StatelessWidget {
  final nftImage;
  final nftName;
  final fromText;
  final toText;
  final cryptoIcon;
  final cryptoText;
  final dateText;

  const TradingHistoryList(
      {Key? key,
      required this.nftImage,
      required this.nftName,
      this.fromText,
      this.toText,
      this.cryptoIcon,
      this.cryptoText,
      this.dateText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 15.w),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                nftImage,
                fit: BoxFit.cover,
                width: 60.w,
                height: 60.w,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5.h),
                      child: Text(
                        nftName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(249, 249, 249, 1),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'From: ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(255, 255, 255, 0.6),
                            ),
                          ),
                          Text(
                            fromText,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(255, 255, 255, 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'To: ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(255, 255, 255, 0.6),
                          ),
                        ),
                        Text(
                          toText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  padding: EdgeInsets.only(
                      top: 5.h, bottom: 4.h, right: 10.w, left: 10.w),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 6.w),
                        child: Image.asset(
                          cryptoIcon,
                          height: 12.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        cryptoText,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(255, 255, 255, 0.7),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Text(
                    dateText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(255, 255, 255, 0.6),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
