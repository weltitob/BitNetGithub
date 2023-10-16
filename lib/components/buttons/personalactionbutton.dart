import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/solidcolorcontainer.dart';
import 'package:flutter/material.dart';

Widget personalActionButton({
  required BuildContext context,
  required Function() onPressed,
  required IconData iconData,
  required List<Color> gradientColors,
}) {
  return InkWell(
    onTap: onPressed,
    child: solidContainer(
      context: context,
      gradientColors: gradientColors,
      child: Center(
        child: Icon(
          iconData,
          color: AppTheme.white90,
        ),
      ),
    ),
  );
}
