import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/solidcolorcontainer.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
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
  LongButtonWidget({
    required this.title,
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
    this.onTapDisabled,
  });

  @override
  _LongButtonWidgetState createState() => _LongButtonWidgetState();
}

class _LongButtonWidgetState extends State<LongButtonWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Cache Theme to avoid multiple expensive calls
    final theme = Theme.of(context);
    
    // Use a more rounded border radius - half the height for pill-shaped buttons
    final borderRadius = BorderRadius.circular(widget.customHeight / 2);
    final borderRadiusNum = widget.customHeight / 2;

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
                              darken(
                                  theme.colorScheme.secondaryContainer,
                                  10),
                              darken(
                                  theme.colorScheme.tertiaryContainer,
                                  10)
                            ]
                          : theme.colorScheme.primary ==
                                  AppTheme.colorBitcoin
                              ? [
                                  AppTheme.colorBitcoin,
                                  AppTheme.colorPrimaryGradient,
                                ]
                              : [
                                  theme.colorScheme.primary,
                                  theme.colorScheme.secondary,
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
                  border: (widget.state == ButtonState.disabled
                      ? 0
                      : 0) == 0 ? null : Border.all(width: widget.state == ButtonState.disabled
                      ? 0
                      : 0, color: Theme.of(context).dividerColor), // remove border if not active
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
              onTap: widget.state == ButtonState.disabled
                  ? widget.onTapDisabled
                  : widget.onTap,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.leadingIcon != null)
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: widget.leadingIcon,
                                ),
                              Flexible(
                                child: Text(
                                  widget.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: widget.titleStyle != null
                                      ? widget.titleStyle
                                      : theme.textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: widget.textColor != null
                                              ? widget.textColor
                                              : widget.buttonType ==
                                                      ButtonType.solid
                                                  ? theme.colorScheme.onPrimary
                                                  : theme.brightness ==
                                                          Brightness.light
                                                      ? AppTheme.black70
                                                      : AppTheme.white90,
                                          shadows: [
                                            //AppTheme.boxShadowBig,
                                            theme.brightness == Brightness.light
                                                ? AppTheme.boxShadow
                                                : AppTheme.boxShadowButton,
                                          ],
                                        ),
                                ),
                              ),
                            ],
                          ),
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
