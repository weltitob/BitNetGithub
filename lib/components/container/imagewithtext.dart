import 'dart:ui';

import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/appstandards/glasscontainerborder.dart';
import 'package:BitNet/components/appstandards/glassmorph.dart';
import 'package:flutter/material.dart';

Widget GlassContainer({
  required Widget child,
  required double blur,
  required double opacity,
  required BorderRadius borderRadius,
  double borderThickness = 1.0, // default value is 1.0
}) {
  return ClipRRect(
    borderRadius: borderRadius,
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius,
            border: GradientBoxBorder(
              borderRadius: borderRadius,
              borderWidth: borderThickness, // use the borderThickness here
            )
        ),
        child: child,
      ),
    ),
  );
}
Widget OptionContainer(
    BuildContext context,
    String text,
    VoidCallback action, {
      IconData? fallbackIcon,
      String? image,
      double? width, // new width parameter
      double? height, // new height parameter
      bool isActive = true, // new isActive parameter with default value true
    }) {
  double containerWidth = width ?? AppTheme.cardPadding * 6;
  double containerHeight = height ?? AppTheme.cardPadding * 7.25;

  return InkWell(
    onTap: action, // if not active, disable the onTap
    borderRadius: AppTheme.cardRadiusBigger,
    child: ClipRRect(
      borderRadius: AppTheme.cardRadiusBigger,
      child: ColorFiltered(
        colorFilter: isActive ? ColorFilter.mode(Colors.transparent, BlendMode.color) : ColorFilter.mode(Colors.black.withOpacity(0.99), BlendMode.color),
        child: Container(
          width: containerWidth, // use the custom width if provided
          height: containerHeight, // use the custom height if provided
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: AppTheme.cardRadiusBigger,
            boxShadow: [AppTheme.boxShadowProfile],
          ),
          child: GlassContainer(
            borderThickness: isActive ? 1.5 : 0, // remove border if not active
            blur: 50,
            opacity: 0.2,
            borderRadius: AppTheme.cardRadiusBigger,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: AppTheme.elementSpacing),
                  height: containerHeight / 1.78,
                  width: containerHeight / 1.78,
                  decoration: BoxDecoration(
                    borderRadius: AppTheme.cardRadiusBigger,
                    boxShadow: [AppTheme.boxShadowSmall],
                  ),
                  child: image != null
                      ? Image.asset(image)
                      : Icon(
                    fallbackIcon ?? Icons.error,
                    size: 50,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: AppTheme.elementSpacing,
                      right: AppTheme.elementSpacing,
                  left: AppTheme.elementSpacing),
                  child: Text(text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        shadows: [
                          AppTheme.boxShadow,
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
