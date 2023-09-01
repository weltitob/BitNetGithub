import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';


class GradientBoxBorder extends BoxBorder {
  final BorderRadius borderRadius;
  final double borderWidth;

  GradientBoxBorder({
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.borderWidth = 1.0,
  }) : super();

  @override
  BoxBorder copyWith({BorderSide? top, BorderSide? left, BorderSide? right, BorderSide? bottom}) {
    return this;
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius.toRRect(rect).deflate(borderWidth));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius.toRRect(rect));
  }

  @override
  bool get isUniform => true;

  @override
  void paint(Canvas canvas, Rect rect, {BoxShape shape = BoxShape.rectangle, BorderRadius? borderRadius, TextDirection? textDirection}) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.2)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final outer = this.borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  BorderSide get bottom => BorderSide.none;

  @override
  ShapeBorder scale(double t) {
    // scale is usually used for animation. Here we ignore this property since we don't animate the border
    return this;
  }

  @override
  BorderSide get top => BorderSide.none;

  @override
  BorderSide get left => BorderSide.none;

  @override
  BorderSide get right => BorderSide.none;
}


class GradientOutlineInputBorder extends InputBorder {
  final BorderRadius borderRadius;
  final double borderWidth;
  final bool isFocused;

  GradientOutlineInputBorder({
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.borderWidth = 1.0,
    required this.isFocused,
  }) : super();

  @override
  InputBorder copyWith({BorderSide? borderSide}) => this;

  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        double? gapStart,
        double gapExtent = 0.0,
        double gapPercentage = 0.0,
        TextDirection? textDirection,
      }) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isFocused ? [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.5),] : [Colors.white.withOpacity(0.3), Colors.transparent, Colors.transparent, Colors.white.withOpacity(0.3)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  ShapeBorder scale(double t) => this;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius.resolve(textDirection).toRRect(rect).deflate(borderWidth));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  bool get isOutline => true;
}


class GradientBorderPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final double borderWidth;

  GradientBorderPainter({
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.borderWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.centerRight,
        colors: [lighten(AppTheme.colorBitcoin, 40), AppTheme.colorBitcoin, AppTheme.colorBitcoin, lighten(AppTheme.colorBitcoin, 40)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final outer = borderRadius.toRRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}