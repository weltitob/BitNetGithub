import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class BitNetShaderMask extends StatelessWidget {
  final Widget child;

  const BitNetShaderMask({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            AppTheme.colorBitcoin,
            AppTheme.colorPrimaryGradient,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}