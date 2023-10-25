import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;
  final double? height;
  final double? width;
  final double borderThickness;

  GlassContainer({
    Key? key,
    required this.child,
    this.blur = 50,
    this.opacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppTheme.cardPadding * 2.5 / 2.5)),
    this.height,
    this.width,
    this.borderThickness = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
            borderRadius: borderRadius,
            border: GradientBoxBorder(
              borderRadius: borderRadius,
              borderWidth: borderThickness,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
