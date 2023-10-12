
import 'package:bitnet/components/buttons/roundediconbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

AppBar bitnetAppBar({
  required BuildContext context,
  Function()? onTap,
  bool hasBackButton = true,
  List<Widget>? actions, // Parameter for actions
  String? text,
  Widget? customTitle,
  Widget? customLeading,
}) {
  return AppBar(
    scrolledUnderElevation: 0,
    shadowColor: Colors.transparent,
    bottomOpacity: 0,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: Theme.of(context).textTheme.titleLarge,
    backgroundColor: Colors.transparent,
    title: LayoutBuilder(builder: (context, constraints) {
    double width = constraints.maxWidth;

    // Define breakpoint values for responsive layout.
    bool isSmallScreen = width < AppTheme.isSmallScreen; // Example breakpoint for small screens
    bool isMidScreen = width < AppTheme.isMidScreen;
    double horizontalMargin = isMidScreen ? AppTheme.cardPadding : AppTheme.columnWidth;

    return customTitle ?? (text != null ? Text(text) : Container());}), // Use customTitle if provided
    leading: hasBackButton ? customLeading ?? MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(
              left: AppTheme.elementSpacing * 1.5,
              right: AppTheme.elementSpacing * 0.5,
              top: AppTheme.elementSpacing,
              bottom: AppTheme.elementSpacing),
          child: RoundedIconButton(
            iconData: Icons.arrow_back,
            colorPrimary: AppTheme.colorPrimaryGradient,
            colorSecondary: AppTheme.colorBitcoin,
          ),
        ),
      ),
    ) : null,
    actions: actions,
  );
}
