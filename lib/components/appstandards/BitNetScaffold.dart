import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';


class bitnetScaffold extends StatelessWidget {
  final Widget body;
  final Color? gradientColor;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final BuildContext context;
  final bool extendBodyBehindAppBar;
  final bool extendBodyBehindBottomNav;
  final Widget? floatingActionButton;
  final bool removeGradientColor;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset; // New attribute

  const bitnetScaffold({
    Key? key,
    required this.body,
    required this.context,
    this.margin,
    this.appBar,
    this.backgroundColor,
    this.gradientColor,
    this.extendBodyBehindAppBar = false,
    this.extendBodyBehindBottomNav = false,
    this.removeGradientColor = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked,
    this.resizeToAvoidBottomInset = true, // New parameter with default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              // The screen background is a gradient
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).brightness == Brightness.light ? lighten(Theme.of(context).colorScheme.primaryContainer, 60) :darken(Theme.of(context).colorScheme.primaryContainer, 80),
                        Theme.of(context).brightness == Brightness.light ? lighten(Theme.of(context).colorScheme.tertiaryContainer, 60) :darken(Theme.of(context).colorScheme.tertiaryContainer, 80),
                      ])),
              child: Padding(
                padding: extendBodyBehindBottomNav ? EdgeInsets.only(bottom: AppTheme.cardPadding * 3) : EdgeInsets.zero,
                child: Container(
                    margin: margin,
                    child: body,
                ),
              ),
            ),
            extendBodyBehindAppBar ?
            removeGradientColor ? Container() : Container(
              width: double.infinity,
              height: AppTheme.cardPadding * 3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                      colors: [
                        lighten(Theme.of(context).colorScheme.primaryContainer, 60),
                        lighten(Theme.of(context).colorScheme.primaryContainer, 60).withOpacity(0.9),
                        lighten(Theme.of(context).colorScheme.primaryContainer, 60).withOpacity(0.7),
                        lighten(Theme.of(context).colorScheme.primaryContainer, 60).withOpacity(0.4),
                        lighten(Theme.of(context).colorScheme.primaryContainer, 60).withOpacity(0.0001),
                      ])),
            ) : Container(),
          ],
        ),
        appBar: appBar,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.cardPadding),
          child: floatingActionButton,
        ),  // Use the passed floating action button
        floatingActionButtonLocation: floatingActionButtonLocation, // Use the passed floating action button location
      ),
    );
  }
}
