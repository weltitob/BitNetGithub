import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/appstandards/solidcolorcontainer.dart';
import 'package:flutter/material.dart';

Widget personalActionButton({
  required BuildContext context,
  required Function() onPressed,
  required IconData iconData,
  required List<Color> gradientColors,
}) {
  return solidContainer(
    context: context,
    onPressed: onPressed,
    gradientColors: gradientColors,
    child: Center(
      child: Icon(
        iconData,
        color: AppTheme.white90,
      ),
    ),
  );
}
