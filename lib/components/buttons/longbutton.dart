import 'dart:ui';

import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/components/container/glassmorph.dart';
import 'package:BitNet/components/container/solidcolorcontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';
import 'package:BitNet/backbone/helper/theme.dart';

enum ButtonState { idle, loading, disabled }

class LongButtonWidget extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final ButtonState state;
  final Widget? leadingIcon;
  final Function()? onTap;
  final Gradient? buttonGradient; // Gradient property
  dynamic textColor;

  LongButtonWidget({
    required this.title,
    required this.onTap,
    this.titleStyle,
    this.buttonGradient, // initialize gradient in constructor
    this.textColor,
    this.state = ButtonState.idle,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          AppTheme.boxShadowProfile
        ],
        borderRadius: AppTheme.cardRadiusMid,
      ),
      child: solidContainer(
        gradientBegin: Alignment.topCenter,
        gradientEnd: Alignment.bottomCenter,
        context: context,
        borderRadius: AppTheme.cardRadiusMid,
        onPressed: onTap ?? (){},
        width: size.width - AppTheme.cardPadding * 2,
        height: AppTheme.cardPadding * 2.5,
        child: state == ButtonState.loading
            ? Center(
                child: Transform.scale(
                    scale: 0.6,
                    child: dotProgress(context, color: AppTheme.white90)))
            : Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leadingIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(
                            right: AppTheme.elementSpacing),
                        child: leadingIcon,
                      ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color:
                            textColor != null ? textColor : AppTheme.white100,
                        fontSize: 17,
                        shadows: [
                          AppTheme.boxShadowSmall
                        ],
                      ),
                    ),
                  ],
                ),
            ),
      ),
    );
  }
}

class LongButtonWidgetTransparent extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final ButtonState state;
  final Widget? leadingIcon;
  final Function()? onTap;
  dynamic buttonColor;
  dynamic textColor;

  LongButtonWidgetTransparent({
    required this.title,
    required this.onTap,
    this.titleStyle,
    this.buttonColor,
    this.textColor,
    this.state = ButtonState.idle,
    this.leadingIcon,
  });

  @override
  State<LongButtonWidgetTransparent> createState() =>
      _LongButtonWidgetTransparentState();
}

class _LongButtonWidgetTransparentState
    extends State<LongButtonWidgetTransparent> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: AppTheme.cardPadding * 2.5,
      width: size.width - AppTheme.cardPadding * 2,
      decoration: BoxDecoration(
          borderRadius: AppTheme.cardRadiusMid,
        boxShadow: [
          AppTheme.boxShadowProfile
        ],
      ),
      child: Glassmorphism(
        gradientBegin: Alignment.topCenter,
        gradientEnd: Alignment.bottomCenter,
        blur: 50,
        opacity: 0.15,
        radius: AppTheme.cardPadding,
        child: InkWell(
          borderRadius: AppTheme.cardRadiusMid,
          onTap: widget.onTap,
          child: Container(
            height: AppTheme.cardPadding * 2.5,
            alignment: Alignment.center,
            child: widget.state == ButtonState.loading
                ? Center(child: dotProgress(context, color: AppTheme.white90))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.leadingIcon != null) widget.leadingIcon!,
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                          widget.textColor != null ? widget.textColor : AppTheme.white90,
                          fontSize: 17,
                          shadows: [
                            AppTheme.boxShadowSmall
                          ],
                      ),
                      )],
                  ),
          ),
        ),
      ),
    );
  }
}
