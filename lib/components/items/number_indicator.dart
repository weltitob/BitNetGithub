import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class NumberIndicator extends StatelessWidget {
  final int number;
  final double size;
  final bool showBorder;

  const NumberIndicator({
    Key? key,
    required this.number,
    this.size = 0.7,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    Color textColor = Colors.white;
    
    // Determine badge color based on rank
    if (number == 1) {
      badgeColor = const Color(0xFFFFD700); // Gold
    } else if (number == 2) {
      badgeColor = const Color(0xFFC0C0C0); // Silver
    } else if (number == 3) {
      badgeColor = const Color(0xFFCD7F32); // Bronze
    } else {
      badgeColor = Colors.grey.shade700;
      textColor = Colors.white70;
    }
    
    return Container(
      width: AppTheme.cardPadding * size,
      height: AppTheme.cardPadding * size,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
        boxShadow: showBorder ? [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: const Offset(0, 1),
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
          ),
        ),
      ),
    );
  }
}