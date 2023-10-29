import 'package:flutter/material.dart';

class HorizontalFadeListView extends StatelessWidget {
  final Widget child;

  const HorizontalFadeListView({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Colors.black,
            Colors.transparent,
            Colors.transparent,
            Colors.black
          ],
          stops: [
            0.0,
            0.05,
            0.95,
            1.0
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstOut,
      child: child,
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
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.transparent,
            Colors.transparent,
            Colors.black
          ],
          stops: [
            0.0,
            0.05,
            0.95,
            1.0
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstOut,
      child: child,
    );
  }
}
