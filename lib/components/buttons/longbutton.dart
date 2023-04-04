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
  dynamic buttonColor;
  dynamic textColor;

  LongButtonWidget({
    required this.title,
    required this.onTap,
    this.titleStyle,
    this.buttonColor,
    this.textColor,
    this.state = ButtonState.idle,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: buttonColor != null ? buttonColor : AppTheme.colorBitcoin,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(0, 24),
            blurRadius: 50,
            spreadRadius: -18,
          ),
        ],
        borderRadius: AppTheme.cardRadiusBig,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppTheme.cardRadiusBig,
          onTap: onTap,
          child: Container(
            width: size.width - AppTheme.cardPadding * 2,
            height: 60,
            alignment: Alignment.center,
            child: state == ButtonState.loading
                ? Center(
                child: Transform.scale(
                    scale: 0.6,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppTheme.white100),
                    )))
                : Row(
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
                  style: Theme.of(context).textTheme.button?.copyWith(
                      color: textColor != null ? textColor : AppTheme.white90,
                      fontSize: 17
                  ),
                ),
              ],
            ),
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
  State<LongButtonWidgetTransparent> createState() => _LongButtonWidgetTransparentState();
}

class _LongButtonWidgetTransparentState extends State<LongButtonWidgetTransparent> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(0, 24),
            blurRadius: 50,
            spreadRadius: -18,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppTheme.cardRadiusBig,
          onTap: widget.onTap,
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.white100),
              borderRadius: AppTheme.cardRadiusBig,
            ),
            height: 60,
            width: size.width - AppTheme.cardPadding * 2,
            child: Center(
              child: widget.state == ButtonState.loading
                  ? Transform.scale(
                scale: 0.6,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppTheme.white100),
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.leadingIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(
                          right: AppTheme.elementSpacing),
                      child: widget.leadingIcon,
                    ),
                  Text(
                    widget.title,
                    style:
                    Theme.of(context).textTheme.button?.copyWith(
                      color: widget.textColor != null
                          ? widget.textColor
                          : AppTheme.white90,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
