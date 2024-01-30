import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
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
        top: AppTheme.elementSpacing,
        bottom: AppTheme.elementSpacing,
        right: AppTheme.elementSpacing * 1.5,
        left: AppTheme.elementSpacing * 0.5,
      ),
      child: GlassContainer(
          borderThickness: 4, // remove border if not active
          blur: 50,
          opacity: 0.1,
          borderRadius: AppTheme.cardRadiusCircular,
          child: Container(
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
