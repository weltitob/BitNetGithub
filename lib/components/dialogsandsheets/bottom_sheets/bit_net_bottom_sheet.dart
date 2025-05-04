import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

Future<T?> BitNetBottomSheet<T>({
  required BuildContext context,
  double borderRadius = AppTheme.borderRadiusBigger,
  required Widget child,
  double? height,
  double? width,
  Color backgroundColor = Colors.transparent,
  bool isDismissible = true,
  bool isScrollControlled = true,
  bool goBack = false,
}) {
  // this should use the appbar for bottomsheets by deafult and the appbar should be build in a way wher eit can have 3 values backbutton, centertext and right a action

  return showModalBottomSheet(
      context: context,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      constraints: BoxConstraints(
        maxHeight: height ?? AppTheme.cardPadding * 22.5,
        maxWidth: width ?? AppTheme.columnWidth * 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: BitnetBottomSheetWidget(
            height: height,
            width: width,
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            isDismissible: isDismissible,
            isScrollControlled: isScrollControlled,
            goBack: goBack,
            child: child,
          ),
        );
      });
}

PersistentBottomSheetController BitNetBottomSheetNormal({
  required BuildContext context,
  double borderRadius = AppTheme.borderRadiusBigger,
  required Widget child,
  double? height,
  double? width,
  Color backgroundColor = Colors.transparent,
  bool isDismissible = true,
  bool isScrollControlled = true,
  bool goBack = false,
}) {
  return Scaffold.of(context).showBottomSheet((context) {
    return BitnetBottomSheetWidget(
      height: height,
      width: width,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      goBack: goBack,
      child: child,
    );
  },
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: height ?? AppTheme.cardPadding * 22.5,
        maxWidth: width ?? AppTheme.columnWidth * 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ));
}

class BitnetBottomSheetWidget extends StatelessWidget {
  const BitnetBottomSheetWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadius = AppTheme.borderRadiusBigger,
    this.backgroundColor = Colors.transparent,
    this.isDismissible = true,
    this.isScrollControlled = true,
    this.goBack = false,
    required this.child,
  });
  final double borderRadius;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final bool isDismissible;
  final bool isScrollControlled;
  final bool goBack;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppTheme.elementSpacing),
        Container(
          height: AppTheme.elementSpacing / 1.375,
          width: AppTheme.cardPadding * 2.25,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusCircular),
          ),
        ),
        const SizedBox(height: AppTheme.elementSpacing * 0.75),
        Expanded(
          child: Container(
            height: height != null ? (height! - AppTheme.cardPadding * 3) : AppTheme.cardPadding * 24 - AppTheme.cardPadding * 3,
            decoration: BoxDecoration(
              // Use the provided backgroundColor or fall back to theme colors
              color: backgroundColor != Colors.transparent 
                ? backgroundColor 
                : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              // Add a subtle shadow for depth
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(borderRadius), topRight: Radius.circular(borderRadius)),
              child: Column(
                children: [
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
