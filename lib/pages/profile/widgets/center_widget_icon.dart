import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CenterWidgetIcon extends StatelessWidget {
  final IconData iconData;
  final int index;
  final Function() onTap;
  CenterWidgetIcon(
      {required this.iconData,
      required this.index,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.greenAccent[700],
            borderRadius: AppTheme.cardRadiusBig,
          ),
          child: Icon(
            iconData,
            size: AppTheme.iconSize,
            color: controller.currentview.value == index
                ? Theme.of(context).colorScheme.onSecondaryContainer
                : Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.3),
          ),
        ));
  }
}
