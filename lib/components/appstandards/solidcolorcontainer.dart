import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:flutter/material.dart';

Widget solidContainer({
  required BuildContext context,
  required Function() onPressed,
  List<Color>? gradientColors,
  double? height,
  double? width,
  AlignmentGeometry? alignment,
  BorderRadiusGeometry? borderRadius,
  AlignmentGeometry? gradientBegin,
  AlignmentGeometry? gradientEnd,
  required Widget child,
}) {
  gradientColors = gradientColors ?? [AppTheme.colorBitcoin, AppTheme.colorPrimaryGradient];
  height = height ?? AppTheme.cardPadding * 1.5;
  width = width ?? AppTheme.cardPadding * 2.5;
  alignment = alignment ?? Alignment.center;
  borderRadius = borderRadius ?? AppTheme.cardRadiusMid;
  gradientBegin = gradientBegin ?? Alignment.topCenter;
  gradientEnd = gradientEnd ?? Alignment.bottomCenter;

  return GestureDetector(
    onTap: onPressed,
    child: CustomPaint(
      painter: GradientBorderPainter(
          borderRadius: BorderRadius.circular(AppTheme.cardPadding),
          borderWidth: 1.5),
      child: Container(
        height: height,
        width: width,
        alignment: alignment,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: gradientBegin,
              end: gradientEnd,
              colors: gradientColors,
            )),
        child: child,
      ),
    ),
  );
}
