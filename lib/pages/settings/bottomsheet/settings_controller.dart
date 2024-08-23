import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingsController extends BaseController {
  RxString currentTab = 'main'.obs;
  //dummy val for state triggers.
  Rx<ThemeMode> selectedTheme = ThemeMode.system.obs;
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

  void setChatColor(Color? color, BuildContext context) async {
    AppTheme.colorSchemeSeed = color;
    ThemeController.of(context).setPrimaryColor(color);
  }

  ThemeMode currentTheme(BuildContext context) =>
      ThemeController.of(context).themeMode;

  Color? currentColor(BuildContext context) =>
      ThemeController.of(context).primaryColor;

  final List<Color?> customColors = [
    Colors.white,
    Colors.deepPurple,
    Colors.indigoAccent,
    null,
  ];

  void switchTheme(ThemeMode? newTheme, BuildContext context) {
    LoggerService logger = Get.find();
    logger.i("switchTheme: $newTheme");
    if (newTheme == null) return;
    //Get.changeThemeMode(newTheme); // Update the theme mode using GetX
    ThemeController.of(context).setThemeMode(newTheme); // Ensure ThemeController updates the theme
  }

 
}
