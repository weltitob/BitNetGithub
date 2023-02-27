import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/theme.dart';

class glassButton extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final Function()? function;
  final bool? isSelected;

  const glassButton({
    required this.text,
    this.iconData,
    this.function,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected == null || isSelected! ?
      Glassmorphism(
            blur: 20,
            opacity: 0.1,
            radius: 50.0,
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              onPressed: () {
                // handle push to HomeScreen
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppTheme.elementSpacing * 0.5,
                  horizontal: AppTheme.elementSpacing,
                ),
                child: Row(
                  children: [
                    iconData == null
                        ? Container()
                        : Icon(
                            iconData,
                            color: AppTheme.white80,
                            size: 22,
                          ),
                    iconData == null
                        ? Container()
                        : const SizedBox(
                            width: AppTheme.elementSpacing / 2,
                          ),
                    iconData == null
                        ? Text(
                            text,
                            style: AppTheme.textTheme.bodyMedium!.copyWith(
                                color: AppTheme.white80,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            text,
                            style: AppTheme.textTheme.bodySmall!.copyWith(
                                color: AppTheme.white80,
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ),
            ),
          )
        : TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft),
            onPressed: () {
              // handle push to HomeScreen
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppTheme.elementSpacing * 0.5,
                horizontal: AppTheme.elementSpacing,
              ),
              child: Row(
                children: [
                  iconData == null
                      ? Container()
                      : Icon(
                          iconData,
                          color: AppTheme.white80,
                          size: 22,
                        ),
                  iconData == null
                      ? Container()
                      : const SizedBox(
                          width: AppTheme.elementSpacing / 2,
                        ),
                  iconData == null
                      ? Text(
                          text,
                          style: AppTheme.textTheme.bodyMedium!.copyWith(
                              color: AppTheme.white80,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          text,
                          style: AppTheme.textTheme.bodySmall!.copyWith(
                              color: AppTheme.white80,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
            ),
          );
  }
}
