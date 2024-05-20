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
    this.borderRadius = const BorderRadius.all(
        Radius.circular(AppTheme.cardPadding * 2.5 / 2.5)),
    this.height,
    this.width,
    this.borderThickness = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [AppTheme.boxShadowSmall] // Define this boxShadow in your AppTheme
            : [AppTheme.boxShadowSmall], // Optionally, define a different shadow for dark mode
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color:  Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.9) : Color(0XFF3c4451).withOpacity(0.9),
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.5) : Colors.white.withOpacity(opacity + 0.1),
            //     Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.5) : Colors.white.withOpacity(opacity - 0.025),
            //   ],
            // ),
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
