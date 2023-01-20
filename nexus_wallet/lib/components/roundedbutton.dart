import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nexus_wallet/theme.dart';

class RoundedButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  final bool isGlassmorph;

  const RoundedButtonWidget({super.key,
    required this.iconData,
    required this.onTap,
    required this.isGlassmorph,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppTheme.cardRadiusSmall,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: AppTheme.cardRadiusSmall,
              color: isGlassmorph ? AppTheme.glassMorphColor : Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: InkWell(
              borderRadius: AppTheme.cardRadiusSmall,
              onTap: onTap,
              child: Icon(
                iconData,
                color: isGlassmorph ? AppTheme.white90 : Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            )),
      ),
    );
  }
}