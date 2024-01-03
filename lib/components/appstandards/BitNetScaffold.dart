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
  final Widget? floatingActionButton;  // New attribute
  final bool removeGradientColor;
  final FloatingActionButtonLocation floatingActionButtonLocation;

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
    this.floatingActionButton, // New parameter
    this.floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked, // New parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              // The screen background is a gradient

              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.background.withAlpha(100),
                        Theme.of(context).colorScheme.background,
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
                        Theme.of(context).colorScheme.background,
                        Theme.of(context).colorScheme.background.withOpacity(0.9),
                        Theme.of(context).colorScheme.background.withOpacity(0.7),
                        Theme.of(context).colorScheme.background.withOpacity(0.4),
                        //Theme.of(context).colorScheme.background,
                        Theme.of(context).colorScheme.background.withOpacity(0.0001),
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
