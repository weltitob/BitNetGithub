import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:nexus_wallet/backbone/helper/theme.dart';

// Widget to display a spinning animation with three bouncing dots
Container dotProgress(BuildContext context) {
  return Container(
    child: Center(
      child: SpinKitThreeBounce(
        color: AppTheme.colorBitcoin, // Set the color of the dots
        size: AppTheme.iconSize, // Set the size of the dots
      ),
    ),
  );
}

// Widget to display a glowing icon with a specified icon and color
Widget avatarGlow(BuildContext context, IconData icon) {
  return Center(
    child: AvatarGlow(
      glowColor: darken(Colors.orange, 80), // Set the color of the glow with a darken function
      endRadius: 160.0, // Set the size of the glow
      duration: const Duration(milliseconds: 2000), // Set the duration of the animation
      repeatPauseDuration: const Duration(milliseconds: 0), // Set the duration of the pause between animations
      repeat: true, // Set the animation to repeat
      showTwoGlows: true, // Set the glow to display two glows instead of one
      child: Icon(
        icon,
        size: 100,
        color: Colors.orange, // Set the color of the icon
      ),
    ),
  );
}

// Widget to display a small glowing circle for audio progress
Widget avatarGlowProgressAudio(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0), // Set the padding for the widget
    child: Container(
      decoration: BoxDecoration(
        color: Colors.orange[600], // Set the color of the container
        borderRadius: BorderRadius.circular(40.0), // Set the border radius of the container
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0), // Set the padding for the container's child
        child: AvatarGlow(
            glowColor: Colors.white, // Set the color of the glow
            endRadius: 10.0, // Set the size of the glow
            duration: Duration(milliseconds: 1000), // Set the duration of the animation
            repeatPauseDuration: Duration(milliseconds: 0), // Set the duration of the pause between animations
            repeat: true, // Set the animation to repeat
            showTwoGlows: true, // Set the glow to display two glows instead of one
            child: Container() // Set an empty container as the child of the AvatarGlow widget
        ),
      ),
    ),
  );
}

// Widget to display a small glowing circle for progress
Widget avatarGlowProgressSmall(BuildContext context) {
  return Center(
    child: AvatarGlow(
        glowColor: Colors.orange, // Set the color of the glow
        endRadius: 20.0, // Set the size of the glow
        duration: Duration(milliseconds: 1000), // Set the duration of the animation
        repeatPauseDuration: Duration(milliseconds: 0), // Set the duration of the pause between animations
        repeat: true, // Set the animation to repeat
        showTwoGlows: true, // Set the glow to display two glows instead of one
        child: Container() // Set an empty container as the child of the AvatarGlow widget
    ),
  );
}