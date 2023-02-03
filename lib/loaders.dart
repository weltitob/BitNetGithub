import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:nexus_wallet/theme.dart';

Widget avatarGlow(BuildContext context, IconData icon) {
  return Center(
    child: AvatarGlow(
      glowColor: darken(Colors.orange, 80),
      endRadius: 160.0,
      duration: const Duration(milliseconds: 2000),
      repeatPauseDuration: const Duration(milliseconds: 0),
      repeat: true,
      showTwoGlows: true,
      child: Icon(
        icon,
        size: 100,
        color: Colors.orange,
      ),
    ),
  );
}

Widget avatarGlowProgressAudio(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.orange[600],
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AvatarGlow(
            glowColor: Colors.white,
            endRadius: 10.0,
            duration: Duration(milliseconds: 1000),
            repeatPauseDuration: Duration(milliseconds: 0),
            repeat: true,
            showTwoGlows: true,
            child: Container()
        ),
      ),
    ),
  );
}

Widget avatarGlowProgressSmall(BuildContext context) {
  return Center(
    child: AvatarGlow(
        glowColor: Colors.orange,
        endRadius: 20.0,
        duration: Duration(milliseconds: 1000),
        repeatPauseDuration: Duration(milliseconds: 0),
        repeat: true,
        showTwoGlows: true,
        child: Container()
    ),
  );
}