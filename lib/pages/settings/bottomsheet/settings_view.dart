import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
        iconColor: Theme.of(context).colorScheme.onBackground,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 0.25),
          child: ListView(
            key: const Key('SettingsListViewContent'),
            children: [
              BitNetListTile(
                leading: Icon(Icons.color_lens),
                text: L10n.of(context)!.changeTheme,
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('style');
                },
              ),
              BitNetListTile(
                leading: Icon(Icons.security),
                text: "Own Security",
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('security');
                },
              ),
              BitNetListTile(
                leading: Icon(Icons.key_rounded),
                text: L10n.of(context)!.inviteContact,
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('invite');
                },
              ),
              // BitNetListTile(
              //   leading: Icon(Icons.notifications_outlined),
              //   text: L10n.of(context)!.notifications,
              //   trailing: Icon(
              //     Icons.arrow_forward_ios_rounded,
              //     size: AppTheme.iconSize * 0.75,
              //   ),
              //   onTap: () {
              //     controller.switchTab('notifications');
              //   },
              // ),
              // BitNetListTile(
              //   leading: Icon(Icons.forum_outlined),
              //   text: L10n.of(context)!.chat,
              //   trailing: Icon(
              //     Icons.arrow_forward_ios_rounded,
              //     size: AppTheme.iconSize * 0.75,
              //   ),
              //   onTap: () {
              //     controller.switchTab('chat');
              //   },
              // ),
              BitNetListTile(
                leading: Icon(Icons.currency_bitcoin),
                text: "Change language",
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('language');
                },
              ),
              BitNetListTile(
                leading: Icon(Icons.language),
                text: "Change Currency",
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () {
                  controller.switchTab('currency');
                },
              ),
                BitNetListTile(
              leading: Icon(Icons.info),
              text: "Agbs and Impressum",
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
              ),
              onTap: () {
                controller.switchTab('agbs');
              },
            ),
              BitNetListTile(
                leading: Icon(Icons.login_rounded),
                text: L10n.of(context)!.logout,
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: AppTheme.iconSize * 0.75,
                ),
                onTap: () async {
                  await Auth().signOut();
                  context.pop();
                  context.go('/authhome');
                },
              ),
              SizedBox(
                height: AppTheme.cardPadding * 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
