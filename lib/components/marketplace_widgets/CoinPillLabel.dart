import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinPillLabel extends StatefulWidget {
  final coinImg;
  final labelText;

  const CoinPillLabel(
      {Key? key, required this.coinImg, required this.labelText})
      : super(key: key);

  @override
  State<CoinPillLabel> createState() => _CoinPillLabelState();
}

class _CoinPillLabelState extends State<CoinPillLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: const Color.fromRGBO(255, 255, 255, 0.1),
      ),
      padding: EdgeInsets.only(top: 5.w, bottom: 4.w, left: 10.w, right: 10.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 6.w),
            child: Image.asset(
              widget.coinImg,
              height: 12.w,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            widget.labelText,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(249, 249, 249, 1),
            ),
          ),
        ],
      ),
    );
  }
}
