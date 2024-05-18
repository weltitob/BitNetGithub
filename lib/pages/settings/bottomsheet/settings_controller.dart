import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class SettingsController extends BaseController {
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

  void setChatColor(Color? color, BuildContext context) async {
    AppTheme.colorSchemeSeed = color;
    ThemeController.of(context).setPrimaryColor(color);
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
    LoggerService logger = Get.find();
    logger.i("switchTheme");
    if (newTheme == null) return;
    ThemeController.of(context).setThemeMode(newTheme);
  }

 
}
