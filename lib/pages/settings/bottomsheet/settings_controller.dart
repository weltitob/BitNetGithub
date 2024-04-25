import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingsController extends GetxController {
  RxString currentTab = 'main'.obs;

  void switchTab(String newTab) {
    currentTab.value = newTab;
  }

  Future<Profile>? profileFuture;
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
    Logs().w("switchTheme");
    if (newTheme == null) return;
    ThemeController.of(context).setThemeMode(newTheme);
  }

  void updateProfile() {
    profileUpdated.value = true;
    profileFuture = null;
  }

  void setDisplaynameAction(BuildContext context) async {
    final profile = await profileFuture;
    final input = await showTextInputDialog(
      useRootNavigator: false,
      context: context,
      title: L10n.of(context)!.editDisplayname,
      okLabel: L10n.of(context)!.ok,
      cancelLabel: L10n.of(context)!.cancel,
      textFields: [
        DialogTextField(
          initialText: profile?.displayName ??
              Matrix.of(context).client.userID!.localpart,
        )
      ],
    );
    if (input == null) return;
    final matrix = Matrix.of(context);
    final success = await showFutureLoadingDialog(
      context: context,
      future: () =>
          matrix.client.setDisplayName(matrix.client.userID!, input.single),
    );
    if (success.error == null) {
      updateProfile();
    }
  }

  //MOVE THIS IN bitnet!!!
  void logoutAction(BuildContext context) async {
    //final noBackup = showChatBackupBanner == true;

    if (await showOkCancelAlertDialog(
          useRootNavigator: false,
          context: context,
          title: L10n.of(context)!.areYouSureYouWantToLogout,
          message: L10n.of(context)!.noBackupWarning,
          isDestructiveAction: true, //noBackup,
          okLabel: L10n.of(context)!.logout,
          cancelLabel: L10n.of(context)!.cancel,
        ) ==
        OkCancelResult.cancel) {
      return;
    }
    final matrix = Matrix.of(context);
    await showFutureLoadingDialog(
      context: context,
      future: () => matrix.client.logout(),
    );
  }

  void setAvatarAction(BuildContext context) async {
    final profile = await profileFuture;
    final actions = [
      if (PlatformInfos.isMobile)
        SheetAction(
          key: AvatarAction.camera,
          label: L10n.of(context)!.openCamera,
          isDefaultAction: true,
          icon: Icons.camera_alt_outlined,
        ),
      SheetAction(
        key: AvatarAction.file,
        label: L10n.of(context)!.openGallery,
        icon: Icons.photo_outlined,
      ),
      if (profile?.avatarUrl != null)
        SheetAction(
          key: AvatarAction.remove,
          label: L10n.of(context)!.removeYourAvatar,
          isDestructiveAction: true,
          icon: Icons.delete_outlined,
        ),
    ];
    final action = actions.length == 1
        ? actions.single.key
        : await showModalActionSheet<AvatarAction>(
            context: context,
            title: L10n.of(context)!.changeYourAvatar,
            actions: actions,
          );
    if (action == null) return;
    final matrix = Matrix.of(context);
    if (action == AvatarAction.remove) {
      final success = await showFutureLoadingDialog(
        context: context,
        future: () => matrix.client.setAvatar(null),
      );
      if (success.error == null) {
        updateProfile();
      }
      return;
    }
    MatrixFile file;
    if (PlatformInfos.isMobile) {
      final result = await ImagePicker().pickImage(
        source: action == AvatarAction.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        imageQuality: 50,
      );
      if (result == null) return;
      file = MatrixFile(
        bytes: await result.readAsBytes(),
        name: result.path,
      );
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      final pickedFile = result?.files.firstOrNull;
      if (pickedFile == null) return;
      file = MatrixFile(
        bytes: pickedFile.bytes!,
        name: pickedFile.name,
      );
    }
    final success = await showFutureLoadingDialog(
      context: context,
      future: () => matrix.client.setAvatar(file),
    );
    if (success.error == null) {
      updateProfile();
    }
  }
}
