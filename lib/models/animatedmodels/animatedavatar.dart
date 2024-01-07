import 'package:flutter/animation.dart';

class AnimatedAvatar {
  Offset position;
  late Animation<double> size;
  late AnimationController controller;
  String uri;

  AnimatedAvatar({required this.position, required TickerProvider vsync, required this.uri}) {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    )..repeat(reverse: true);

    size = Tween<double>(begin: 0, end: 50.0).animate(controller); // assuming maximum size of avatar is 50.0
  }
}
