import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

Future<T?> BitNetBottomSheet<T>(
    {required BuildContext context,
    double borderRadius = AppTheme.borderRadiusBigger,
    required Widget child,
    double? height,
    double? width,
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

  // this should use the appbar for bottomsheets by deafult and the appbar should be build in a way wher eit can have 3 values backbutton, centertext and right a action

  return showModalBottomSheet(
      context: context,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      constraints: BoxConstraints(
        maxHeight: height ?? AppTheme.cardPadding * 22.5,
        maxWidth:width?? AppTheme.columnWidth * 1.5,
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
            SizedBox(height: AppTheme.elementSpacing),
            Container(
              height: AppTheme.elementSpacing / 1.5,
              width: AppTheme.cardPadding * 2.25,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                borderRadius:
                    BorderRadius.circular(AppTheme.borderRadiusCircular),
              ),
            ),
            SizedBox(height: AppTheme.elementSpacing * 0.75),
            Container(
              height: height != null
                  ? (height - AppTheme.cardPadding * 3)
                  : AppTheme.cardPadding * 24 - AppTheme.cardPadding * 3,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
              ),
              child: Column(
                children: [
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        );
      });
}
