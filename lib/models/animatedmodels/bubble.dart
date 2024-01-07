
import 'package:flutter/animation.dart';

class Bubble {
  Offset position;
  Color color;
  late Animation<double> radius;
  late AnimationController controller;

  Bubble({required this.position, required this.color, required TickerProvider vsync}) {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    )..repeat(reverse: true);

    radius = Tween<double>(begin: 0, end: 20.0).animate(controller);
  }
}

