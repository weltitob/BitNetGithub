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
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
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
                leading: RoundedButtonWidget(
                  iconData: Icons.color_lens,
                  onTap: () {
                    controller.switchTab('style');
                  },
                  size: AppTheme.iconSize * 1.5,
                  buttonType: ButtonType.transparent,
                ),
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
                leading: RoundedButtonWidget(
                  iconData: Icons.security,
                  onTap: () {
                    controller.switchTab('security');
                  },
                  size: AppTheme.iconSize * 1.5,
                  buttonType: ButtonType.transparent,
                ),
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
                leading: RoundedButtonWidget(
                  iconData: Icons.key_rounded,
                  onTap: () {
                    controller.switchTab('invite');
                  },
                  size: AppTheme.iconSize * 1.5,
                  buttonType: ButtonType.transparent,
                ),
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
                leading: RoundedButtonWidget(
                  iconData: Icons.language,

                  onTap: () {
                    controller.switchTab('language');
                  },
                  size: AppTheme.iconSize * 1.5,
                  buttonType: ButtonType.transparent,
                ),
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
                leading: RoundedButtonWidget(
                  iconData: Icons.currency_bitcoin,
                  onTap: () {
                    controller.switchTab('currency');
                  },
                  size: AppTheme.iconSize * 1.5,
                  buttonType: ButtonType.transparent,
                ),
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
                leading: RoundedButtonWidget(
                  iconData: Icons.info,
                  onTap: () {
                    controller.switchTab('agbs');
                  },
                  size: AppTheme.iconSize * 1.5,
                  buttonType: ButtonType.transparent,
                ),
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
                leading: RoundedButtonWidget(
                  iconData: Icons.login_rounded,
                  onTap: () async {
                    ThemeController.of(context)
                        .setPrimaryColor(Colors.white, false);

                    // Clear shared preferences if used
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    await prefs.remove('theme_mode');
                    await prefs.remove('primary_color');
                    final profile_controller = Get.put(ProfileController());
                    final litdController = Get.find<LitdController>();
                    String username =
                        '${profile_controller.userData.value.username}';

                    Get.delete<ProfileController>(force: true);
                    Get.delete<WalletsController>(force: true);
                    Get.delete<ProtocolController>(force: true);

                    await Auth().signOut();

                    context.pop();
                    Get.delete<SettingsController>(force: true);
                    context.go('/authhome');
                    Get.put(ProtocolController(logIn: false));
                  },
                  size: AppTheme.iconSize * 1.5,
                  buttonType: ButtonType.transparent,
                ),
                text: L10n.of(context)!.logout,
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
              ),
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
