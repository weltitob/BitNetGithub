import 'dart:async';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/pages/settings/invite/invitation_page.dart';
import 'package:bitnet/pages/settings/security/security_page.dart';
import 'package:bitnet/pages/settings/settings_chat/settings_chat.dart';
import 'package:bitnet/pages/settings/settings_notifications/settings_notifications.dart';
import 'package:bitnet/pages/settings/settings_style/settings_style.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';
import 'settings_view.dart';

class SettingsProvider with ChangeNotifier {
  String _currentTab = 'main';

  String get currentTab => _currentTab;

  void switchTab(String newTab) {
    _currentTab = newTab;
    notifyListeners();
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  SettingsController createState() => SettingsController();
}

class SettingsController extends State<Settings> {
  Future<Profile>? profileFuture;
  bool profileUpdated = false;
  bool? crossSigningCached;

  @override
  void initState() {
    super.initState();
  }

  void updateProfile() => setState(() {
        profileUpdated = true;
        profileFuture = null;
      });

  void setDisplaynameAction() async {
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
  void logoutAction() async {
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

  void setAvatarAction() async {
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

  void switchTab(String newTab) {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    settingsProvider.switchTab(newTab);
    // VRouter.of(context).to(
    //   VRouter.of(context).url,
    //   isReplacement: true,
    //   queryParameters: {'tab': newTab},
    // );
  }

  @override
  Widget build(BuildContext context) {
    final client = Matrix.of(context).client;
    profileFuture ??= client.getProfileFromUserId(
      client.userID!,
      cache: !profileUpdated,
      getFromRooms: !profileUpdated,
    );

    final currentTab = Provider.of<SettingsProvider>(context).currentTab;

    switch (currentTab) {
      case 'main':
        return SettingsView(this);
      case 'style':
        return SettingsStyle();
      case 'security':
        return SecuritySettingsPage();
      case 'notifications':
        return SettingsNotifications();
      case 'invite':
        return InvitationSettingsPage();
      case 'chat':
        return SettingsChat();
      default:
        return SettingsView(this);
    }
  }
}

enum AvatarAction { camera, file, remove }
