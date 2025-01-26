import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BitNetImageWithTextContainer extends StatelessWidget {
  final String text;
  final Function() action;
  final IconData? fallbackIcon;
  final String? image;
  final double width;
  final double height;
  final double? fallbackIconSize;
  final bool isActive;
  final Color? customColor;
  const BitNetImageWithTextContainer(
    this.text,
    this.action, {
    this.fallbackIcon,
    this.image,
    this.width = AppTheme.cardPadding * 6,
    this.height = AppTheme.cardPadding * 7,
    this.fallbackIconSize = AppTheme.cardPadding * 1.75,
    this.isActive = true, // default value is true
    Key? key, this.customColor,
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
        child: GlassContainer(
          width: width,
          height: height,
          customColor: customColor,
          borderThickness: isActive ? 1 : 0,
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
                  boxShadow: Theme.of(context).brightness == Brightness.light ? [] : [AppTheme.boxShadowSmall],
                ),
                child: image != null
                    ? Image.asset(image!)
                    : Icon(
                        fallbackIcon ?? Icons.error,
                        size: fallbackIconSize ??AppTheme.cardPadding * 1.75,
                        color: Theme.of(context).brightness == Brightness.light ? AppTheme.black80 : AppTheme.white80,
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  right: AppTheme.elementSpacing,
                  left: AppTheme.elementSpacing,
                ),
                child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: textstyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBitNetImageWithTextContainer extends StatelessWidget {
  final String text;
  final Function() action;
  final IconData? fallbackIcon;
  final double? fallbackIconSize;
  final String? image;
  final double width;
  final double height;
  final bool isActive;

  const AnimatedBitNetImageWithTextContainer(
    this.text,
    this.action, {
    this.fallbackIcon,
    this.fallbackIconSize = AppTheme.cardPadding * 1.75,
    this.image,
    this.width = AppTheme.cardPadding * 6,
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

    return AnimatedScale(
      scale: isActive ? 1 : 0.9,
      duration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: action,
        borderRadius: borderRadius,
        child: GlassContainer(
          width: width,
          height: height,
          borderThickness: isActive ? 1 : 0,
          borderRadius: borderRadius,
          customShadow: [AppTheme.boxShadowSmall],
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
                  boxShadow: Theme.of(context).brightness == Brightness.light ? [] : [AppTheme.boxShadowSmall],
                ),
                child: image != null
                    ? Image.asset(image!)
                    : Icon(
                        fallbackIcon ?? Icons.error,
                        size: fallbackIconSize ?? AppTheme.cardPadding * 1.75,
                        color: Theme.of(context).brightness == Brightness.light ? AppTheme.black80 : AppTheme.white80,
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  right: AppTheme.elementSpacing,
                  left: AppTheme.elementSpacing,
                ),
                child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: textstyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BitNetImageWithTextButton extends StatelessWidget {
  final String text;
  final Function() action;
  final IconData? fallbackIcon;
  final double? fallbackIconSize;
  final String? image;
  final double width;
  final double height;
  final bool isActive;

  const BitNetImageWithTextButton(
    this.text,
    this.action, {
    this.fallbackIcon,
    this.fallbackIconSize = AppTheme.cardPadding * 1.75,
    this.image,
    this.width = AppTheme.cardPadding * 6,
    this.height = AppTheme.cardPadding * 7,
    this.isActive = true, // default value is true
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(width / 3);

    return InkWell(
      onTap: action,
      borderRadius: borderRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlassContainer(
            width: width,
            height: height,
            borderRadius: borderRadius,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: width / 1.4,
                  width: width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius / 1.5,
                    boxShadow: Theme.of(context).brightness == Brightness.light ? [] : [AppTheme.boxShadowSmall],
                  ),
                  child: image != null
                      ? Image.asset(image!)
                      : Icon(
                          fallbackIcon ?? Icons.error,
                          size: fallbackIconSize ?? AppTheme.cardPadding * 1.75,
                          color: Theme.of(context).brightness == Brightness.light ? AppTheme.black80 : AppTheme.white80,
                        ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppTheme.elementSpacing * 0.75),
          Container(
            width: width * 0.95,
            margin: const EdgeInsets.only(
              right: AppTheme.elementSpacing,
              left: AppTheme.elementSpacing,
            ),
            child: Text(text,
                maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
