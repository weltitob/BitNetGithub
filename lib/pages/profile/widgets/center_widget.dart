import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/center_widget_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final double containerWidth =
        MediaQuery.of(context).size.width ;

    return Positioned(
      bottom: 0,
      child: Container(
        width: containerWidth,
        // Add a bit of padding at the bottom for safe area and spacing

        child: Container(

          width: containerWidth,
          height: (AppTheme.cardPadding * 2).h,
          padding: EdgeInsets.symmetric(
            horizontal: (AppTheme.cardPadding * 0.8).w,
          ),
          // Wrap Row in SingleChildScrollView to prevent overflow
          child: Row(
            // SpaceAround can cause unexpected spacing on small devices.
            // Switch to spaceEvenly or start if you prefer
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CenterWidgetIcon(
                label: 'Table',
                iconData: Icons.table_rows_rounded,
                index: 0,
                onTap: () => controller.currentview.value = 0,
              ),
              CenterWidgetIcon(
                label: 'Column',
                iconData: Icons.view_column_rounded,
                index: 1,
                onTap: () => controller.currentview.value = 1,
              ),
              CenterWidgetIcon(
                label: 'Alerts',
                iconData: Icons.notifications,
                index: 2,
                onTap: () => controller.currentview.value = 2,
              ),
              CenterWidgetIcon(
                label: 'Edit',
                iconData: Icons.edit,
                index: 3,
                onTap: () => controller.currentview.value = 3,
              ),
              // Add more icons if needed
            ],
          ),
        ),
      ),
    );
  }
}
