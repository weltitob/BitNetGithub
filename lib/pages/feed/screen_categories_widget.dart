import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ScreenCategoryWidget extends StatelessWidget {
  final String image;
  final String text;
  final String header;
  final int index;
  ScreenCategoryWidget(
      {required this.image,
      required this.text,
      required this.header,
      required this.index,
      super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    return Container(
      margin: EdgeInsets.only(
        right: 10,
        top: 10,
        bottom: 10,
        left: 3,
      ),
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: AppTheme.cardRadiusMid,
        boxShadow: [
          AppTheme.boxShadowSmall,
        ],
      ),
      child: Transform.scale(
        scale: index == controller.tabController?.index ? 1 : 0.9,
        child: GlassContainer(
          borderThickness: index == controller.tabController?.index ? 3 : 1.5,
          child: InkWell(
              borderRadius: AppTheme.cardRadiusMid,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 35.h,
                    width: 35.w,
                    child: Image.asset(image),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(text,
                        style: Theme.of(context).textTheme.labelLarge),
                  )
                ],
              ),
              onTap: () {
                () {
                  controller.tabController?.animateTo(index);
                };
              }),
        ),
      ),
    );
  }
}
