import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
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

    return GestureDetector(
      onTap: onTap,
      child: Obx(() {
        final bool isSelected = (controller.currentview.value == index);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isSelected) ...[
            Container(
              color: Colors.transparent,
              width: AppTheme.cardPadding * 1.75.h,
              height: AppTheme.cardPadding * 1.75.h,
              child: Icon(
                iconData,
                size: AppTheme.iconSize,
                color: isSelected
                    ? Colors.black
                    : theme.colorScheme.onPrimaryContainer.withOpacity(0.4),
              ),
            ),
            ],
            if (isSelected) ...[
              Container(
                width: AppTheme.cardPadding * 1.75.h,
                height: AppTheme.cardPadding * 1.75.h,
                child: RoundedButtonWidget(
                  size: AppTheme.cardPadding * 1.75.h,
                    buttonType:
                    ButtonType.transparent,
                    iconData: iconData, onTap: onTap

                ),
              )
              // SizedBox(width: (AppTheme.elementSpacing * 0.4).w),
              // Text(
              //   label,
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 12.sp, // Slightly smaller text
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ],
        );
      }),
    );
  }
}
