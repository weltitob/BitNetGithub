import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CenterWidgetIcon extends StatelessWidget {
  final IconData iconData;
  final String label;
  final int index;
  final VoidCallback onTap;

  const CenterWidgetIcon({
    Key? key,
    required this.iconData,
    required this.index,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final theme = Theme.of(context);

    return Obx(() {
      final bool isSelected = (controller.currentview.value == index);

      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 60.w,
          height: 40.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Icon(
                iconData,
                size: 26,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.5),
              ),

              // Indicator bar
              AnimatedContainer(
                duration: AppTheme.animationDuration,
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(top: 6),
                height: 3,
                width: isSelected ? 28 : 0,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
