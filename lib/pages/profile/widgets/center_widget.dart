import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
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
      bottom: AppTheme.cardPadding,
      child: Container(
        height: AppTheme.cardPadding * 1.75,
        width: AppTheme.cardPadding * 10,
        decoration: BoxDecoration(
          borderRadius: AppTheme.cardRadiusBigger,
          boxShadow: [AppTheme.boxShadowProfile],
        ),
        child: GlassContainer(
          borderThickness: 1.5, // remove border if not active
          blur: 50,
          opacity: 0.1,
          borderRadius: AppTheme.cardRadiusBigger,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CenterWidgetIcon(
                iconData: Icons.table_rows_rounded,
                index: 0,
                onTap: () {
                  controller.currentview.value = 0;
                },
              ),
              CenterWidgetIcon(
                iconData: Icons.wallet,
                index: 1,
                onTap: () {
                  controller.currentview.value = 1;
                },
              ),
              GestureDetector(
                onTap: () {
                  controller.currentview.value = 2;
                },
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.greenAccent[700],
                      borderRadius: AppTheme.cardRadiusSmall),
                  child: Icon(
                    Icons.edit,
                    // isProfileOwner ? Icons.edit : Icons.person_add_rounded,
                    size: AppTheme.iconSize,
                    color: controller.currentview.value == 2
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer
                            .withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
