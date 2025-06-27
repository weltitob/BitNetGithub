import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BitNetScale extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scaleOnHover;
  final double scale;

  const BitNetScale({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.scaleOnHover = 1.0,
    this.scale = 0.9,
  }) : super(key: key);

  @override
  _BitNetScaleState createState() => _BitNetScaleState();
}

class _BitNetScaleState extends State<BitNetScale> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    LoggerService logger = Get.find();
    return InkWell(
      onHover: (value) {
        setState(() {
          logger.i("Hovered: $value");
          isHovered = value;
        });
      },
      child: AnimatedScale(
        duration: widget.duration,
        scale: isHovered ? widget.scaleOnHover : widget.scale,
        child: widget.child,
      ),
    );
  }
}
