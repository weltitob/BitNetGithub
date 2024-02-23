import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class BitNetListTile extends StatelessWidget {
  final Widget? leading;
  final String text;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry margin;
  final Function()? onTap;
  final Function()? onLongPress; // Add this line
  final Color? tileColor;
  final ShapeBorder? shape;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool isinsideBottomSheet;
  final Widget? customTitle;
  final VisualDensity? visualDensity; // Add this line
  final bool selected;
  final bool isActive;

  const BitNetListTile({
    super.key,
    this.leading,
    this.text = "",
    this.subtitle,
    this.trailing,
    this.contentPadding = const EdgeInsets.symmetric(
        horizontal: AppTheme.elementSpacing * 0.75, vertical: AppTheme.elementSpacing * 0.75),
    this.onTap,
    this.onLongPress, // Add this line
    this.tileColor,
    this.shape,
    this.titleStyle,
    this.subtitleStyle,
    this.isinsideBottomSheet = false,
    this.customTitle,
    this.visualDensity, // Add this line
    this.selected = false,
    this.isActive = false,
    this.margin = const EdgeInsets.only(
      top: AppTheme.elementSpacing,
      left: AppTheme.elementSpacing / 2,
      right: AppTheme.elementSpacing / 2,
    ),

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusSmall,
        color: selected
            ? Colors.white.withOpacity(0.15)
            : isActive
            ? Theme.of(context).colorScheme.secondaryContainer
            : Colors.transparent,
        border: selected
            ? GradientBoxBorder(
          borderRadius: AppTheme.cardRadiusSmall,
        )
            : GradientBoxBorder(
          isTransparent: true,
          borderRadius: AppTheme.cardRadiusSmall,
        )
      ),
      child: InkWell(
        borderRadius: AppTheme.cardRadiusSmall,
        onTap: onTap,
        onLongPress: onLongPress, // Add this line
        customBorder: shape,
        //visualDensity: visualDensity, // Add this line
        child: Container(
          child: Padding(
            padding: contentPadding,
            child: Row(
              children: <Widget>[
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: AppTheme.elementSpacing),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (customTitle != null) Container(
                          child: customTitle!),

                      if (customTitle == null)Text(
                        text,
                        style:
                            titleStyle ?? Theme.of(context).textTheme.titleMedium,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 2),
                        DefaultTextStyle(
                          style: subtitleStyle ??
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
      ),
    );
  }
}
