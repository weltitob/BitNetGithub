import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/NotificationList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: const Color.fromRGBO(24, 31, 39, 1),
        padding: EdgeInsets.only(top: statusBarHeight + 56.h),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: notificationListData.length,
                  itemBuilder: (context, index) {
                    return NotificationList(
                      notificationImg: notificationListData[index].notificationImage,
                      notificationText: notificationListData[index].notificationText,
                      notificationTime: notificationListData[index].notificationTime,
                      headingColor: notificationListData[index].headingColor,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
