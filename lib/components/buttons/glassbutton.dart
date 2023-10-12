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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        double screenWidth = MediaQuery.of(context).size.width; // This gets the screen width
        bool isSmallScreen = screenWidth < AppTheme.isSmallScreen; // Example breakpoint for small screens
        bool isMidScreen = screenWidth < AppTheme.isMidScreen;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onTap,
            child: GlassContainer(
              borderThickness: widget.isSelected == null || widget.isSelected! ? 1.5 : 0,
              blur: 50,
              opacity: 0.1,
              borderRadius: AppTheme.cardRadiusSmall,
              child: Container(
                //color: Colors.red,
                width: isSmallScreen ? AppTheme.cardPadding * 5 : AppTheme.cardPadding * 6,
                padding: EdgeInsets.symmetric(
                  vertical: isSmallScreen? AppTheme.elementSpacing * 0.5 :  AppTheme.elementSpacing * 0.75,
                  horizontal: isSmallScreen? AppTheme.elementSpacing * 0.5 : AppTheme.elementSpacing * 0.75,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.iconData == null
                        ? Container()
                        : Icon(
                      widget.iconData,
                      color: (widget.isSelected == null || widget.isSelected!)
                          ? AppTheme.white90
                          : AppTheme.white80,
                      size: isSmallScreen ? AppTheme.elementSpacing * 1.25 : AppTheme.elementSpacing * 1.5,
                    ),
                    widget.iconData == null
                        ? Container()
                        : SizedBox(
                      width: isSmallScreen ? AppTheme.elementSpacing / 2 : AppTheme.elementSpacing / 1.5,
                    ),
                    Text(
                      widget.text,
                      style: isSmallScreen
                          ? AppTheme.textTheme.titleSmall!.copyWith(
                        fontSize: 14,
                        color: (widget.isSelected == null || widget.isSelected!)
                            ? AppTheme.white90
                            : AppTheme.white80,
                      )
                          : AppTheme.textTheme.titleSmall!.copyWith(
                        color: (widget.isSelected == null || widget.isSelected!)
                            ? AppTheme.white90
                            : AppTheme.white80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
                  borderRadius: AppTheme.cardRadiusSmall,
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
                  borderRadius: AppTheme.cardRadiusSmall,
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
