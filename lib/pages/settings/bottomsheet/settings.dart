import 'package:bitnet/pages/secondpages/agbs_and_impressum.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/settings/currency/change_currency.dart';
import 'package:bitnet/pages/settings/developer_options/developer_options_page.dart';
import 'package:bitnet/pages/settings/emergency_recovery/emergency_recovery_view.dart';
import 'package:bitnet/pages/settings/invite/invitation_page.dart';
import 'package:bitnet/pages/settings/language/change_language.dart';
import 'package:bitnet/pages/settings/security/security_page.dart';
import 'package:bitnet/pages/settings/settings_style/settings_style_view.dart';
import 'package:bitnet/pages/settings/timezone/change_timezone.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_view.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SettingsController>()) {
      return Container();
    }
    return Obx(
      () => PopScope(
        canPop: controller.currentTab.value == 'main',
        onPopInvoked: (val) {
          if (controller.currentTab.value != 'main') {
            controller.switchTab('main');
          } else {}
        },
        child: Obx(
          () => Column(
            children: [
              if (controller.currentTab.value == 'main')
                const Expanded(
                  child: SettingsView(),
                ),
              if (controller.currentTab.value == 'style')
                const Expanded(
                  child: SettingsStyleView(),
                ),
              if (controller.currentTab.value == 'security')
                const Expanded(
                  child: SecuritySettingsPage(),
                ),
              if (controller.currentTab.value == "emergency_recovery")
                const Expanded(child: EmergencyRecoveryView()),
              if (controller.currentTab.value == 'invite')
                const Expanded(
                  child: InvitationSettingsPage(),
                ),
              if (controller.currentTab.value == 'currency')
                const Expanded(
                  child: ChangeCurrency(),
                ),
              if (controller.currentTab.value == 'language')
                const Expanded(
                  child: ChangeLanguage(),
                ),
              if (controller.currentTab.value == 'timezone')
                const Expanded(
                  child: ChangeTimeZone(),
                ),
              if (controller.currentTab.value == "agbs")
                Expanded(
                  child: AgbsAndImpressumScreen(
                    onBackButton: () {
                      controller.switchTab("main");
                    },
                  ),
                ),
              if (controller.currentTab.value == "developer_options")
                Expanded(child: DeveloperOptionsPage())
            ],
          ),
        ),
      ),
    );
  }
}

enum AvatarAction { camera, file, remove }
