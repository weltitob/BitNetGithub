import 'package:bitnet/components/buttons/roundediconbutton.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/backgroundgradient.dart';

AppBar bitnetAppBar({
  required BuildContext context,
  Function()? onTap,
  List<Widget>? actions, // Parameter for actions
  String? text,
  Widget? customTitle,
  Widget? customLeading,
}) {
  return AppBar(
    bottomOpacity: 0,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: Theme.of(context).textTheme.titleLarge,
    backgroundColor: Colors.transparent,
    title: customTitle ?? (text != null ? Text(text) : Container()), // Use customTitle if provided
    leading: customLeading ?? GestureDetector(
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
    actions: actions,
  );
}
