import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';

class TransactionDetailsContainer extends StatelessWidget {
  final Widget child;
  final bool nested;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? opacity;

  const TransactionDetailsContainer({
    required this.child,
    this.nested = false,
    this.borderRadius,
    this.padding,
    this.opacity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      opacity: opacity ?? (nested ? 0.05 : 0.1),
      borderRadius: borderRadius ??
          (nested ? AppTheme.cardRadiusSmall : AppTheme.cardRadiusBig),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: AppTheme.elementSpacing,
              horizontal: AppTheme.elementSpacing,
            ),
        child: child,
      ),
    );
  }
}
