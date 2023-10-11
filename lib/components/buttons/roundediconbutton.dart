import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundgradient.dart';
import 'package:flutter/material.dart';


class RoundedIconButton extends StatelessWidget {
  final IconData iconData;
  final Color colorPrimary;
  final Color colorSecondary;

  const RoundedIconButton({
    Key? key,
    required this.iconData,
    required this.colorPrimary,
    required this.colorSecondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: BackgroundGradient(
        colorprimary: colorPrimary,
        colorsecondary: colorSecondary,
        child: Container(
          alignment: Alignment.center,
          child: Icon(
            iconData,
            color: AppTheme.white90,
            size: AppTheme.cardPadding * 1.25,
          ),
        ),
      ),
    );
  }
}