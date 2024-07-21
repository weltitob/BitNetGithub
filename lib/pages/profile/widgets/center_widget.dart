import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/center_widget_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Positioned(
      bottom: 0,
      child: Container(
        height: AppTheme.cardPadding * 2,
        width: AppTheme.cardPadding * 10,
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
                CenterWidgetIcon(
                  iconData: Icons.table_rows_rounded,
                  index: 0,
                  onTap: () {
                    controller.currentview.value = 0;
                  },
                ),
                CenterWidgetIcon(
                  iconData: Icons.view_column_rounded,
                  index: 1,
                  onTap: () {
                    controller.currentview.value = 1;
                  },
                ),
                CenterWidgetIcon(
                  iconData: Icons.edit,
                  index: 2,
                  onTap: () {
                    controller.currentview.value = 2;
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
