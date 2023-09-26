import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class SocialRow extends StatelessWidget {
  IconData? iconData;
  final String platformName;

  SocialRow({
    this.iconData,
    required this.platformName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.elementSpacing / 1.25),
      child: Row(
        children: [
          if (iconData != null) Icon(iconData, size: AppTheme.elementSpacing * 1.5),
          if (iconData != null) SizedBox(width: AppTheme.elementSpacing / 2),
          Text(platformName, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}