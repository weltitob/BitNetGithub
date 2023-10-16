import 'dart:ui';

import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class RoundedButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  final ButtonType buttonType;

  const RoundedButtonWidget({
    super.key,
    required this.iconData,
    required this.onTap,
    this.buttonType = ButtonType.solid,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        borderRadius: AppTheme.cardRadiusSmall,
        onTap: onTap,
        child: Container(
            height: AppTheme.cardPadding * 2,
            width: AppTheme.cardPadding * 2,
            child: GlassContainer(
              borderThickness: 1.5, // remove border if not active
              blur: 50,
              opacity: 0.1,
              borderRadius: AppTheme.cardRadiusMid,
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
