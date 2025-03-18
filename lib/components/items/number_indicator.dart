import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

Color darken(Color color, [double amount = 0.1]) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}

class NumberIndicator extends StatelessWidget {
  final int number;
  final double size;
  final bool showBorder;
  final bool useDarkVariant;

  const NumberIndicator({
    Key? key,
    required this.number,
    this.size = 0.7,
    this.showBorder = true,
    this.useDarkVariant = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    Color gradientEndColor;
    Color borderColor;
    Color textColor;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Use medal-themed colors for rankings
    if (number == 1) {
      badgeColor = const Color(0xFFFFD700); // Gold
      gradientEndColor = darken(badgeColor, 0.1);
      textColor = Colors.black87;
    } else if (number == 2) {
      badgeColor = const Color(0xFFC0C0C0); // Silver
      gradientEndColor = darken(badgeColor, 0.1);
      textColor = Colors.black87;
    } else if (number == 3) {
      badgeColor = const Color(0xFFCD7F32); // Bronze
      gradientEndColor = darken(badgeColor, 0.1);
      textColor = Colors.white;
    } else {
      badgeColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;
      gradientEndColor = isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400;
      textColor = isDarkMode ? Colors.white : Colors.black87;
    }
    
    // Apply darkening if requested (for better contrast)
    if (useDarkVariant) {
      badgeColor = darken(badgeColor, 0.15);
      gradientEndColor = darken(gradientEndColor, 0.1);
      borderColor = darken(badgeColor, 0.3);
    } else {
      borderColor = darken(badgeColor, 0.1);
    }
    
    return Container(
      width: AppTheme.cardPadding * size,
      height: AppTheme.cardPadding * size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            badgeColor,
            gradientEndColor,
          ],
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: showBorder ? [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3,
            offset: const Offset(0, 1),
            spreadRadius: 0.5,
          ),
        ] : null,
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: size * 12,
            shadows: [
              Shadow(
                blurRadius: 1.0,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}