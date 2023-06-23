import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget buildIndicator(PageController pageController, int count){
  return SmoothPageIndicator(
    controller: pageController,
    count: count,
    effect: ExpandingDotsEffect(
      activeDotColor: AppTheme.colorBitcoin,
      dotColor: AppTheme.glassMorphColorLight,
    ),
  );
}