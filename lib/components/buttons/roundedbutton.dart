import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundgradient.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatefulWidget {
  final IconData iconData;
  final Function()? onTap;
  final ButtonType buttonType;
  final double size;
  final Color? iconColor;
  final Color? customPrimaryColor; // Added customPrimaryColor parameter
  final Color? customSecondaryColor; // Added customSecondaryColor parameter

  const RoundedButtonWidget({
    super.key,
    required this.iconData,
    required this.onTap,
    this.iconColor,
    this.buttonType = ButtonType.solid,
    this.size = AppTheme.cardPadding * 2,
    this.customPrimaryColor, // New optional parameter
    this.customSecondaryColor, // New optional parameter
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
    final borderRadius = BorderRadius.circular(widget.size / 3);

    // Get primary and secondary colors based on custom colors or theme defaults
    final Color primaryColor =
        widget.customPrimaryColor ?? Theme.of(context).colorScheme.primary;
    final Color secondaryColor = widget.customSecondaryColor ??
        (Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
            ? AppTheme.colorPrimaryGradient
            : Theme.of(context).colorScheme.primary);

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
                borderThickness: 1.5,
                blur: 50,
                opacity: 0.1,
                borderRadius: borderRadius,
                child: AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: isHovered ? 1.0 : 0.9,
                    child: icon(context, widget.buttonType)),
              )
            : BackgroundGradient(
                borderRadius: borderRadius,
                colorprimary: primaryColor,
                colorsecondary: secondaryColor,
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: isHovered ? 1.0 : 0.9,
                        child: icon(context, widget.buttonType)),
                  ),
                ),
              ),
      ),
    );
  }

  Widget icon(BuildContext context, ButtonType buttonType) {
    // Determine if we should use the Bitcoin gradient text color
    final bool useBitcoinGradient =
        Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin;

    return Icon(
      widget.iconData,
      color: widget.buttonType == ButtonType.transparent
          ? Theme.of(context).brightness == Brightness.light
              ? AppTheme.black80
              : AppTheme.white70
          : widget.iconColor ??
              (useBitcoinGradient
                  ? Colors.white
                  : Theme.of(context).brightness == Brightness.light
                      ? AppTheme.white70
                      : AppTheme.black60),
      size: widget.size * 0.55,
    );
  }
}
