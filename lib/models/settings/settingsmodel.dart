import 'package:flutter/material.dart';

class SettingsPageModel {
  final String title;
  final IconData iconData;
  final bool goBack;
  final Widget widget;
  final List<Widget> actions;
  final VoidCallback? backHandler;

  SettingsPageModel({
    this.actions = const [],
    this.backHandler,
    required this.title,
    required this.iconData,
    required this.goBack,
    required this.widget,
  });
}
