import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/animatedmodels/bubble.dart';

class BubbleWidget extends StatefulWidget {
  final double width;
  final double height;

  const BubbleWidget({required this.width, required this.height});

  @override
  _BubbleWidgetState createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<BubbleWidget> with TickerProviderStateMixin {
  List<Bubble> bubbles = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();

    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 200)); // Creates a bubble every half-second
      if(!mounted) {
        return false;
      }
      final bubble = Bubble(
        position: Offset(random.nextDouble() * widget.width, random.nextDouble() * widget.height),
        color: Colors.white.withAlpha(50 + random.nextInt(200)),
        vsync: this,
      );

      // Randomize the bubble size with a maximum radius of 20
      double endRadius = 5 + random.nextDouble() * 5;
      bubble.radius = Tween<double>(begin: 0, end: endRadius).animate(bubble.controller);

      // Speed up the animation
      bubble.controller.duration = const Duration(milliseconds: 750);

      bubble.controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          bubble.controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          bubble.controller.dispose();
          setState(() {
            bubbles.remove(bubble);
          });
        }
      });

      bubble.controller.forward();

      setState(() {
        bubbles.add(bubble);
      });

      return true;
    });
  }

  @override
  void dispose() {
    for (var bubble in bubbles) {
      bubble.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(bubbles: bubbles),
      child: Container(),
    );
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblePainter({required this.bubbles}) : super(repaint: Listenable.merge(bubbles.map((e) => e.controller).toList()));

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var bubble in bubbles) {
      paint.color = bubble.color;
      canvas.drawCircle(bubble.position, bubble.radius.value, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) {
    return oldDelegate.bubbles != bubbles;
  }
}
