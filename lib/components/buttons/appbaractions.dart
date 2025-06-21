import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
  // Add an IconData parameter to the constructor
  final IconData iconData;

  // Modify the constructor to accept the IconData
  const AppBarActionButton({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: AppTheme.elementSpacing * 1.5,
        left: AppTheme.elementSpacing * 0.5,
      ),
      child: GlassContainer(
          border: Border.all(width: 4, color: Theme.of(context).dividerColor), // remove border if not active
          opacity: 0.1,
          borderRadius: AppTheme.borderRadiusCircular,
          child: Container(
            height: AppTheme.cardPadding * 1,
            width: AppTheme.cardPadding * 1,
            alignment: Alignment.center,
            child: Center(
              // Use the passed IconData for the icon
              child: Container(
                height: AppTheme.cardPadding * 1,
                width: AppTheme.cardPadding * 1,
                child: Icon(
                  iconData,
                  color: AppTheme.white90,
                  size: AppTheme.cardPadding * 0.7,
                ),
              ),
            ),
          )),
    );
  }
}
