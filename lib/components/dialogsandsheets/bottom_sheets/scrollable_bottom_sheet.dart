import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

/// Utility functions for color manipulation
Color lighten(Color color, [int amount = 10]) {
  assert(amount >= 0 && amount <= 100);
  final hsl = HSLColor.fromColor(color);
  final lightness = (hsl.lightness + (amount / 100)).clamp(0.0, 1.0);
  return hsl.withLightness(lightness).toColor();
}

Color darken(Color color, [int amount = 10]) {
  assert(amount >= 0 && amount <= 100);
  final hsl = HSLColor.fromColor(color);
  final lightness = (hsl.lightness - (amount / 100)).clamp(0.0, 1.0);
  return hsl.withLightness(lightness).toColor();
}

/// A scrollable bottom sheet widget that automatically adjusts to keyboard height
/// and prevents bottom overflow issues.
class ScrollableBottomSheet extends StatelessWidget {
  final Widget child;
  final double? maxHeight;
  final String? title;
  final Color backgroundColor;
  final double borderRadius;
  final Widget? appBar;
  
  const ScrollableBottomSheet({
    Key? key,
    required this.child,
    this.maxHeight,
    this.title,
    this.appBar,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = AppTheme.borderRadiusBigger,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate available height accounting for keyboard and safe areas
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Use maximum of 80% of screen height by default, adjustable with maxHeight parameter
    final defaultMaxHeight = screenHeight * 0.8;
    final actualMaxHeight = maxHeight ?? defaultMaxHeight;
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: actualMaxHeight,
      ),
      // This padding accounts for the keyboard height
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top handle for the bottom sheet
          const SizedBox(height: AppTheme.elementSpacing),
          Container(
            height: AppTheme.elementSpacing / 1.375,
            width: AppTheme.cardPadding * 2.25,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin 
                ? Colors.grey 
                : Theme.of(context).brightness == Brightness.light 
                  ? lighten(Theme.of(context).colorScheme.primaryContainer, 40) 
                  : darken(Theme.of(context).colorScheme.primaryContainer, 70),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusCircular),
            ),
          ),
          const SizedBox(height: AppTheme.elementSpacing * 0.75),
          
          // The main container with the content
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                  colors:
                  Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin 
                  ? [Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey] 
                  : Theme.of(context).brightness == Brightness.light
                      ? [
                          lighten(Theme.of(context).colorScheme.primaryContainer, 40),
                          lighten(Theme.of(context).colorScheme.primaryContainer, 40).withOpacity(0.9),
                          lighten(Theme.of(context).colorScheme.primaryContainer, 40).withOpacity(0.7),
                          lighten(Theme.of(context).colorScheme.primaryContainer, 40).withOpacity(0.4),
                          lighten(Theme.of(context).colorScheme.primaryContainer, 40).withOpacity(0.0001),
                        ]
                      : [
                          darken(Theme.of(context).colorScheme.primaryContainer, 70),
                          darken(Theme.of(context).colorScheme.primaryContainer, 70).withOpacity(0.9),
                          darken(Theme.of(context).colorScheme.primaryContainer, 70).withOpacity(0.7),
                          darken(Theme.of(context).colorScheme.primaryContainer, 70).withOpacity(0.4),
                          darken(Theme.of(context).colorScheme.primaryContainer, 70).withOpacity(0.0001),
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
                  topRight: Radius.circular(borderRadius),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Custom app bar if provided
                    if (appBar != null) appBar!,
                    
                    // Title if no appBar but title is provided
                    if (appBar == null && title != null)
                      Padding(
                        padding: const EdgeInsets.all(AppTheme.elementSpacing),
                        child: Text(
                          title!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    
                    // Main content in a scrollable area
                    Flexible(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: child,
                      ),
                    ),
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

/// A function to show a scrollable bottom sheet as a modal
Future<T?> showScrollableBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double? maxHeight,
  String? title,
  Widget? appBar,
  bool isDismissible = true,
  bool isScrollControlled = true,
  double borderRadius = AppTheme.borderRadiusBigger,
  Color backgroundColor = Colors.transparent,
}) {
  return showModalBottomSheet(
    context: context,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    isDismissible: isDismissible,
    isScrollControlled: isScrollControlled,
    constraints: BoxConstraints(
      maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
      maxWidth: MediaQuery.of(context).size.width,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      ),
    ),
    builder: (context) {
      return ScrollableBottomSheet(
        maxHeight: maxHeight,
        title: title,
        appBar: appBar,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        child: child,
      );
    },
  );
}