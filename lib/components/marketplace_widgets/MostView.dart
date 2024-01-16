
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostView extends StatefulWidget {
  final nftImg;
  final nftName;
  final nftPrice;

  const MostView(
      {Key? key,
      required this.nftImg,
      required this.nftName,
      required this.nftPrice})
      : super(key: key);

  @override
  State<MostView> createState() => _MostViewState();
}

class _MostViewState extends State<MostView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Image.asset(
            widget.nftImg,
            width: 44.w,
            height: 44.w,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  child: Text(
                    widget.nftName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(249, 249, 249, 1),
                    ),
                  ),
                ),
                Text(
                  widget.nftPrice,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}