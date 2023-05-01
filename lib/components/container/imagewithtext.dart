import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/container/glassmorph.dart';
import 'package:flutter/material.dart';

Widget OptionContainer(
    BuildContext context, String text, VoidCallback action,
    {IconData? fallbackIcon,  String? image, }) {
  return Container(
      margin: EdgeInsets.only(
        top: AppTheme.elementSpacing / 4,
        bottom: AppTheme.elementSpacing / 4,
        left: AppTheme.elementSpacing / 4,
        right: AppTheme.elementSpacing / 4,),
      width: AppTheme.cardPadding * 6,
      height: AppTheme.cardPadding * 7.25,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: AppTheme.cardRadiusBig,
        boxShadow: [
          AppTheme.boxShadowProfile
        ],
      ),
      child: Material(
          borderRadius: AppTheme.cardRadiusBig,
          child: Glassmorphism(
            blur: 50,
            opacity: 0.2,
            radius: AppTheme.cardPaddingBig,
            child: InkWell(
              onTap: action,
              borderRadius: AppTheme.cardRadiusBig,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: AppTheme.elementSpacing),
                    height: AppTheme.cardPadding * 4,
                    width: AppTheme.cardPadding * 4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        AppTheme.boxShadowProfile
                      ],
                    ),
                    child: image != null
                        ? Image.asset(image)
                        : Icon(
                      fallbackIcon ?? Icons.error,
                      size: 50,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing,
                        vertical: AppTheme.elementSpacing),
                    child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],

                        )),
                  ),
                ],
              ),
            ),
          )));
}
