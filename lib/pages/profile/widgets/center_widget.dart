import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/center_widget_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final double containerWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Positioned(
      bottom: 0,
      child: Container(
        width: containerWidth,
        height: AppTheme.cardPadding * 2.8.h,
        margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -2),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 40,
              offset: const Offset(0, -8),
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.elementSpacing.w,
            vertical: AppTheme.elementSpacing.h * 0.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CenterWidgetIcon(
                  label: 'Table',
                  iconData: Icons.table_rows_rounded,
                  index: 0,
                  onTap: () => controller.currentview.value = 0,
                ),
              ),
              Expanded(
                child: CenterWidgetIcon(
                  label: 'Column',
                  iconData: Icons.view_column_rounded,
                  index: 1,
                  onTap: () => controller.currentview.value = 1,
                ),
              ),
              Expanded(
                child: CenterWidgetIcon(
                  label: 'Alerts',
                  iconData: Icons.notifications_outlined,
                  index: 2,
                  onTap: () => controller.currentview.value = 2,
                ),
              ),
              Expanded(
                child: CenterWidgetIcon(
                  label: 'Liked',
                  iconData: FontAwesomeIcons.heart,
                  index: 3,
                  onTap: () => controller.currentview.value = 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}