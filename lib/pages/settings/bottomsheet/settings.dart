import 'package:bitnet/pages/secondpages/agbs_and_impressum.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/settings/currency/change_currency.dart';
import 'package:bitnet/pages/settings/invite/invitation_page.dart';
import 'package:bitnet/pages/settings/language/change_language.dart';
import 'package:bitnet/pages/settings/security/security_page.dart';
import 'package:bitnet/pages/settings/settings_style/settings_style_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_view.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Obx(
      ()=> PopScope(
        canPop: controller.currentTab.value == 'main',
        onPopInvoked: (val) {
          if(controller.currentTab.value != 'main') {
            controller.switchTab('main');
            
          } else {
      
          }
        },
        child: Obx(
          () => Column(
            children: [
              if (controller.currentTab.value == 'main')
                Expanded(
                  child: SettingsView(),
                ),
              if (controller.currentTab.value == 'style')
                Expanded(
                  child: SettingsStyleView(),
                ),
              if (controller.currentTab.value == 'security')
                Expanded(
                  child: SecuritySettingsPage(),
                ),
              if (controller.currentTab.value == 'invite')
                Expanded(
                  child: InvitationSettingsPage(),
                ),
              if (controller.currentTab.value == 'currency')
                Expanded(
                  child: ChangeCurrency(),
                ),
              if (controller.currentTab.value == 'language')
                Expanded(
                  child: ChangeLanguage(),
                ),
              if (controller.currentTab.value == "agbs")
                Expanded(
                  child: AgbsAndImpressumScreen(
                    onBackButton: () {
                      controller.switchTab("main");
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

enum AvatarAction { camera, file, remove }
