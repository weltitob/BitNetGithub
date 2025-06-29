import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/center_widget_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final double containerWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;

    // Get colors for the indicator based on theme
    final Color indicatorColor = isLightMode
        ? Colors.black.withOpacity(0.2)
        : Colors.white.withOpacity(0.2);

    return Positioned(
      bottom: 0,
      child: Container(
        width: containerWidth,
        height: 65,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              iconData: Icons.notifications_outlined,
              index: 2,
              onTap: () => controller.currentview.value = 2,
            ),
            CenterWidgetIcon(
              label: 'Liked',
              iconData: FontAwesomeIcons.heart,
              index: 3,
              onTap: () => controller.currentview.value = 3,
            ),
          ],
        ),
      ),
    );
  }
}
