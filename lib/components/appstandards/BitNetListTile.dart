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

  const BitNetListTile({
    super.key,
    this.leading,
    this.text = "",
    this.subtitle,
    this.trailing,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.onTap,
    this.tileColor,
    this.shape,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: AppTheme.elementSpacing, left: AppTheme.elementSpacing, right: AppTheme.elementSpacing,),
        padding: contentPadding,
        decoration: BoxDecoration(
          color: tileColor ?? Colors.white.withOpacity(0.1),
          borderRadius: AppTheme.cardRadiusSmall,
          border: shape != null ? null : Border.all(color: Colors.grey.shade300),
        ),
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
                  Text(
                    text,
                    style: titleStyle ?? Theme.of(context).textTheme.subtitle1,
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
    );
  }
}
