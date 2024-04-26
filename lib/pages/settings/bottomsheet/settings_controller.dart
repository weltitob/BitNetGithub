import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxString currentTab = 'main'.obs;

  void switchTab(String newTab) {
    currentTab.value = newTab;
  }

  RxBool profileUpdated = false.obs;
  RxBool? crossSigningCached;

  Rx<Color> pickerColor = Color(0xff443a49).obs;
  final user = Auth().currentUser;

  void changeColor(Color color) {
    pickerColor.value = color;
  }


  ThemeMode currentTheme(BuildContext context) =>
      ThemeController.of(context).themeMode;

  Color? currentColor(BuildContext context) =>
      ThemeController.of(context).primaryColor;

  final List<Color?> customColors = [
    AppTheme.primaryColor,
    Colors.indigoAccent,
    AppTheme.colorBitcoin,
    Colors.pinkAccent,
    null,
  ];

  void switchTheme(ThemeMode? newTheme, BuildContext context) {
    Logs().w("switchTheme");
    if (newTheme == null) return;
    ThemeController.of(context).setThemeMode(newTheme);
  }


  

}