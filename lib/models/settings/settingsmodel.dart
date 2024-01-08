import 'package:flutter/material.dart';

class SettingsPageModel {
  final String title;
  final IconData iconData;
  final bool goBack;
  final Widget widget;

  SettingsPageModel({
    required this.title,
    required this.iconData,
    required this.goBack,
    required this.widget,
  });
}