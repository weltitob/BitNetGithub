import 'dart:ui';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:flutter/material.dart';

Widget GlassContainer({
  required Widget child,
  required double blur,
  required double opacity,
  required BorderRadius borderRadius,
  double? height,
  double? width,
  double borderThickness = 1.0, // default value is 1.0
}) {
  return ClipRRect(
    borderRadius: borderRadius,
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(opacity + 0.1),
                  Colors.white.withOpacity(opacity - 0.05),
                ]),
            borderRadius: borderRadius,
            border: GradientBoxBorder(
              borderRadius: borderRadius,
              borderWidth: borderThickness, // use the borderThickness here
            )
        ),
        child: child,
      ),
    ),
  );
}