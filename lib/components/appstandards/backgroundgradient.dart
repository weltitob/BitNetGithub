import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

// Create a StatefulWidget for the background animation
class BackgroundGradient extends StatefulWidget {
  final Widget child;
  final Color colorprimary;
  final Color colorsecondary;
  final BorderRadius borderRadius;
  const BackgroundGradient({
    Key? key,
    required this.child,
    required this.colorprimary,
    required this.colorsecondary,
    required this.borderRadius
  }) : super(key: key);

  @override
  State<BackgroundGradient> createState() => _BackgroundGradientState();
}

// Create a State class for the background animation
class _BackgroundGradientState extends State<BackgroundGradient> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.25, 0.75, 1],
              colors: [
                Colors.white,
                widget.colorprimary,
                widget.colorsecondary,
                Colors.white,
              ],
            ),
          ),
          child: ClipRRect(
            borderRadius: widget.borderRadius,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    widget.colorprimary,
                    widget.colorsecondary,
                  ],
                ),
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

