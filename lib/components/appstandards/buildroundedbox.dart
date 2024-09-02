import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets? contentPadding; // Make contentPadding optional

  const RoundedContainer({
    Key? key,
    required this.child,
    this.contentPadding, // Add contentPadding parameter
  }) : super(key: key);

  @override
  State<RoundedContainer> createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderThickness: 1.5,
      blur: 50,
      opacity: 0.1,
      customColor: Theme.of(context).brightness == Brightness.light ? Color.fromARGB(255, 161, 161, 161).withAlpha(50) : null,
      borderRadius: AppTheme.cardRadiusBigger,
      child: Container(
        padding: widget.contentPadding ?? const EdgeInsets.only(
          top: AppTheme.cardPadding,
          bottom: AppTheme.elementSpacing,
          left: AppTheme.cardPadding,
          right: AppTheme.cardPadding,
        ),
        decoration: BoxDecoration(
          boxShadow: Theme.of(context).brightness == Brightness.light ? [] : [AppTheme.boxShadowProfile],
          borderRadius: AppTheme.cardRadiusBig,
        ),
        child: widget.child,
      ),
    );
  }
}
