import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';

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

  //Inkwell doesnt work here so we need to do stack like on the button widget

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
            opacity: 0.1,
            borderRadius: AppTheme.cardRadiusBigger,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
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
                      top: AppTheme.elementSpacing / 2,
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
