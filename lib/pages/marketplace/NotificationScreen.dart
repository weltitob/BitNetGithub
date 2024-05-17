import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/marketplace_widgets/NotificationList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


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
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        customTitle: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        onTap: () {
          context.pop();
        },
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(2.0),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: notificationListData.length,
                  itemBuilder: (context, index) {
                    return NotificationList(
                      notificationImg:
                          notificationListData[index].notificationImage,
                      notificationText:
                          notificationListData[index].notificationText,
                      notificationTime:
                          notificationListData[index].notificationTime,
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
