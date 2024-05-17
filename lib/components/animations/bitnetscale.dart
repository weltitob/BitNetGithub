import 'package:flutter/material.dart';


class BitNetScale extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scaleOnHover;
  final double scale;

  BitNetScale({
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
    return InkWell(
      onHover: (value) {
        setState(() {
          Logs().w("Hovered: $value");
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
