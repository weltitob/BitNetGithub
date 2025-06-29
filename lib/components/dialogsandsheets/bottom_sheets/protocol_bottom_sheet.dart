import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/router.dart';
import 'package:flutter/material.dart';

Future<T?> showProtocolBottomSheet<T>({
  double borderRadius = AppTheme.borderRadiusBigger,
  required Widget child,
  double? height,
  double? width,
  Color backgroundColor = Colors.transparent,
  bool isDismissible = true,
  bool isScrollControlled = true,
  bool goBack = false,
  Function(bool)? onDismissed,
}) {
  // this should use the appbar for bottomsheets by deafult and the appbar should be build in a way wher eit can have 3 values backbutton, centertext and right a action

  return showModalBottomSheet(
      context: AppRouter.navigatorKey.currentContext!,
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
        return ProtocolBottomSheetWidget(
          height: height,
          width: width,
          borderRadius: borderRadius,
          backgroundColor: backgroundColor,
          isDismissible: isDismissible,
          isScrollControlled: isScrollControlled,
          goBack: goBack,
          onDismissed: onDismissed,
          child: child,
        );
      });
}

class ProtocolBottomSheetWidget extends StatelessWidget {
  const ProtocolBottomSheetWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadius = AppTheme.borderRadiusBigger,
    this.backgroundColor = Colors.transparent,
    this.isDismissible = true,
    this.isScrollControlled = true,
    this.goBack = false,
    required this.child,
    this.onDismissed,
  });
  final double borderRadius;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final bool isDismissible;
  final bool isScrollControlled;
  final bool goBack;
  final Widget child;
  //the bool stands for whether the protcol was handled and satisfied or not
  final Function(bool)? onDismissed;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool) {
        if (onDismissed != null) {
          onDismissed!(false);
        }
      },
      child: Column(
        children: [
          const SizedBox(height: AppTheme.elementSpacing),
          Container(
            height: AppTheme.elementSpacing / 1.5,
            width: AppTheme.cardPadding * 2.25,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius:
                  BorderRadius.circular(AppTheme.borderRadiusCircular),
            ),
          ),
          const SizedBox(height: AppTheme.elementSpacing * 0.75),
          Expanded(
            child: Container(
              height: height != null
                  ? (height! - AppTheme.cardPadding * 3)
                  : AppTheme.cardPadding * 24 - AppTheme.cardPadding * 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  colors: Theme.of(context).brightness == Brightness.light
                      ? [
                          lighten(
                              Theme.of(context).colorScheme.primaryContainer,
                              40),
                          lighten(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  40)
                              .withOpacity(0.9),
                          lighten(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  40)
                              .withOpacity(0.7),
                          lighten(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  40)
                              .withOpacity(0.4),
                          lighten(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  40)
                              .withOpacity(0.0001),
                        ]
                      : [
                          darken(Theme.of(context).colorScheme.primaryContainer,
                              70),
                          darken(Theme.of(context).colorScheme.primaryContainer,
                                  70)
                              .withOpacity(0.9),
                          darken(Theme.of(context).colorScheme.primaryContainer,
                                  70)
                              .withOpacity(0.7),
                          darken(Theme.of(context).colorScheme.primaryContainer,
                                  70)
                              .withOpacity(0.4),
                          darken(Theme.of(context).colorScheme.primaryContainer,
                                  70)
                              .withOpacity(0.0001),
                        ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius)),
                child: Column(
                  children: [
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
