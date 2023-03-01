import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import '../../../theme.dart';

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
      child: Glassmorphism(
        blur: 20,
        opacity: 0.1,
        radius: AppTheme.cardPadding,
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