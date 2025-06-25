import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertieList extends StatelessWidget {
  final heading;
  final subHeading;
  final peragraph;

  const PropertieList(
      {Key? key,
      required this.heading,
      required this.subHeading,
      this.peragraph})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.withAlpha(50)
            : const Color.fromRGBO(255, 255, 255, 0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: Text(
              heading,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(bottom: 6.h),
          //   child: Text(
          //     subHeading,
          //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //       fontSize: 12.sp,
          //       fontWeight: FontWeight.w400,
          //      ),
          //   ),
          // ),
          Text(
            subHeading,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ],
      ),
    );
  }
}
