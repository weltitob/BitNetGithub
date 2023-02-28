import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/theme.dart';

class glassButton extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final Function()? onTap;
  final bool? isSelected;

  const glassButton({
    required this.text,
    this.iconData,
    this.onTap,
    this.isSelected,
  });

  @override
  State<glassButton> createState() => _glassButtonState();
}

class _glassButtonState extends State<glassButton> {
  @override
  Widget build(BuildContext context) {
    return widget.isSelected == null || widget.isSelected! ?
      GestureDetector(
        onTap: widget.onTap,
        child: Glassmorphism(
              blur: 20,
              opacity: 0.1,
              radius: 50.0,
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft),
                onPressed: widget.onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5,
                    horizontal: AppTheme.elementSpacing,
                  ),
                  child: Row(
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
                      widget.iconData == null
                          ? Text(
                              widget.text,
                              style: AppTheme.textTheme.bodyMedium!.copyWith(
                                  color: AppTheme.white80,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              widget.text,
                              style: AppTheme.textTheme.bodySmall!.copyWith(
                                  color: AppTheme.white80,
                                  fontWeight: FontWeight.bold),
                            ),
                    ],
                  ),
                ),
              ),
            ),
      )
        : GestureDetector(
      onTap: widget.onTap,
          child: TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              onPressed: widget.onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.elementSpacing * 0.5,
                  horizontal: AppTheme.elementSpacing,
                ),
                child: Row(
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
                    widget.iconData == null
                        ? Text(
                            widget.text,
                            style: AppTheme.textTheme.bodyMedium!.copyWith(
                                color: AppTheme.white80,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            widget.text,
                            style: AppTheme.textTheme.bodySmall!.copyWith(
                                color: AppTheme.white80,
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ),
            ),
        );
  }
}
