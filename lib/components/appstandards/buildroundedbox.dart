import 'dart:ui';

import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class RoundedContainer extends StatefulWidget {
  Widget child;
  RoundedContainer({super.key,
    required this.child,});

  @override
  State<RoundedContainer> createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
      child: GlassContainer(
        borderThickness: 1.5, // remove border if not active
        blur: 50,
        opacity: 0.1,
        borderRadius: AppTheme.cardRadiusMid,
        child: Container(
            padding: const EdgeInsets.only(
                top: AppTheme.elementSpacing,
                bottom: AppTheme.elementSpacing,
                left: AppTheme.cardPadding,
                right: AppTheme.cardPadding),
            decoration: BoxDecoration(
                boxShadow: [
                  AppTheme.boxShadowProfile
                ],
                borderRadius: AppTheme.cardRadiusBig),
            child: widget.child
        ),
      ),
    );
  }
}