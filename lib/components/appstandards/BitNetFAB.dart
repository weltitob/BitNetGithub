import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';

class BitNetFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double iconSize;
  final IconData iconData;

  const BitNetFAB({
    Key? key,
    required this.onPressed,
    this.width = AppTheme.cardPadding * 3, // Default FAB width
    this.height = AppTheme.cardPadding * 1.5, // Default FAB height
    this.iconSize = 24.0, // Default icon size
    this.iconData = Icons.keyboard_double_arrow_down,
  }) : super(key: key);

  @override
  State<BitNetFAB> createState() => _BitNetFABState();
}

class _BitNetFABState extends State<BitNetFAB> {

  bool isHovered = false;

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderRadius.circular(widget.height / 2.5);
    return InkWell(
      borderRadius: borderRadius,
      onHover: (isHovering) {
        if (isHovering != isHovered) {
          setState(() {
            isHovered = isHovering;
          });
        }
      },
      onTap: widget.onPressed,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isHovered ? 1.0 : 0.9,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: GlassContainer(
            borderRadius: borderRadius,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: isHovered
                  ? Matrix4.translationValues(0, 2, 0) // adjust the value to control the height of the jump
                  : Matrix4.translationValues(0, -2, 0),
              child: Icon(
                widget.iconData,
                size: widget.iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
