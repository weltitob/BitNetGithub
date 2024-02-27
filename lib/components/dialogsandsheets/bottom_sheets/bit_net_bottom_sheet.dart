import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

Future<T?>  BitNetBottomSheet<T>(
    {required BuildContext context,
    double borderRadius = AppTheme.borderRadiusSmall,
    required Widget child,
    double? height,
    String title = '',
    Color backgroundColor = Colors.transparent,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool goBack = false,
    IconData? iconData}) {
  bool _hasIcon = false;
  if (iconData != null) {
    _hasIcon = true;
  }
  return showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      constraints: BoxConstraints(
        maxHeight: height ?? 500,
        maxWidth: AppTheme.columnWidth * 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      builder: (context) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: AppTheme.cardPadding,
                  right: AppTheme.cardPadding,
                  top: AppTheme.elementSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  goBack
                      ? Icon(
                          Icons.arrow_back_rounded,
                          size: AppTheme.cardPadding,
                          color: AppTheme.white70,
                        )
                      : Container(
                          width: 20,
                        ),
                  Row(
                    children: [
                      _hasIcon
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: AppTheme.elementSpacing * 0.5),
                              child: Icon(
                                iconData,
                                size: AppTheme.cardPadding,
                                color: AppTheme.white70,
                              ),
                            )
                          : Container(),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.clear_rounded,
                      size: AppTheme.cardPadding,
                      color: AppTheme.white70,
                    ),
                    onTap: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            Expanded(child: child),
          ],
        );
      });
}
