import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/other_profile/other_profile_controller.dart';
import 'package:bitnet/pages/other_profile/widgets/center_widget_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherCenterWidget extends StatelessWidget {
  const OtherCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtherProfileController>();
    return Positioned(
      bottom: 0,
      child: Container(
        height: AppTheme.cardPadding * 2,
        width: AppTheme.cardPadding * 12,
        decoration: BoxDecoration(
          borderRadius: AppTheme.cardRadiusBigger,
          boxShadow: [AppTheme.boxShadowProfile],
        ),
        child: GlassContainer(
          borderThickness: 1.5, // remove border if not active
          blur: 50,
          opacity: 0.1,
          borderRadius: BorderRadius.only(
            bottomLeft: AppTheme.cornerRadiusMid,
            bottomRight: AppTheme.cornerRadiusMid,
            topLeft: AppTheme.cornerRadiusMid,
            topRight: AppTheme.cornerRadiusMid,
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OtherCenterWidgetIcon(
                  iconData: Icons.table_rows_rounded,
                  index: 0,
                  onTap: () {
                    controller.currentview.value = 0;
                  },
                ),
                OtherCenterWidgetIcon(
                  iconData: Icons.view_column_rounded,
                  index: 1,
                  onTap: () {
                    controller.currentview.value = 1;
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
