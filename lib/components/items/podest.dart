import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetShaderMask.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/website/contact/submitidea/submitidea.dart';
import 'package:flutter/material.dart';

class PodestWidget extends StatefulWidget {
  final SubmitIdeaController controller;
  final String avatarName;
  final String avatarTag;
  final String avatarUri;
  final double height;
  final double width;
  final double size;
  final int counterValue;
  final VoidCallback? onTap;

  const PodestWidget({
    Key? key,
    this.avatarName = "",
    required this.controller,
    this.avatarTag = "",
    this.avatarUri = "",
    this.height = AppTheme.cardPadding * 5.5,
    this.width = AppTheme.cardPadding * 5.5,
    required this.size,
    required this.counterValue,
    required this.onTap,
  }) : super(key: key);

  @override
  _PodestWidgetState createState() => _PodestWidgetState();
}

class _PodestWidgetState extends State<PodestWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (isHovering) {
        if (isHovering != isHovered) {
          setState(() {
            widget.controller.changeSelected(widget.counterValue - 1);
            isHovered = isHovering;
          });
        }
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isHovered ? 1.0 : 0.9,
        child: Column(
          children: [
            AnimatedContainer(
              transform: isHovered
                  ? Matrix4.translationValues(0, -4,
                      0) // adjust the value to control the height of the jump
                  : Matrix4.translationValues(0, 4, 0),
              duration: Duration(milliseconds: 200),
              child: Column(
                children: [
                  Avatar(
                    name: widget.avatarName,
                    size: AppTheme.cardPadding * 4,
                    mxContent: Uri.parse(widget.avatarUri),
                  ),
                  SizedBox(height: AppTheme.elementSpacing),
                  isHovered ? BitNetShaderMask(child: Text(
                    widget.avatarName,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white90)
                  )) : Text(
                    widget.avatarName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppTheme.cardPadding),
            GlassContainer(
              width: widget.width,
              height: widget.height,
              child: Container(
                alignment: Alignment.center,
                child: isHovered
                    ? BitNetShaderMask(
                        child: Text(
                          widget.counterValue.toString(),
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      )
                    : Text(
                        widget.counterValue.toString(),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
