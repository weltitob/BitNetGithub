import 'dart:ui';

import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class RoundedButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  final ButtonType buttonType;
  final double size;

  const RoundedButtonWidget({
    super.key,
    required this.iconData,
    required this.onTap,
    this.buttonType = ButtonType.solid,
    this.size = AppTheme.cardPadding * 2,
  });

  @override
  Widget build(BuildContext context) {
    final containerHeight = size;
    final containerWidth = size;
    final borderRadius = BorderRadius.circular(size / 2.5);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: AppTheme.cardRadiusSmall,
        onTap: onTap,
        child: Container(
            height: containerHeight,
            width: containerWidth,
            child: GlassContainer(
              borderThickness: 1.5, // remove border if not active
              blur: 50,
              opacity: 0.1,
              borderRadius: borderRadius,
              child: Icon(
                iconData,
                color: buttonType == ButtonType.solid
                    ? AppTheme.white90
                    : Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            )),
      ),
    );
  }
}
