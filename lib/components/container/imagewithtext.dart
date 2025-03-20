import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;
  final double? height;
  final double? width;
  final double borderThickness;
  final List<BoxShadow>? customShadow;
  final Color? customColor;
  final EdgeInsetsGeometry? margin;

  const GlassContainer({
    Key? key,
    required this.child,
    this.blur = 50,
    this.opacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppTheme.cardPadding * 2.5 / 3)),
    this.height,
    this.width,
    this.borderThickness = 1,
    this.customShadow,
    this.customColor,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Performance optimization: use RepaintBoundary to isolate repaints
    return RepaintBoundary(
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          // Performance optimization: only apply shadows when needed
          boxShadow: customShadow != null
              ? customShadow!
              : Theme.of(context).brightness == Brightness.light
                  ? [] // No shadows in light mode
                  : [AppTheme.boxShadowSuperSmall], // Minimal shadow in dark mode
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              // Simplified color calculation for better performance
              color: customColor ??
                  (Theme.of(context).brightness == Brightness.light 
                      ? Colors.white.withOpacity(0.9) 
                      : Colors.white.withOpacity(opacity)),
              borderRadius: borderRadius,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}