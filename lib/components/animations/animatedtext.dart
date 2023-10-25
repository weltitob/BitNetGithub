import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/horizontallistviewwrapper.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AnimatedText extends StatefulWidget {
  final String text;

  const AnimatedText({Key? key, required this.text}) : super(key: key);
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return HorizontalFadeListView(
      child: Marquee(
        text: widget.text,
        style: TextStyle(fontWeight: FontWeight.bold),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        blankSpace: AppTheme.cardPadding,
        velocity: 100.0,
        pauseAfterRound: Duration(seconds: 2),
        startPadding: AppTheme.elementSpacing / 2,
        accelerationDuration: Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}