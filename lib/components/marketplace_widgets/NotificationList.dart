import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationList extends StatelessWidget {
  final notificationText;
  final notificationImg;
  final notificationTime;
  final headingColor;

  const NotificationList(
      {Key? key,
      this.notificationImg,
      this.notificationText = '',
      this.notificationTime = '',
      this.headingColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: 15.h),
      margin: EdgeInsets.only(bottom: 15.h),
      width: size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : const Color.fromRGBO(255, 255, 255, 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.r),
              child: Image.asset(notificationImg, width: 32.w, height: 32.w),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  child: Text(
                    notificationText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: headingColor,
                    ),
                  ),
                ),
                Text(
                  notificationTime,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
