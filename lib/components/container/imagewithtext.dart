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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: customShadow != null
            ? customShadow!
            : Theme.of(context).brightness == Brightness.light
                ? [] // Define this boxShadow in your AppTheme
                : [AppTheme.boxShadowSuperSmall], // Optionally, define a different shadow for dark mode
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: customColor ??
                ( Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.9) : Colors.white.withOpacity(opacity)),
            //went back to old approch
            //color:  Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.9) : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.5) : Colors.white.withOpacity(opacity + 0.1),
            //     Theme.of(context).brightness == Brightness.light ? Colors.white.withOpacity(0.5) : Colors.white.withOpacity(opacity - 0.025),
            //   ],
            // ),
            borderRadius: borderRadius,
            // border: GradientBoxBorder(
            //   borderRadius: borderRadius,
            //   borderWidth: borderThickness,
            // ),
          ),
          child: child,
        ),
      ),
    );
  }
}
