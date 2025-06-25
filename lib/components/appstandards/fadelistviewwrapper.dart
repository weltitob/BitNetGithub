import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class HorizontalFadeListView extends StatelessWidget {
  final Widget child;

  const HorizontalFadeListView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Use a cached value of the fade color based on theme brightness
    // for better performance (avoid recalculations)
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color fadeColor = isDarkMode ? Colors.black : Colors.white;

    // Performance optimization: wrap in RepaintBoundary to isolate shader effects
    return RepaintBoundary(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          // Simplify gradient with fewer color stops for better performance
          return LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              fadeColor,
              Colors.transparent,
              Colors.transparent,
              fadeColor
            ],
            stops: const [0.0, 0.05, 0.95, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstOut,
        child: child,
      ),
    );
  }
}

/// A widget that applies vertical fade effects to its child.
///
/// Used primarily for scrollable content to create a smooth fade transition at the top
/// and optionally at the bottom.
///
/// For tab screens, use the [VerticalFadeListView.standardTab] factory constructor
/// to ensure consistent fade behavior across the app. The standard configuration
/// includes a top fade but disables the bottom fade for a cleaner UI.
///
/// Example usage:
/// ```dart
/// VerticalFadeListView.standardTab(
///   child: ListView(
///     children: [
///       // Your list items
///     ],
///   ),
/// )
/// ```
class VerticalFadeListView extends StatelessWidget {
  final Widget child;
  final bool fadeTop;
  final bool fadeBottom;
  final double topFadeStrength;
  final double bottomFadeStrength;

  /// Standard constructor with flexible parameters
  const VerticalFadeListView({
    super.key,
    required this.child,
    this.fadeTop = true,
    this.fadeBottom = false, // Default to no bottom fade for cleaner UI
    this.topFadeStrength = 0.1, // Subtle but visible fade at the top
    this.bottomFadeStrength = 0.15, // Only used when fadeBottom is true
  });

  /// Factory constructor for standardized tabs configuration
  /// This ensures consistent fade behavior across all main tabs
  factory VerticalFadeListView.standardTab({
    required Widget child,
    bool enableBottomFade = false, // Control bottom fade with a simple flag
  }) {
    return VerticalFadeListView(
      child: child,
      fadeTop: true,
      fadeBottom: enableBottomFade,
      topFadeStrength: 0.1,
      bottomFadeStrength: 0.15,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use a cached value of the fade color based on theme brightness
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color fadeColor = isDarkMode ? Colors.black : Colors.white;

    // Calculate the gradient stops based on which edges to fade
    List<double> stops = [];
    List<Color> colors = [];

    if (fadeTop && fadeBottom) {
      // Stronger fade effect for better visibility
      stops = [0.0, topFadeStrength, 1.0 - bottomFadeStrength, 1.0];
      colors = [fadeColor, Colors.transparent, Colors.transparent, fadeColor];
    } else if (fadeTop) {
      stops = [0.0, topFadeStrength, 1.0];
      colors = [fadeColor, Colors.transparent, Colors.transparent];
    } else if (fadeBottom) {
      stops = [0.0, 1.0 - bottomFadeStrength, 1.0];
      colors = [Colors.transparent, Colors.transparent, fadeColor];
    } else {
      // No fading needed
      return child;
    }

    // Print the fade settings for debugging
    print(
        "Fade settings - Top: $fadeTop ($topFadeStrength), Bottom: $fadeBottom ($bottomFadeStrength)");
    print("Using stops: $stops");

    return RepaintBoundary(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colors,
            stops: stops,
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstOut,
        child: child,
      ),
    );
  }
}

/// A smooth gradient background for transitioning between sections
class SmoothGradientDivider extends StatelessWidget {
  final double height;
  final double? width;
  final Color? topColor;
  final Color? bottomColor;

  const SmoothGradientDivider({
    super.key,
    this.height = 20.0,
    this.width,
    this.topColor,
    this.bottomColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color top = topColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withOpacity(0.0)
            : Colors.white.withOpacity(0.0));

    final Color bottom = bottomColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withOpacity(0.5)
            : Colors.white.withOpacity(0.5));

    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [top, bottom],
        ),
      ),
    );
  }
}
