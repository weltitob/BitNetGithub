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
            colors: [fadeColor, Colors.transparent, Colors.transparent, fadeColor],
            stops: const [0.0, 0.05, 0.95, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstOut,
        child: child,
      ),
    );
  }
}

class VerticalFadeListView extends StatelessWidget {
  final Widget child;

  const VerticalFadeListView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
          stops: [0.0, 0.05, 0.95, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstOut,
      child: child,
    );
  }
}
