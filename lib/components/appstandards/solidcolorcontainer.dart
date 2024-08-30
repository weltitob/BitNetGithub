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
    return CustomPaint(
      // painter: normalPainter
      //     ? GradientBorderPainter(
      //     borderRadius: BorderRadius.circular(borderRadius),
      //     borderWidth: borderWidth,
      //     // gradientColors: [
      //     //   lighten(Theme.of(context).colorScheme.secondaryContainer, 60),
      //     //   Theme.of(context).colorScheme.secondaryContainer,
      //     //   Theme.of(context).colorScheme.secondaryContainer,
      //     //   lighten(Theme.of(context).colorScheme.secondaryContainer, 60)
      //     // ]
      // ) // Modify to pass the correct colors
      //     : null,
      // foregroundPainter: !normalPainter
      //     ? GradientBorderPainter(
      //     borderRadius: BorderRadius.circular(borderRadius),
      //     borderWidth: borderWidth,
      //     // gradientColors: [
      //     //   lighten(Theme.of(context).colorScheme.secondaryContainer, 60),
      //     //   Theme.of(context).colorScheme.secondaryContainer,
      //     //   Theme.of(context).colorScheme.secondaryContainer,
      //     //   lighten(Theme.of(context).colorScheme.secondaryContainer, 60)
      //     // ]
      // ) // Modify to pass the correct colors
      //     : null,
      child: Container(
        height: height,
        width: width,
        alignment: alignment,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Theme.of(context).colorScheme.primary,
          // gradient: LinearGradient(
          //   begin: gradientBegin,
          //   end: gradientEnd,
          //   colors: gradientColors,
          // ),
        ),
        child: child,
      ),
    );
  }
}
