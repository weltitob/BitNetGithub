import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/other_profile/other_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtherCenterWidgetIcon extends StatelessWidget {
  final IconData iconData;
  final int index;
  final Function() onTap;
  const OtherCenterWidgetIcon({required this.iconData, required this.index, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtherProfileController>();
    return Obx(() {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppTheme.cardPadding * 2.5.w,
          height: AppTheme.cardPadding * 1.75.h,
          child: Icon(
            iconData,
            size: AppTheme.iconSize,
            color: controller.currentview.value == index
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
          ),
        ),
      );
    });
  }
}
