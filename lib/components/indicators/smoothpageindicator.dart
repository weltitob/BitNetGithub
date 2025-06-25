import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomIndicator extends StatelessWidget {
  final PageController pageController;
  final int count;
  final double expansionFactor;
  final double offset;
  final double dotWidth;
  final double dotHeight;
  final double spacing;
  final double radius;
  final double strokeWidth;
  final PaintingStyle paintStyle;
  final Color activeDotColor;
  final Function(int)? onClickIndicator;
  const CustomIndicator({
    Key? key,
    required this.pageController,
    required this.count,
    this.expansionFactor = 3,
    this.offset = 16.0,
    this.dotWidth = 16.0,
    this.dotHeight = 16.0,
    this.spacing = 8.0,
    this.radius = 16.0,
    this.strokeWidth = 1.0,
    this.paintStyle = PaintingStyle.fill,
    this.activeDotColor = AppTheme.colorBitcoin,
    this.onClickIndicator, // Define this in your app theme
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        activeDotColor: Theme.of(context).colorScheme.primary,
        dotColor: Theme.of(context).brightness == Brightness.light
            ? AppTheme.white60
            : AppTheme
                .glassMorphColorLight, // Define these colors in your app theme
      ),
      onDotClicked: onClickIndicator,
    );
  }
}
