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
  final Widget? bottomSheet;
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
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.resizeToAvoidBottomInset = true,
    this.bottomSheet, // New parameter with default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomSheet,
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
                    // Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin ? lighten(Colors.grey, 90) :
                    Theme.of(context).brightness == Brightness.light
                        ? lighten(
                            Theme.of(context).colorScheme.primaryContainer, 50)
                        : darken(
                            Theme.of(context).colorScheme.primaryContainer, 80),
                    // Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin ? lighten(Colors.grey, 80) :
                    Theme.of(context).brightness == Brightness.light
                        ? lighten(
                            Theme.of(context).colorScheme.tertiaryContainer, 50)
                        : darken(
                            Theme.of(context).colorScheme.tertiaryContainer,
                            80),
                  ],
                ),
              ),
              child: Padding(
                padding: extendBodyBehindBottomNav
                    ? const EdgeInsets.only(bottom: AppTheme.cardPadding * 3)
                    : EdgeInsets.zero,
                child: Container(
                  margin: margin,
                  child: body,
                ),
              ),
            ),
            extendBodyBehindAppBar
                ? removeGradientColor
                    ? Container()
                    : Container(
                        width: double.infinity,
                        height: AppTheme.cardPadding * 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                            colors:
                                Theme.of(context).brightness == Brightness.light
                                    ? [
                                        lighten(
                                            Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            50),
                                        lighten(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                50)
                                            .withOpacity(0.9),
                                        lighten(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                50)
                                            .withOpacity(0.7),
                                        lighten(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                50)
                                            .withOpacity(0.4),
                                        lighten(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                50)
                                            .withOpacity(0.0001),
                                      ]
                                    : [
                                        darken(
                                            Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            80),
                                        darken(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                80)
                                            .withOpacity(0.9),
                                        darken(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                80)
                                            .withOpacity(0.7),
                                        darken(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                80)
                                            .withOpacity(0.4),
                                        darken(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                80)
                                            .withOpacity(0.0001),
                                      ],
                          ),
                        ),
                      )
                : Container(),
          ],
        ),
        appBar: appBar,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.cardPadding),
          child: floatingActionButton,
        ), // Use the passed floating action button
        floatingActionButtonLocation:
            floatingActionButtonLocation, // Use the passed floating action button location
      ),
    );
  }
}

class bitnetScaffoldUnsafe extends StatelessWidget {
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
  final Widget? bottomSheet;
  final double? height;
  const bitnetScaffoldUnsafe({
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
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.resizeToAvoidBottomInset = true,
    this.bottomSheet,
    this.height, // New parameter with default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomSheet,
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: height ?? double.infinity,
            // The screen background is a gradient
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).brightness == Brightness.light
                      ? lighten(
                          Theme.of(context).colorScheme.primaryContainer, 50)
                      : darken(
                          Theme.of(context).colorScheme.primaryContainer, 80),
                  Theme.of(context).brightness == Brightness.light
                      ? lighten(
                          Theme.of(context).colorScheme.tertiaryContainer, 50)
                      : darken(
                          Theme.of(context).colorScheme.tertiaryContainer, 80),
                ],
              ),
            ),
            child: Padding(
              padding: extendBodyBehindBottomNav
                  ? const EdgeInsets.only(bottom: AppTheme.cardPadding * 3)
                  : EdgeInsets.zero,
              child: Container(
                margin: margin,
                child: body,
              ),
            ),
          ),
          extendBodyBehindAppBar
              ? removeGradientColor
                  ? Container()
                  : Container(
                      width: double.infinity,
                      height: AppTheme.cardPadding * 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                          colors:
                              Theme.of(context).brightness == Brightness.light
                                  ? [
                                      lighten(
                                          Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          50),
                                      lighten(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              50)
                                          .withOpacity(0.9),
                                      lighten(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              50)
                                          .withOpacity(0.7),
                                      lighten(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              50)
                                          .withOpacity(0.4),
                                      lighten(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              50)
                                          .withOpacity(0.0001),
                                    ]
                                  : [
                                      darken(
                                          Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                          80),
                                      darken(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              80)
                                          .withOpacity(0.9),
                                      darken(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              80)
                                          .withOpacity(0.7),
                                      darken(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              80)
                                          .withOpacity(0.4),
                                      darken(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              80)
                                          .withOpacity(0.0001),
                                    ],
                        ),
                      ),
                    )
              : Container(),
        ],
      ),
      appBar: appBar,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: AppTheme.cardPadding),
        child: floatingActionButton,
      ), // Use the passed floating action button
      floatingActionButtonLocation:
          floatingActionButtonLocation, // Use the passed floating action button location
    );
  }
}
