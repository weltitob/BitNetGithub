import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/items/settingslistitem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';


import 'settings.dart';

class SettingsView extends StatelessWidget {
  final SettingsController controller;

  const SettingsView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.settings,
        context: context,
        hasBackButton: false,
      ),
      body: ListTileTheme(
        iconColor: Theme.of(context).colorScheme.onBackground,
        child: ListView(
          key: const Key('SettingsListViewContent'),
          children: <Widget>[
            // Container(
            //   margin: EdgeInsets.only(
            //     top: AppTheme.elementSpacing,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(
            //         Icons.settings,
            //         color: Colors.white,
            //         size: AppTheme.iconSize / 1.25,
            //       ),
            //       SizedBox(
            //         width: AppTheme.elementSpacing / 2,
            //       ),
            //       Text(
            //         'Einstellungen',
            //         style: Theme.of(context).textTheme.titleSmall,
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: AppTheme.elementSpacing * 2,
            // ),
            // FutureBuilder<Profile>(
            //   future: controller.profileFuture,
            //   builder: (context, snapshot) {
            //     final profile = snapshot.data;
            //     final mxid = Matrix.of(context).client.userID ??
            //         L10n.of(context)!.user;
            //     final displayname =
            //         profile?.displayName ?? mxid.localpart ?? mxid;
            //     return Row(
            //       children: [
            //
            //         Expanded(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               TextButton.icon(
            //                 onPressed: controller.setDisplaynameAction,
            //                 icon: const Icon(
            //                   Icons.edit_outlined,
            //                   size: 16,
            //                 ),
            //                 style: TextButton.styleFrom(
            //                   foregroundColor:
            //                   Theme.of(context).colorScheme.onBackground,
            //                 ),
            //                 label: Text(
            //                   displayname,
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   //  style: const TextStyle(fontSize: 18),
            //                 ),
            //               ),
            //               TextButton.icon(
            //                 onPressed: () => FluffyShare.share(mxid, context),
            //                 icon: const Icon(
            //                   Icons.copy_outlined,
            //                   size: 14,
            //                 ),
            //                 style: TextButton.styleFrom(
            //                   foregroundColor:
            //                   Theme.of(context).colorScheme.secondary,
            //                 ),
            //                 label: Text(
            //                   mxid,
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   //    style: const TextStyle(fontSize: 12),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // ),
            // SettingsListItem(
            //   icon: Icons.devices_outlined,
            //   text: L10n.of(context)!.devices,
            //   hasNavigation: true,
            //   onTap: () => context.go('/settings/devices'),
            // ),
            //Privacy and Security
            // SettingsListItem(
            //   icon: Icons.help_outline_outlined,
            //   text: L10n.of(context)!.help,
            //   hasNavigation: true,
            //   onTap: () => launchUrlString(AppTheme.supportUrl),
            // ),
            // SettingsListItem(
            //   icon: Icons.shield_sharp,
            //   text: L10n.of(context)!.privacy,
            //   hasNavigation: true,
            //   onTap: () => launchUrlString(AppTheme.privacyUrl),
            // ),
            // SettingsListItem(
            //   icon: Icons.info_outline_rounded,
            //   text: L10n.of(context)!.about,
            //   hasNavigation: true,
            //   onTap: () => PlatformInfos.showDialog(context),
            // ),
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
            BitNetListTile(
              leading: Icon(Icons.notifications_outlined),
              text: L10n.of(context)!.notifications,
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
              ),
              onTap: () {
                controller.switchTab('notifications');
              },
            ),
            BitNetListTile(
              leading: Icon(Icons.forum_outlined),
              text: L10n.of(context)!.chat,
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
              ),
              onTap: () {
                controller.switchTab('chat');
              },
            ),
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
              leading: Icon(Icons.login_rounded),
              text: L10n.of(context)!.logout,
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: AppTheme.iconSize * 0.75,
              ),
              onTap: () async {
                //matrix logout
                //need to implement the chatbackup in our normal key first
                //controller.logoutAction();
                //my logout
                await Auth().signOut();
                //pop
                context.pop();
              },
            ),
            SizedBox(
              height: AppTheme.cardPadding * 4,
            )
          ],
        ),
      ),
    );
  }
}
