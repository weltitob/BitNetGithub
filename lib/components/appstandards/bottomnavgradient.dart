import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BottomNavGradient extends StatelessWidget {
  const BottomNavGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.cardPadding * 1.75.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // Use color stops to create an "exponential" effect
          stops: [0.0, 0.3, 0.6, 0.7, 0.9, 1.0],
          colors: Theme.of(context).brightness == Brightness.light
              ? [
            lighten(
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                50)
                .withOpacity(0.0001),
            lighten(
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                50)
                .withOpacity(0.3),
            lighten(
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                50)
                .withOpacity(0.6),
            lighten(
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                50)
                .withOpacity(0.9),
            lighten(
                Theme.of(context).colorScheme.primaryContainer,
                50),
            lighten(
                Theme.of(context).colorScheme.primaryContainer,
                50)
          ]
              : [
            darken(
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                80)
                .withOpacity(0.0001),
            darken(
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                80)
                .withOpacity(0.3),
            darken(
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                80)
                .withOpacity(0.6),
            darken(
                Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                80)
                .withOpacity(0.9),
            darken(
                Theme.of(context).colorScheme.primaryContainer,
                80),
            darken(
                Theme.of(context).colorScheme.primaryContainer,
                80)
          ],
        ),
      ),
    );
  }
}
