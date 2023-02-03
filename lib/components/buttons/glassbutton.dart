import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/theme.dart';

Widget glassButton(String text, IconData iconData, Function() function) {
  return Glassmorphism(
    blur: 20,
    opacity: 0.1,
    radius: 50.0,
    child: TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(50, 30),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft),
      onPressed: () {
        // handle push to HomeScreen
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.elementSpacing * 0.5,
          horizontal: AppTheme.elementSpacing,
        ),
        child: Row(
          children: [
            Icon(iconData, color: AppTheme.white80, size: 22,),
            const SizedBox(width: AppTheme.elementSpacing / 2,),
            Text(
              text,
              style:
              AppTheme.textTheme.caption!.copyWith
                (color: AppTheme.white80, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}