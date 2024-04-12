import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/appstandards/solidcolorcontainer.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

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
      this.backgroundPainter = true});

  @override
  _LongButtonWidgetState createState() => _LongButtonWidgetState();
}

class _LongButtonWidgetState extends State<LongButtonWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.customHeight / 2.5);
    final borderRadiusNum = widget.customHeight / 2.5;

    return Stack(
      children: [
        // Your background content goes here:
        Container(
          decoration: BoxDecoration(
            boxShadow: [AppTheme.boxShadowProfile],
            borderRadius: borderRadius,
          ),
          child: widget.buttonType == ButtonType.solid
              ? solidContainer(
                  gradientColors: _isHovered
                      ? [
                          darken(AppTheme.colorBitcoin, 10),
                          darken(AppTheme.colorPrimaryGradient, 10)
                        ]
                      : [AppTheme.colorBitcoin, AppTheme.colorPrimaryGradient],
                  gradientBegin: Alignment.topCenter,
                  gradientEnd: Alignment.bottomCenter,
                  context: context,
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
                  borderThickness: 1.5, // remove border if not active
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
              onTap: widget.onTap,
              borderRadius: borderRadius,
              child: Ink(
                decoration: BoxDecoration(
                  // This can be a transparent decoration to ensure the borderRadius is applied.
                  borderRadius: borderRadius,
                ),
                child: widget.state == ButtonState.loading
                    ? Center(
                        child: Transform.scale(
                            scale: 0.6,
                            child:
                                dotProgress(context, color: AppTheme.white90)))
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.leadingIcon != null)
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: AppTheme.elementSpacing * 0.75),
                                child: widget.leadingIcon,
                              ),
                            Text(
                              widget.title,
                              style: widget.titleStyle != null
                                  ? widget.titleStyle
                                  : Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                      color: widget.textColor != null
                                          ? widget.textColor
                                          : AppTheme.white90,
                                      shadows: [
                                        //AppTheme.boxShadowBig,
                                        AppTheme.boxShadowButton
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
