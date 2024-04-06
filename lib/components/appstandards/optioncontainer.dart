import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class BitNetImageWithTextContainer extends StatelessWidget {
  final String text;
  final Function() action;
  final IconData? fallbackIcon;
  final String? image;
  final double width;
  final double height;
  final bool isActive;

  BitNetImageWithTextContainer(
    this.text,
    this.action, {
    this.fallbackIcon,
    this.image,
    this.width = AppTheme.cardPadding * 5.5,
    this.height = AppTheme.cardPadding * 7,
    this.isActive = true, // default value is true
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BorderRadius borderRadius = BorderRadius.circular(width / 3);

    TextStyle textstyle = width > 100
        ? Theme.of(context).textTheme.titleSmall!.copyWith(
            shadows: [
              AppTheme.boxShadow,
            ],
          )
        : Theme.of(context).textTheme.bodySmall!.copyWith(
            shadows: [
              AppTheme.boxShadow,
            ],
          );

    return Transform.scale(
      scale: isActive ? 1 : 0.9,
      child: InkWell(
        onTap: action,
        borderRadius: borderRadius,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: ColorFiltered(
            colorFilter: isActive
                ? ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.color,
                  )
                : ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.color,
                  ),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                boxShadow: [AppTheme.boxShadowProfile],
              ),
              child: GlassContainer(
                borderThickness: isActive ? 1.5 : 0,
                blur: 50,
                opacity: 0.1,
                borderRadius: borderRadius,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: height / 40,
                      ),
                      height: width / 1.5,
                      width: width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius / 1.5,
                        boxShadow: [AppTheme.boxShadowSmall],
                      ),
                      child: image != null
                          ? Image.asset(image!)
                          : Icon(
                              fallbackIcon ?? Icons.error,
                              size: AppTheme.cardPadding * 1.75,
                              color: AppTheme.white80,
                            ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: AppTheme.elementSpacing,
                        left: AppTheme.elementSpacing,
                      ),
                      child: Text(text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center, style: textstyle),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
