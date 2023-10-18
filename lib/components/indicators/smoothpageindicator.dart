import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget buildIndicator({
  required PageController pageController,
  required int count,
  double expansionFactor = 3,
  double offset = 16.0,
  double dotWidth = 16.0,
  double dotHeight = 16.0,
  double spacing = 8.0,
  double radius = 16.0,
  double strokeWidth = 1.0,
  PaintingStyle paintStyle = PaintingStyle.fill,
  Color activeDotColor = AppTheme.colorBitcoin,
  //Color dotColor = AppTheme.glassMorphColorLight,
}) {
  return SmoothPageIndicator(
    controller: pageController,
    count: count,
    effect: ExpandingDotsEffect(
      expansionFactor: expansionFactor,
      offset: offset,
      dotWidth: dotWidth,
      dotHeight: dotHeight,
      spacing: spacing,
      radius: radius,
      strokeWidth: strokeWidth,
      paintStyle: paintStyle,
      activeDotColor: activeDotColor,
      dotColor: AppTheme.glassMorphColorLight,
    ),
  );
}
