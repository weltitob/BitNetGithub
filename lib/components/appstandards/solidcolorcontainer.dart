import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:flutter/material.dart';

Widget solidContainer({
  required BuildContext context,
  List<Color>? gradientColors,
  double? height,
  double? width,
  AlignmentGeometry? alignment,
  double? borderRadius,
  AlignmentGeometry? gradientBegin,
  AlignmentGeometry? gradientEnd,
  bool normalPainter = true,
  double borderWidth = 1.5,
  required Widget child,
}) {
  gradientColors =
      gradientColors ?? [AppTheme.colorBitcoin, AppTheme.colorPrimaryGradient];
  height = height ?? AppTheme.cardPadding * 1.5;
  width = width ?? AppTheme.cardPadding * 2.5;
  alignment = alignment ?? Alignment.center;
  borderRadius = borderRadius ?? AppTheme.borderRadiusMid;
  gradientBegin = gradientBegin ?? Alignment.topCenter;
  gradientEnd = gradientEnd ?? Alignment.bottomCenter;
  normalPainter = normalPainter;

  return CustomPaint(
    painter: normalPainter
        ? GradientBorderPainter(
            borderRadius: BorderRadius.circular(borderRadius),
            borderWidth: borderWidth)
        : null,
    foregroundPainter: normalPainter
        ? null
        : GradientBorderPainter(
            borderRadius: BorderRadius.circular(borderRadius),
            borderWidth: borderWidth),
    child: Container(
      height: height,
      width: width,
      alignment: alignment,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            begin: gradientBegin,
            end: gradientEnd,
            colors: gradientColors,
          )),
      child: child,
    ),
  );
}
