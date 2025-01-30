import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/solidcolorcontainer.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';

enum ButtonState { idle, loading, disabled }

enum ButtonType { solid, transparent }

class LongButtonWidget extends StatefulWidget {
  final String title;
  final double customWidth;
  final double customHeight;
  final TextStyle? titleStyle;
  final ButtonState state;
  final Widget? leadingIcon;
  final Function()? onTap;
  final Gradient? buttonGradient;
  dynamic textColor;
  final ButtonType buttonType;
  final bool backgroundPainter;
  final List<BoxShadow>? customShadow;
  final Function()? onTapDisabled;

  LongButtonWidget(
      {required this.title,
      required this.onTap,
      this.titleStyle,
      this.buttonGradient,
      this.textColor,
      this.state = ButtonState.idle,
      this.leadingIcon,
      this.customWidth = AppTheme.cardPadding * 12,
      this.customHeight = AppTheme.cardPadding * 2.5,
      this.buttonType = ButtonType.solid,
      this.backgroundPainter = true,
      this.customShadow,
      this.onTapDisabled});

  @override
  _LongButtonWidgetState createState() => _LongButtonWidgetState();
}

class _LongButtonWidgetState extends State<LongButtonWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.customHeight / 3);
    final borderRadiusNum = widget.customHeight / 3;

    return Stack(
      children: [
        // Your background content goes here:
        Container(
          decoration: BoxDecoration(
            boxShadow: widget.customShadow ?? [AppTheme.boxShadowProfile],
            borderRadius: borderRadius,
          ),
          child: widget.buttonType == ButtonType.solid
              ? SolidContainer(
                  gradientColors: widget.state == ButtonState.disabled
                      ? [Colors.grey, Colors.grey]
                      : _isHovered
                          ? [
                              darken(Theme.of(context).colorScheme.secondaryContainer, 10),
                              darken(Theme.of(context).colorScheme.tertiaryContainer, 10)
                            ]
                          : [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                  gradientBegin: Alignment.topCenter,
                  gradientEnd: Alignment.bottomCenter,
                  borderRadius: borderRadiusNum,
                  width: widget.customWidth,
                  height: widget.customHeight,
                  normalPainter: widget.backgroundPainter,
                  borderWidth: widget.backgroundPainter ? 1.5 : 1,
                  child: Container(),
                )
              : GlassContainer(
                  height: widget.customHeight,
                  width: widget.customWidth,
                  borderThickness: widget.state == ButtonState.disabled ? 0 : 1.5, // remove border if not active
                  blur: 50,
                  opacity: 0.1,
                  borderRadius: borderRadius,
                  child: Container(),
                ),
        ),
        // The InkWell goes on top of the background:
        Container(
          width: widget.customWidth,
          height: widget.customHeight,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Colors.black.withOpacity(0.1),
              onHover: (value) => setState(() => _isHovered = value),
              onTap: widget.state == ButtonState.disabled ? widget.onTapDisabled : widget.onTap,
              borderRadius: borderRadius,
              child: Ink(
                decoration: BoxDecoration(
                  // This can be a transparent decoration to ensure the borderRadius is applied.
                  borderRadius: borderRadius,
                ),
                child: widget.state == ButtonState.loading
                    ? Center(child: Transform.scale(scale: 0.6, child: dotProgress(context, color: AppTheme.white90)))
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.leadingIcon != null)
                              Padding(
                                padding:  EdgeInsets.only(right: widget.customWidth * 0.05),
                                child: widget.leadingIcon,
                              ),
                            Text(
                              widget.title,
                              style: widget.titleStyle != null
                                  ? widget.titleStyle
                                  : Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: widget.textColor != null
                                          ? widget.textColor
                                          : widget.buttonType == ButtonType.solid
                                              ? Theme.of(context).colorScheme.onPrimary
                                              : Theme.of(context).brightness == Brightness.light
                                                  ? AppTheme.black70
                                                  : AppTheme.white90,
                                      shadows: [
                                        //AppTheme.boxShadowBig,
                                        Theme.of(context).brightness == Brightness.light ? AppTheme.boxShadow : AppTheme.boxShadowButton,
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
