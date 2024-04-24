import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/settings/currency/change_currency.dart';
import 'package:bitnet/pages/settings/invite/invitation_page.dart';
import 'package:bitnet/pages/settings/language/change_language.dart';
import 'package:bitnet/pages/settings/security/security_page.dart';
import 'package:bitnet/pages/settings/settings_chat/settings_chat.dart';
import 'package:bitnet/pages/settings/settings_notifications/settings_notifications.dart';
import 'package:bitnet/pages/settings/settings_style/settings_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_view.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    final client = Matrix.of(context).client;
    controller.profileFuture ??= client.getProfileFromUserId(
      client.userID!,
      cache: !controller.profileUpdated.value,
      getFromRooms: !controller.profileUpdated.value,
    );
    return Obx(() => Column(
          children: [
            if (controller.currentTab.value == 'main')
              Expanded(child: SettingsView()),
            if (controller.currentTab.value == 'style')
              Expanded(child: SettingsStyle()),
            if (controller.currentTab.value == 'security')
              Expanded(child: SecuritySettingsPage()),
            if (controller.currentTab.value == 'notifications')
              Expanded(child: SettingsNotifications()),
            if (controller.currentTab.value == 'invite')
              Expanded(child: InvitationSettingsPage()),
            if (controller.currentTab.value == 'chat')
              Expanded(child: SettingsChat()),
            if (controller.currentTab.value == 'currency')
              Expanded(child: ChangeCurrency()),
            if (controller.currentTab.value == 'language')
              Expanded(child: ChangeLanguage()),
          ],
        ));
  }
}

enum AvatarAction { camera, file, remove }
