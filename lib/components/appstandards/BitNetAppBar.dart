import 'package:flutter/material.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/backgrounds/backgroundgradient.dart';

AppBar BitNetAppBar({
  required String text,
  required BuildContext context,
  required Function() onTap,
  List<Widget>? actions, // New parameter for actions
}) {
  return AppBar(
    bottomOpacity: 0,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: Theme.of(context).textTheme.titleLarge,
    backgroundColor: Colors.transparent,
    title: (text != null) ? Container(child: Text(text)) : Container(),
    leading: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
            left: AppTheme.elementSpacing * 1.5,
            right: AppTheme.elementSpacing * 0.5,
            top: AppTheme.elementSpacing,
            bottom: AppTheme.elementSpacing),
        child: BackgroundGradient(
          colorprimary: AppTheme.colorPrimaryGradient,
          colorsecondary: AppTheme.colorBitcoin,
          child: Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_rounded,
                color: AppTheme.white90,
                size: AppTheme.cardPadding * 1.25,
              )),
        ),
      ),
    ),
    actions: actions, // Add the actions to the AppBar
  );
}
