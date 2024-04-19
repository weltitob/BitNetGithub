import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/settings/bootstrap.dart/bootstrap_dialog.dart';
import 'package:bitnet/pages/settings/setting_keys.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'settings_chat_view.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SettingsChat extends StatefulWidget {
  const SettingsChat({Key? key}) : super(key: key);

  @override
  SettingsChatController createState() => SettingsChatController();
}

class SettingsChatController extends State<SettingsChat> {
  bool? showChatBackupBanner;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => checkBootstrap());

    super.initState();
  }

  void checkBootstrap() async {
    final client = Matrix.of(context).client;
    if (!client.encryptionEnabled) return;
    await client.accountDataLoading;
    await client.userDeviceKeysLoading;
    if (client.prevBatch == null) {
      await client.onSync.stream.first;
    }
    final crossSigning =
        await client.encryption?.crossSigning.isCached() ?? false;
    final needsBootstrap =
        await client.encryption?.keyManager.isCached() == false ||
            client.encryption?.crossSigning.enabled == false ||
            crossSigning == false;
    final isUnknownSession = client.isUnknownSession;
    setState(() {
      showChatBackupBanner = needsBootstrap || isUnknownSession;
    });
  }

  void firstRunBootstrapAction([_]) async {
    if (showChatBackupBanner != true) {
      showOkAlertDialog(
        context: context,
        title: L10n.of(context)!.chatBackup,
        message: L10n.of(context)!.onlineKeyBackupEnabled,
        okLabel: L10n.of(context)!.close,
      );
      return;
    }
    await BootstrapDialog(
      client: Matrix.of(context).client,
    ).show(context);
    checkBootstrap();
  }

  void changeFontSizeFactor(double d) {
    setState(() => AppTheme.fontSizeFactor = d);
    Matrix.of(context).store.setItem(
      SettingKeys.fontSizeFactor,
      AppTheme.fontSizeFactor.toString(),
    );
  }

  void changeBubbleSizeFactor(double d) {
    setState(() => AppTheme.bubbleSizeFactor = d);
    Matrix.of(context).store.setItem(
      SettingKeys.bubbleSizeFactor,
      AppTheme.bubbleSizeFactor.toString(),
    );
  }

  void setWallpaperAction() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: false,
    );
    final pickedFile = picked?.files.firstOrNull;

    if (pickedFile == null) return;
    await Matrix.of(context)
        .store
        .setItem(SettingKeys.wallpaper, pickedFile.path);
    setState(() {});
  }

  void deleteWallpaperAction() async {
    Matrix.of(context).wallpaper = null;
    await Matrix.of(context).store.deleteItem(SettingKeys.wallpaper);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => SettingsChatView(this);
}
