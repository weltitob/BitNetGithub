import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({
    required this.child}) : super();
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: AppTheme.elementSpacing, left: AppTheme.cardPadding),
              child: Divider(color: Colors.grey[400]),
            )),
        child,
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: AppTheme.elementSpacing, right: AppTheme.cardPadding),
              child: Divider(color: Colors.grey[400]),
            )),
      ],
    );
  }
}