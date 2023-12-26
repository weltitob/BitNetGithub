import 'dart:ui';

import 'package:bitnet/components/appstandards/backgroundgradient.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class RoundedButtonWidget extends StatefulWidget {
  final IconData iconData;
  final Function()? onTap;
  final ButtonType buttonType;
  final double size;

  const RoundedButtonWidget({
    super.key,
    required this.iconData,
    required this.onTap,
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
      borderRadius: AppTheme.cardRadiusSmall,
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
          child: widget.buttonType == ButtonType.transparent ? GlassContainer(
            borderThickness: 1.5, // remove border if not active
            blur: 50,
            opacity: 0.1,
            borderRadius: borderRadius,
            child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isHovered ? 1.0 : 0.9,
                child: icon()),
          ) : BackgroundGradient(
            borderRadius: borderRadius,
            colorprimary: AppTheme.colorBitcoin,
            colorsecondary: AppTheme.colorPrimaryGradient,
            child: Container(
              alignment: Alignment.center,
              child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: isHovered ? 1.0 : 0.9,
                  child: icon()),
            ),
          ),

      ),
    );
  }

  Widget icon(){
    return Icon(
      widget.iconData,
      color: widget.buttonType == ButtonType.solid
          ? AppTheme.white90
          : Theme.of(context).colorScheme.onSecondaryContainer,
      size: widget.size * 0.6,
    );
  }
}