import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';
import 'package:nexus_wallet/backbone/theme.dart';

enum ButtonState { idle, loading, disabled }

class GlassButtonWidget extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final ButtonState state;
  final Widget? leadingIcon;
  final Function()? onTap;
  dynamic buttonColor;
  dynamic textColor;

  GlassButtonWidget({
    required this.title,
    required this.onTap,

    this.titleStyle,
    this.buttonColor,
    this.textColor,
    this.state = ButtonState.idle,
    this.leadingIcon,
  });

  @override
  State<GlassButtonWidget> createState() => _GlassButtonWidgetState();
}

class _GlassButtonWidgetState extends State<GlassButtonWidget> {

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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: widget.buttonColor != null ? widget.buttonColor : AppTheme.colorBitcoin,
          shadowColor: widget.buttonColor != null ? widget.buttonColor : AppTheme.colorPrimaryGradient,
          shape: RoundedRectangleBorder(borderRadius: AppTheme.cardRadiusBig,),
        ),
        onPressed: widget.onTap,
        child: Container(
          width: size.width - AppTheme.cardPadding * 2,
          height: 60,
          alignment: Alignment.center,
          child: widget.state == ButtonState.loading
              ? Center(
              child: Transform.scale(
                  scale: 0.6,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppTheme.white100),
                  )))
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
                style: Theme.of(context).textTheme.button?.copyWith(
                    color: widget.textColor != null ? widget.textColor : AppTheme.white90,
                    fontSize: 17
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
