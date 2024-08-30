import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundgradient.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatefulWidget {
  final IconData iconData;
  final Function()? onTap;
  final ButtonType buttonType;
  final double size;
  final Color? iconColor;

  const RoundedButtonWidget({
    super.key,
    required this.iconData,
    required this.onTap,
    this.iconColor,
    this.buttonType = ButtonType.solid,
    this.size = AppTheme.cardPadding * 2,
  });

  @override
  State<RoundedButtonWidget> createState() => _RoundedButtonWidgetState();
}

class _RoundedButtonWidgetState extends State<RoundedButtonWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final containerHeight = widget.size;
    final containerWidth = widget.size;
    final borderRadius = BorderRadius.circular(widget.size / 2.5);

    return InkWell(
      borderRadius: borderRadius,
      onTap: widget.onTap,
      onHover: (isHovering) {
        if (isHovering != isHovered) {
          setState(() {
            isHovered = isHovering;
            // Perform any additional action on hover state change if needed
          });
        }
      },
      child: Container(
        height: containerHeight,
        width: containerWidth,
        child: widget.buttonType == ButtonType.transparent
            ? GlassContainer(
                borderThickness: 1.5, // remove border if not active
                blur: 50,
                opacity: 0.1,
                borderRadius: borderRadius,
                child: AnimatedScale(
                    duration: const Duration(milliseconds: 200), scale: isHovered ? 1.0 : 0.9, child: icon(context, widget.buttonType)),
              )
            : BackgroundGradient(
                borderRadius: borderRadius,
                colorprimary: Theme.of(context).colorScheme.primary,
                colorsecondary: Theme.of(context).colorScheme.primary,
                child: Container(
                  alignment: Alignment.center,
                  child: AnimatedScale(
                      duration: const Duration(milliseconds: 200), scale: isHovered ? 1.0 : 0.9, child: icon(context, widget.buttonType)),
                ),
              ),
      ),
    );
  }

  Widget icon(BuildContext context, ButtonType buttonType) {
    return Icon(
      widget.iconData,
      color: widget.buttonType == ButtonType.transparent
          ? Theme.of(context).brightness == Brightness.light
              ? AppTheme.black80
              : AppTheme.white70
          : widget.iconColor ?? AppTheme.white60,
      size: widget.size * 0.6,
    );
  }
}
