import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class glassButton extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final Function()? onTap;
  final bool? isSelected;

  const glassButton({
    required this.text,
    required this.onTap,
    this.iconData,
    this.isSelected,
  });

  @override
  State<glassButton> createState() => _glassButtonState();
}

class _glassButtonState extends State<glassButton> {
  @override
  Widget build(BuildContext context) {
    return widget.isSelected == null || widget.isSelected!
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onTap,
              child: GlassContainer(
                borderThickness: 1.5, // remove border if not active
                blur: 50,
                opacity: 0.1,
                borderRadius: AppTheme.cardRadiusMid,
                child: Container(
                  width: AppTheme.cardPadding * 6,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.75,
                    horizontal: AppTheme.elementSpacing * 0.75,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.iconData == null
                          ? Container()
                          : Icon(
                              widget.iconData,
                              color: AppTheme.white90,
                              size: AppTheme.elementSpacing * 1.5,
                            ),
                      widget.iconData == null
                          ? Container()
                          : const SizedBox(
                              width: AppTheme.elementSpacing / 1.5,
                            ),
                      Text(
                        widget.text,
                        style: AppTheme.textTheme.titleSmall!.copyWith(
                          color: AppTheme.white90,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: AppTheme.cardPadding * 6,
                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.elementSpacing * 0.75,
                  horizontal: AppTheme.elementSpacing * 0.75,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.iconData == null
                        ? Container()
                        : Icon(
                            widget.iconData,
                            color: AppTheme.white80,
                            size: AppTheme.elementSpacing * 1.5,
                          ),
                    widget.iconData == null
                        ? Container()
                        : const SizedBox(
                            width: AppTheme.elementSpacing / 2,
                          ),
                    Text(widget.text, style: AppTheme.textTheme.titleSmall)
                  ],
                ),
              ),
            ),
          );
  }
}

class ColorfulGradientButton extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final Function()? onTap;
  final bool? isSelected;
  final Gradient gradient; // Gradient property

  const ColorfulGradientButton({
    required this.text,
    required this.onTap,
    this.iconData,
    this.isSelected,
    this.gradient = const LinearGradient(
      colors: [
        AppTheme.colorBitcoin,
        AppTheme.colorPrimaryGradient
      ], // Default gradient for example's sake
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  });

  @override
  State<ColorfulGradientButton> createState() => _ColorfulGradientButtonState();
}

class _ColorfulGradientButtonState extends State<ColorfulGradientButton> {
  @override
  Widget build(BuildContext context) {
    return widget.isSelected == null || widget.isSelected!
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: AppTheme.cardRadiusMid,
                  boxShadow: [AppTheme.boxShadowProfile],
                ),
                width: AppTheme.cardPadding * 6,
                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.elementSpacing * 0.75,
                  horizontal: AppTheme.elementSpacing * 0.75,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.iconData == null
                        ? Container()
                        : Icon(
                            widget.iconData,
                            color: AppTheme.white90,
                            size: AppTheme.elementSpacing * 1.5,
                          ),
                    widget.iconData == null
                        ? Container()
                        : const SizedBox(
                            width: AppTheme.elementSpacing / 1.5,
                          ),
                    Text(widget.text,
                        style: AppTheme.textTheme.titleSmall!
                            .copyWith(color: Colors.white, shadows: [
                          AppTheme.boxShadowButton,
                        ])),
                  ],
                ),
              ),
            ),
          )
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: AppTheme.cardRadiusMid,
                ),
                width: AppTheme.cardPadding * 6,
                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.elementSpacing * 0.75,
                  horizontal: AppTheme.elementSpacing * 0.75,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.iconData == null
                        ? Container()
                        : Icon(
                            widget.iconData,
                            color: AppTheme.white90,
                            size: AppTheme.elementSpacing * 1.5,
                          ),
                    widget.iconData == null
                        ? Container()
                        : const SizedBox(
                            width: AppTheme.elementSpacing / 1.5,
                          ),
                    Text(widget.text,
                        style: AppTheme.textTheme.titleSmall!
                            .copyWith(color: Colors.white, shadows: [
                          AppTheme.boxShadowButton,
                        ])),
                  ],
                ),
              ),
            ),
          );
  }
}
