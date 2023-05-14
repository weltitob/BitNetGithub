import 'package:BitNet/backbone/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme.dart';
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
  borderRadius = borderRadius ?? AppTheme.cardRadiusBig;
  gradientBegin = gradientBegin ?? Alignment.topCenter;
  gradientEnd = gradientEnd ?? Alignment.bottomCenter;

  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.25, 0.75, 1],
          colors: [
            AppTheme.white60,
            gradientColors.first,
            gradientColors.last,
            AppTheme.white60,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.2),
        child: Container(
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
    ),
  );
}
