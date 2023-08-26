import 'package:BitNet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';

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
        ? GestureDetector(
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
                  horizontal: AppTheme.elementSpacing,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.iconData == null
                        ? Container()
                        : Icon(
                            widget.iconData,
                            color: AppTheme.white80,
                            size: 22,
                          ),
                    widget.iconData == null
                        ? Container()
                        : const SizedBox(
                            width: AppTheme.elementSpacing / 2,
                          ),
                    Text(
                      widget.text,
                      style: AppTheme.textTheme.bodyMedium!.copyWith(
                          color: AppTheme.white80, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: AppTheme.cardPadding * 6,
              padding: const EdgeInsets.symmetric(
                vertical: AppTheme.elementSpacing * 0.75,
                horizontal: AppTheme.elementSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.iconData == null
                      ? Container()
                      : Icon(
                          widget.iconData,
                          color: AppTheme.white80,
                          size: 22,
                        ),
                  widget.iconData == null
                      ? Container()
                      : const SizedBox(
                          width: AppTheme.elementSpacing / 2,
                        ),
                  Text(
                    widget.text,
                    style: AppTheme.textTheme.bodyMedium!.copyWith(
                        color: AppTheme.white80, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
  }
}
