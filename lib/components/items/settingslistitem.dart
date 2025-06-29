import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class SettingsListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function() onTap;

  const SettingsListItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.hasNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.cardPadding * 2,
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding * 1,
      ).copyWith(
        bottom: AppTheme.elementSpacing,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: AppTheme.cardRadiusMid,
          child: Container(
            color: Colors.white.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.cardPadding,
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    this.icon,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    size: AppTheme.iconSize,
                  ),
                  const SizedBox(width: AppTheme.cardPadding),
                  Text(this.text,
                      style: Theme.of(context).textTheme.titleSmall),
                  const Spacer(),
                  if (this.hasNavigation)
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: AppTheme.iconSize * 0.75,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
