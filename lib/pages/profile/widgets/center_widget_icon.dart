import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
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
    return IconButton(
      enableFeedback: false,
      splashColor: Colors.transparent,
      icon: Icon(iconData, size: AppTheme.iconSize,),
      onPressed: onTap,
      color: controller.currentview.value == index
          ? Theme.of(context).colorScheme.onSecondaryContainer
          : Theme.of(context)
              .colorScheme
              .onSecondaryContainer
              .withOpacity(0.3),
    );
  }
}
