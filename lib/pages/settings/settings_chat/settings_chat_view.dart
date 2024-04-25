import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/voip/callkeep_manager.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/responsiveness/max_width_body.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/client_chooser_button.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/items/settingslistitem.dart';
import 'package:bitnet/pages/matrix/widgets/settings_switch_list_tile.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/settings/setting_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';

import 'settings_chat.dart';

class SettingsChatView extends StatelessWidget {
  final SettingsChatController controller;
  const SettingsChatView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showChatBackupBanner = controller.showChatBackupBanner;
    final wallpaper = Matrix.of(context).wallpaper;

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      //extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
          context: context,
          text: L10n.of(context)!.chat,
          buttonType: ButtonType.transparent,
          onTap: () {
            Logs().w("pressed settings_chat_view.dart");
            final controller = Get.find<SettingsController>();
            controller.switchTab('main');
          }),
      body: ListTileTheme(
        iconColor: Theme.of(context).textTheme.bodyLarge!.color,
        child: MaxWidthBody(
          withScrolling: true,
          child: Column(
            children: [
              SettingsListItem(
                icon: Icons.archive_outlined,
                text: L10n.of(context)!.archive,
                hasNavigation: true,
                onTap: () => SettingsAction.archive,
              ),
              if (showChatBackupBanner == null)
                ListTile(
                  leading: const Icon(Icons.backup_outlined),
                  title: Text(L10n.of(context)!.chatBackup),
                  trailing: const CircularProgressIndicator.adaptive(),
                )
              else
                SwitchListTile.adaptive(
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: controller.showChatBackupBanner == false,
                  secondary: const Icon(Icons.backup_outlined),
                  title: Text(L10n.of(context)!.chatBackup),
                  onChanged: controller.firstRunBootstrapAction,
                ),
              // ListTile(
              //   title: Text(L10n.of(context)!.emoteSettings),
              //   onTap: () => context.go('emotes'),
              //   trailing: const Icon(Icons.chevron_right_outlined),
              //   leading: const Icon(Icons.emoji_emotions_outlined),
              // ),
              const Divider(),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.renderRichContent,
                onChanged: (b) => AppTheme.renderHtml = b,
                storeKey: SettingKeys.renderHtml,
                defaultValue: AppTheme.renderHtml,
              ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.hideRedactedEvents,
                onChanged: (b) => AppTheme.hideRedactedEvents = b,
                storeKey: SettingKeys.hideRedactedEvents,
                defaultValue: AppTheme.hideRedactedEvents,
              ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.hideUnknownEvents,
                onChanged: (b) => AppTheme.hideUnknownEvents = b,
                storeKey: SettingKeys.hideUnknownEvents,
                defaultValue: AppTheme.hideUnknownEvents,
              ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.hideUnimportantStateEvents,
                onChanged: (b) => AppTheme.hideUnimportantStateEvents = b,
                storeKey: SettingKeys.hideUnimportantStateEvents,
                defaultValue: AppTheme.hideUnimportantStateEvents,
              ),
              if (PlatformInfos.isMobile)
                SettingsSwitchListTile.adaptive(
                  title: L10n.of(context)!.autoplayImages,
                  onChanged: (b) => AppTheme.autoplayImages = b,
                  storeKey: SettingKeys.autoplayImages,
                  defaultValue: AppTheme.autoplayImages,
                ),
              const Divider(),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.sendOnEnter,
                onChanged: (b) => AppTheme.sendOnEnter = b,
                storeKey: SettingKeys.sendOnEnter,
                defaultValue: AppTheme.sendOnEnter,
              ),
              if (Matrix.of(context).webrtcIsSupported)
                SettingsSwitchListTile.adaptive(
                  title: L10n.of(context)!.experimentalVideoCalls,
                  onChanged: (b) {
                    AppTheme.experimentalVoip = b;
                    Matrix.of(context).createVoipPlugin();
                    return;
                  },
                  storeKey: SettingKeys.experimentalVoip,
                  defaultValue: AppTheme.experimentalVoip,
                ),
              if (Matrix.of(context).webrtcIsSupported && !kIsWeb)
                ListTile(
                  title: Text(L10n.of(context)!.callingPermissions),
                  onTap: () =>
                      CallKeepManager().checkoutPhoneAccountSetting(context),
                  trailing: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.call),
                  ),
                ),
              SettingsSwitchListTile.adaptive(
                title: L10n.of(context)!.separateChatTypes,
                onChanged: (b) => AppTheme.separateChatTypes = b,
                storeKey: SettingKeys.separateChatTypes,
                defaultValue: AppTheme.separateChatTypes,
              ),
              SizedBox(
                height: AppTheme.cardPadding,
              ),
              ListTile(
                title: Text(
                  L10n.of(context)!.wallpaper,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (wallpaper != null)
                ListTile(
                  title: Image.file(
                    wallpaper,
                    height: 38,
                    fit: BoxFit.cover,
                  ),
                  trailing: const Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                  ),
                  onTap: controller.deleteWallpaperAction,
                ),
              Builder(
                builder: (context) {
                  return ListTile(
                    title: Text(L10n.of(context)!.changeWallpaper),
                    trailing: Icon(
                      Icons.photo_outlined,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    onTap: controller.setWallpaperAction,
                  );
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  L10n.of(context)!.messages,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Material(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 6,
                  shadowColor:
                      Theme.of(context).secondaryHeaderColor.withAlpha(100),
                  borderRadius:
                      BorderRadius.circular(AppTheme.borderRadiusSmall),
                  child: Padding(
                    padding: EdgeInsets.all(16 * AppTheme.bubbleSizeFactor),
                    child: Text(
                      'If you dont believe me or dont get it, I dont have time to try to convince you, sorry',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize:
                            AppTheme.messageFontSize * AppTheme.fontSizeFactor,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(L10n.of(context)!.fontSize),
                trailing: Text('× ${AppTheme.fontSizeFactor}'),
              ),
              Slider.adaptive(
                min: 0.5,
                max: 2.5,
                divisions: 20,
                value: AppTheme.fontSizeFactor,
                semanticFormatterCallback: (d) => d.toString(),
                onChanged: controller.changeFontSizeFactor,
              ),
              ListTile(
                title: Text(L10n.of(context)!.bubbleSize),
                trailing: Text('× ${AppTheme.bubbleSizeFactor}'),
              ),
              Slider.adaptive(
                min: 0.5,
                max: 1.5,
                divisions: 4,
                value: AppTheme.bubbleSizeFactor,
                semanticFormatterCallback: (d) => d.toString(),
                onChanged: controller.changeBubbleSizeFactor,
              ),
              SizedBox(
                height: AppTheme.cardPadding * 4,
              )
            ],
          ),
        ),
      ),
      context: context,
    );
  }
}
