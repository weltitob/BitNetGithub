import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionTabIcon extends StatelessWidget {
  final IconData iconData;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const CollectionTabIcon({
    Key? key,
    required this.iconData,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isSelected = (currentIndex == index);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 40.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              iconData,
              size: 26,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            
            // Animated underline indicator
            AnimatedContainer(
              duration: AppTheme.animationDuration,
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(top: 6),
              height: 3,
              width: isSelected ? 28 : 0,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}