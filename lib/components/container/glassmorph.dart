import 'dart:ui';

import 'package:BitNet/backbone/helper/theme.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
class Glassmorphism extends StatelessWidget {
  final double blur;
  final double opacity;
  final double radius;
  final Widget child;
  final Alignment gradientBegin;
  final Alignment gradientEnd;

  const Glassmorphism({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.radius,
    required this.child,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassmorphicFlexContainer(
      borderRadius: radius,
      blur: blur,
      alignment: Alignment.bottomCenter,
      border: 1.2,
      linearGradient: LinearGradient(
          begin: gradientBegin,
          end: gradientEnd,
          colors: [
            Color(0xFFffffff).withOpacity(opacity),
            Color(0xFFFFFFFF).withOpacity(opacity / 4),
          ],
          stops: [
            0.1,
            1,
          ]),
      borderGradient: LinearGradient(
        begin: gradientBegin,
        end: gradientEnd,
        colors: [
          Color(0xFFffffff).withOpacity(0.15),
          Color((0xFFFFFFFF)).withOpacity(0.15),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class GlassmorphismColored extends StatelessWidget {
  final double blur;
  final double opacity;
  final double radius;
  final Widget child;
  final Color color;

  const GlassmorphismColored({
    Key? key,
    required this.blur,
    required this.color,
    required this.opacity,
    required this.radius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(opacity),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            border: Border.all(
              width: 1.5,
              color: color.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
