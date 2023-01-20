import 'dart:ui';

import 'package:flutter/material.dart';
import '../../theme.dart';

//ignore: must_be_immutable
class RoundedBoxWidget extends StatefulWidget {
  Widget child;
  RoundedBoxWidget({super.key,
    required this.child,});

  @override
  State<RoundedBoxWidget> createState() => _RoundedBoxWidgetState();
}

class _RoundedBoxWidgetState extends State<RoundedBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
      child: Container(
          padding: const EdgeInsets.only(top: AppTheme.elementSpacing, bottom: AppTheme.elementSpacing, left: AppTheme.cardPadding, right: AppTheme.cardPadding),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
              boxShadow: [
                AppTheme.boxShadowProfile
              ],
              borderRadius: AppTheme.cardRadiusBig),
          child: widget.child
      ),
    );
  }
}

class RoundedBoxWidgetBlur extends StatefulWidget {
  Widget child;
  RoundedBoxWidgetBlur({
    required this.child,});

  @override
  State<RoundedBoxWidgetBlur> createState() => _RoundedBoxWidgetBlurState();
}

class _RoundedBoxWidgetBlurState extends State<RoundedBoxWidgetBlur> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
      child: ClipRRect(
        borderRadius: AppTheme.cardRadiusBig,
        child: BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
          child: Container(
              padding: const EdgeInsets.only(top: AppTheme.elementSpacing, bottom: AppTheme.elementSpacing, left: AppTheme.cardPadding, right: AppTheme.cardPadding),
              decoration: BoxDecoration(
                borderRadius: AppTheme.cardRadiusBig,
                color: AppTheme.glassMorphColorDark,
                boxShadow: [
                  AppTheme.boxShadowProfile
                ],
              ),
              child: widget.child
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildRoundedBoxWithoutPadding extends StatefulWidget {
  Widget child;
  BuildRoundedBoxWithoutPadding({
    required this.child,});

  @override
  State<BuildRoundedBoxWithoutPadding> createState() => _BuildRoundedBoxStatePaddingless();
}

class _BuildRoundedBoxStatePaddingless extends State<BuildRoundedBoxWithoutPadding> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
      child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                AppTheme.boxShadowProfile
              ],
              borderRadius: AppTheme.cardRadiusBig),
          child: widget.child
      ),
    );
  }
}


class BuildRoundedBoxWithText extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Widget child;

  const BuildRoundedBoxWithText({
    required this.text,
    required this.iconData,
    required this.child,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.cardPadding),
      child: Container(
        padding: const EdgeInsets.only(top: AppTheme.cardPadding, bottom: AppTheme.elementSpacing),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            boxShadow: [
              AppTheme.boxShadowBig
            ],
            borderRadius: AppTheme.cardRadiusMid),
        child: Column(
          children: [
            buildBoxCategory(text, iconData, context),
            child
          ],
        ),
      ),
    );
  }
  Widget buildBoxCategory(String header, myicon, BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppTheme.cardPadding,
          right: AppTheme.cardPadding,
          bottom: AppTheme.cardPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  myicon,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppTheme.elementSpacing),
                  child: Text(
                      header,
                      style: Theme.of(context).textTheme.headline5!
                          .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer,)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}