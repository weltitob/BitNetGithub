import 'package:bitnet/backbone/helper/matrix_helpers/other/beautify_string_extension.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/responsiveness/max_width_body.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'settings_security.dart';

class SettingsSecurityView extends StatelessWidget {
  final SettingsSecurityController controller;
  const SettingsSecurityView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
          text: L10n.of(context)!.security,
          context: context,
          onTap: () {
            print("pressed");
            final controller = Get.find<SettingsController>();
            controller.switchTab('main');
          }),
      body: ListTileTheme(
        iconColor: Theme.of(context).colorScheme.onBackground,
        child: MaxWidthBody(
          withScrolling: true,
          child: Column(
            children: [ 
              ListTile(
                leading: const Icon(Icons.block_outlined),
                trailing: const Icon(Icons.chevron_right_outlined),
                title: Text(L10n.of(context)!.ignoredUsers),
                onTap: () => context.go('/rooms/settings/settings?tab=security/settings?tab=security&subtab=ignorelist'),
              ),
              ListTile(
                leading: const Icon(Icons.password_outlined),
                trailing: const Icon(Icons.chevron_right_outlined),
                title: Text(
                  L10n.of(context)!.changePassword,
                ),
                onTap: controller.changePasswordAccountAction,
              ),
              ListTile(
                leading: const Icon(Icons.mail_outlined),
                trailing: const Icon(Icons.chevron_right_outlined),
                title: Text(L10n.of(context)!.passwordRecovery),
                onTap: () => context.go('/rooms/settings/settings?tab=security/settings?tab=security&subtab=3pid'),
              ),
              if (Matrix.of(context).client.encryption != null) ...{
                const Divider(thickness: 1),
                if (PlatformInfos.isMobile)
                  ListTile(
                    leading: const Icon(Icons.lock_outlined),
                    trailing: const Icon(Icons.chevron_right_outlined),
                    title: Text(L10n.of(context)!.appLock),
                    onTap: controller.setAppLockAction,
                  ),
                ListTile(
                  title: Text(L10n.of(context)!.yourPublicKey),
                  subtitle: Text(
                    Matrix.of(context).client.fingerprintKey.beautified,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                  leading: const Icon(Icons.vpn_key_outlined),
                ),
              },
              const Divider(height: 1),
              // ListTile(
              //   leading: const Icon(Icons.tap_and_play),
              //   trailing: const Icon(Icons.chevron_right_outlined),
              //   title: Text(
              //     L10n.of(context)!.dehydrate,
              //     style: const TextStyle(color: Colors.red),
              //   ),
              //   onTap: controller.dehydrateAction,
              // ),
              ListTile(
                leading: const Icon(Icons.delete_outlined),
                trailing: const Icon(Icons.chevron_right_outlined),
                title: Text(
                  L10n.of(context)!.deleteAccount,
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: controller.deleteAccountAction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
