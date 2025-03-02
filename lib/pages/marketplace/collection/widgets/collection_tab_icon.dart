import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isSelected) ...[
            Container(
              color: Colors.transparent,
              width: AppTheme.cardPadding * 1.75.h,
              height: AppTheme.cardPadding * 1.75.h,
              child: Icon(
                iconData,
                size: AppTheme.iconSize,
                color: theme.colorScheme.onPrimaryContainer.withOpacity(0.4),
              ),
            ),
          ],
          if (isSelected) ...[
            Container(
              width: AppTheme.cardPadding * 1.75.h,
              height: AppTheme.cardPadding * 1.75.h,
              child: RoundedButtonWidget(
                size: AppTheme.cardPadding * 1.75.h,
                buttonType: ButtonType.transparent,
                iconData: iconData, 
                onTap: onTap
              ),
            )
          ],
        ],
      ),
    );
  }
}