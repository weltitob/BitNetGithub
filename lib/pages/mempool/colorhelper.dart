import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

List<Color> getGradientColors(double medianFee, bool isAccepted) {
  double ratio = (medianFee.clamp(0, 400) / 400);

  int r, g, b;
  if (isAccepted) {
    // Blue to red gradient for accepted blocks
    r = (255 * ratio).round();
    g = 0;
    b = (255 * (1 - ratio)).round();
  } else {
    // Green to red gradient for not accepted blocks
    r = (255 * ratio).round();
    g = (255 * (1 - ratio)).round();
    b = 0;
  }

  Color firstColor = Color.fromRGBO(r, g, b, 1);
  // Slightly adjust the second color
  Color secondColor = Color.fromRGBO(
    (r + (isAccepted ? 250 : 250)).clamp(0, 255),
    (g + (isAccepted ? 50 : -50)).clamp(0, 255),
    (b + (isAccepted ? -50 : 50)).clamp(0, 255),
    1,
  );

  return [firstColor, secondColor];
}


BoxDecoration getDecoration(num medianFee, bool isAccepted) {
  List<Color> gradientColors = getGradientColors(medianFee.toDouble(), isAccepted);
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: gradientColors.first.withOpacity(0.5),
        offset: const Offset(-16, -16),
      ),
    ],
    borderRadius: AppTheme.cardRadiusMid,
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: gradientColors,
    ),
  );
}