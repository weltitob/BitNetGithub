import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double opacity;
  final double? height;
  final double? width;
  final double blurX;
  final double blurY;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    Key? key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.opacity = 0.1,
    this.height,
    this.width,
    this.blurX = 5,
    this.blurY = 5,
    this.border,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: border,
          boxShadow: boxShadow,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurX, sigmaY: blurY),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius ?? 12),
            ),
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}