import 'dart:ui';

import 'package:BitNet/components/container/glassmorph.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';

class RoundedButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  final bool isGlassmorph;

  const RoundedButtonWidget({
    super.key,
    required this.iconData,
    required this.onTap,
    required this.isGlassmorph,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppTheme.cardRadiusSmall,
      onTap: onTap,
      child: Container(
          height: AppTheme.cardPadding * 2,
          width: AppTheme.cardPadding * 2,
          child: Glassmorphism(
            gradientBegin: Alignment.topLeft,
            gradientEnd: Alignment.bottomRight,
            blur: 200,
            opacity: 0.2,
            radius: AppTheme.cardPaddingSmall,
            child: Icon(
              iconData,
              color: isGlassmorph
                  ? AppTheme.white90
                  : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          )),
    );
  }
}
