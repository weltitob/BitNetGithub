import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class SolidContainer extends StatelessWidget {
  final List<Color> gradientColors;
  final double height;
  final double width;
  final AlignmentGeometry alignment;
  final double borderRadius;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final bool normalPainter;
  final double borderWidth;
  final Widget child;

  SolidContainer({
    Key? key,
    List<Color>? gradientColors,
    double? height,
    double? width,
    AlignmentGeometry? alignment,
    double? borderRadius,
    AlignmentGeometry? gradientBegin,
    AlignmentGeometry? gradientEnd,
    this.normalPainter = true,
    this.borderWidth = 1.5,
    required this.child,
  })  : this.gradientColors = gradientColors ?? [AppTheme.colorBitcoin, AppTheme.colorPrimaryGradient],
        this.height = height ?? AppTheme.cardPadding * 1.5,
        this.width = width ?? AppTheme.cardPadding * 2.5,
        this.alignment = alignment ?? Alignment.center,
        this.borderRadius = borderRadius ?? AppTheme.borderRadiusMid,
        this.gradientBegin = gradientBegin ?? Alignment.topCenter,
        this.gradientEnd = gradientEnd ?? Alignment.bottomCenter,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool useBitcoinGradient = gradientColors.contains(AppTheme.colorBitcoin) && 
                                     gradientColors.contains(AppTheme.colorPrimaryGradient);
    
    return CustomPaint(
      // Custom painter logic is commented out but kept for reference
      // painter: normalPainter ? GradientBorderPainter(...) : null,
      // foregroundPainter: !normalPainter ? GradientBorderPainter(...) : null,
      child: Container(
        height: height,
        width: width,
        alignment: alignment,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          // Use gradient if colors include Bitcoin theme colors, otherwise use solid color
          color: useBitcoinGradient ? null : Theme.of(context).colorScheme.primary,
          gradient: useBitcoinGradient 
              ? LinearGradient(
                  begin: gradientBegin,
                  end: gradientEnd,
                  colors: gradientColors,
                )
              : null,
        ),
        child: child,
      ),
    );
  }
}