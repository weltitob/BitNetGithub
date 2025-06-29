import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

// Widget to display a spinning animation with three bouncing dots

Container dotProgress(BuildContext context, {Color? color, double? size}) {
  return Container(
    constraints: BoxConstraints.tightFor(),
    child: Center(
      child: SpinKitThreeBounce(
        color: color ??
            Theme.of(context).colorScheme.primary, // Set the color of the dots
        size: size ??
            AppTheme
                .iconSize, // Set the size of the dots, with a fallback to the default
      ),
    ),
  );
}

// Widget to display a glowing icon with a specified icon and color
Widget avatarGlow(BuildContext context, IconData icon) {
  return Center(
    child: AvatarGlow(
      glowColor: darken(Theme.of(context).colorScheme.primary,
          80), // Set the color of the glow with a darken function
      glowBorderRadius: BorderRadius.circular(160),
      duration: const Duration(
          milliseconds: 2000), // Set the duration of the animation
      startDelay: const Duration(
          milliseconds: 0), // Set the duration of the pause between animations
      repeat: true, // Set the animation to repeat
      child: Icon(
        icon,
        size: 100,
        color:
            Theme.of(context).colorScheme.primary, // Set the color of the icon
      ),
    ),
  );
}

// Widget to display a small glowing circle for audio progress
Widget avatarGlowProgressAudio(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
        top: 5.0, bottom: 5.0, right: 10.0), // Set the padding for the widget
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .primary, // Set the color of the container
        borderRadius: BorderRadius.circular(
            40.0), // Set the border radius of the container
      ),
      child: Padding(
        padding: const EdgeInsets.all(
            4.0), // Set the padding for the container's child
        child: AvatarGlow(
            glowColor: Colors.white, // Set the color of the glow
            glowBorderRadius: BorderRadius.circular(10),
            duration: const Duration(
                milliseconds: 1000), // Set the duration of the animation
            startDelay: const Duration(
                milliseconds:
                    0), // Set the duration of the pause between animations
            repeat: true, // Set the animation to repeat
            child:
                Container() // Set an empty container as the child of the AvatarGlow widget
            ),
      ),
    ),
  );
}

// Widget to display a small glowing circle for progress
Widget avatarGlowProgressSmall(BuildContext context) {
  return Center(
    child: AvatarGlow(
        glowColor:
            Theme.of(context).colorScheme.primary, // Set the color of the glow
        glowBorderRadius: BorderRadius.circular(20),
        duration: const Duration(
            milliseconds: 1000), // Set the duration of the animation
        startDelay: const Duration(
            milliseconds:
                0), // Set the duration of the pause between animations
        repeat: true, // Set the animation to repeat
        child:
            Container() // Set an empty container as the child of the AvatarGlow widget
        ),
  );
}
