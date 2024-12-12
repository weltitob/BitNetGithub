import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/protocol_controller.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.settings,
        context: context,
        hasBackButton: false,
      ),
      body: ListTileTheme(
        iconColor: Theme.of(context).colorScheme.onSurface,
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppTheme.elementSpacing * 0.25),
          child: ListView(
            key: const Key('SettingsListViewContent'),
            children: [
              BitNetListTile(
                leading: const Icon(Icons.color_lens),
                text: L10n.of(context)!.changeTheme,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('style');
                },
              ),
              BitNetListTile(
                leading: const Icon(Icons.security),
                text: L10n.of(context)!.ownSecurity,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('security');
                },
              ),
              BitNetListTile(
                leading: const Icon(Icons.key_rounded),
                text: L10n.of(context)!.inviteContact,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('invite');
                },
              ),
              BitNetListTile(
                leading: const Icon(Icons.currency_bitcoin),
                text: L10n.of(context)!.changeLanguage,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('language');
                },
              ),
              BitNetListTile(
                leading: const Icon(Icons.language),
                text: L10n.of(context)!.changeCurrency,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('currency');
                },
              ),
              BitNetListTile(
                leading: const Icon(Icons.info),
                text: L10n.of(context)!.agbsImpress,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('agbs');
                },
              ),
              BitNetListTile(
                leading: const Icon(Icons.login_rounded),
                text: L10n.of(context)!.logout,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () async {
                  await settingsCollection.doc(Auth().currentUser!.uid).update({
                    'theme_mode': 'system',
                    'primary_color': Colors.white.value,
                  });
                  ThemeController.of(context).setPrimaryColor(Colors.white);

                  // Clear shared preferences if used
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  await prefs.remove('theme_mode');
                  await prefs.remove('primary_color');
                  final profile_controller = Get.put(ProfileController());
                  final litdController = Get.find<LitdController>();
                  String username =
                      '${profile_controller.userData.value.username}';

                  // dynamic stopecs_response =
                  //     await litdController.logoutAndStopEcs('${username}_uid');
                  // print('Stop ecs response: $stopecs_response');

                  Get.delete<ProfileController>();
                  Get.delete<WalletsController>();
                  Get.delete<SettingsController>();
                  Get.delete<ProtocolController>();

                  await Auth().signOut();

                  context.pop();
                  context.go('/authhome');
                  Get.put(ProtocolController(logIn: false));
                },
              ),
              const SizedBox(
                height: AppTheme.cardPadding * 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
