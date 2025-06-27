import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets? contentPadding;

  const RoundedContainer({
    Key? key,
    required this.child,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<RoundedContainer> createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Container(
        padding: widget.contentPadding ??
            const EdgeInsets.only(
              top: AppTheme.cardPadding,
              bottom: AppTheme.elementSpacing,
              left: AppTheme.cardPadding,
              right: AppTheme.cardPadding,
            ),
        child: widget.child,
      ),
    );
  }
}
