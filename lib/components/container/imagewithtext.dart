import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/container/glassmorph.dart';
import 'package:flutter/material.dart';

Widget OptionContainer(
    BuildContext context, String text, VoidCallback action,
    {IconData? fallbackIcon,  String? image, }) {
  return InkWell(
    onTap: action,
    borderRadius: AppTheme.cardRadiusBigger,
    child: Container(
        width: AppTheme.cardPadding * 6,
        height: AppTheme.cardPadding * 7.25,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: AppTheme.cardRadiusBigger,
          boxShadow: [
            AppTheme.boxShadowProfile
          ],
        ),
        child: Glassmorphism(
          blur: 50,
          opacity: 0.2,
          radius: AppTheme.cardPaddingBig,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: AppTheme.elementSpacing),
                height: AppTheme.cardPadding * 4,
                width: AppTheme.cardPadding * 4,
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusBigger,
                  boxShadow: [
                    AppTheme.boxShadowSmall
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
        )),
  );
}
