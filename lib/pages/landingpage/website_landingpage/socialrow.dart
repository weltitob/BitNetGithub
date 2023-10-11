import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class SocialRow extends StatelessWidget {
  IconData? iconData;
  final String platformName;
  final VoidCallback? onTap;  // <-- Declare an onTap function

  SocialRow({
    this.iconData,
    required this.platformName,
    this.onTap,  // <-- Initialize it in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing / 1.25),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,  // <-- Use the passed function here
          child: Row(
            children: [
              if (iconData != null) Icon(iconData, size: AppTheme.elementSpacing * 1.5),
              if (iconData != null) SizedBox(width: AppTheme.elementSpacing / 2),
              Text(platformName, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
