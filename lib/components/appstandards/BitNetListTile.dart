import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class BitNetListTile extends StatelessWidget {
  final Widget? leading;
  final String text;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry contentPadding;
  final Function()? onTap;
  final Color? tileColor;
  final ShapeBorder? shape;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool isinsideBottomSheet;
  final Widget? customTitle;

  const BitNetListTile({
    super.key,
    this.leading,
    this.text = "",
    this.subtitle,
    this.trailing,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 0.5, vertical: AppTheme.elementSpacing * 0.75),
    this.onTap,
    this.tileColor,
    this.shape,
    this.titleStyle,
    this.subtitleStyle,
    this.isinsideBottomSheet = false,
    this.customTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppTheme.elementSpacing, left: AppTheme.elementSpacing / 2, right: AppTheme.elementSpacing / 2,),
      decoration: BoxDecoration(
        //color: tileColor ?? Colors.white.withOpacity(0.1),
        //borderRadius: AppTheme.cardRadiusSmall,
        //border: shape != null ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: InkWell(
        borderRadius: AppTheme.cardRadiusSmall,
        onTap: onTap,
        child: Container(
          margin: contentPadding,
          child: Row(
            children: <Widget>[
              if (leading != null) ...[
                leading!,
                SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (customTitle != null) customTitle!,
                    Text(
                      text,
                      style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 4),
                      DefaultTextStyle(
                        style: subtitleStyle ?? Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: 16),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
