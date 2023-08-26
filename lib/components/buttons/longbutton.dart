import 'dart:ui';

import 'package:BitNet/components/container/imagewithtext.dart';
import 'package:BitNet/components/loaders/loaders.dart';
import 'package:BitNet/components/appstandards/glassmorph.dart';
import 'package:BitNet/components/appstandards/solidcolorcontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';

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
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color:
                            textColor != null ? textColor : AppTheme.white90,
                        shadows: [
                          AppTheme.boxShadowButton,
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
class _LongButtonWidgetTransparentState extends State<LongButtonWidgetTransparent> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.onTap,
      child: Material(
        borderRadius: AppTheme.cardRadiusMid,
        child: Container(
          height: AppTheme.cardPadding * 2.5,
          width: size.width - AppTheme.cardPadding * 2,
          decoration: BoxDecoration(
            borderRadius: AppTheme.cardRadiusMid,
            boxShadow: [AppTheme.boxShadowProfile],
          ),
          child: GlassContainer(
            borderThickness: 1.5, // remove border if not active
            blur: 50,
            opacity: 0.1,
            borderRadius: AppTheme.cardRadiusMid,
            child: ClipRRect( // Added this ClipRRect to clip child widgets
              borderRadius: AppTheme.cardRadiusMid,
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
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: widget.textColor != null
                            ? widget.textColor
                            : AppTheme.white90,
                        shadows: [AppTheme.boxShadowButton],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

