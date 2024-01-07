import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/items/settingslistitem.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:vrouter/vrouter.dart';

import 'settings.dart';

class SettingsView extends StatelessWidget {
  final SettingsController controller;

  const SettingsView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      body: ListTileTheme(
        iconColor: Theme.of(context).colorScheme.onBackground,
        child: ListView(
          key: const Key('SettingsListViewContent'),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: AppTheme.elementSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: AppTheme.iconSize / 1.25,
                  ),
                  SizedBox(
                    width: AppTheme.elementSpacing / 2,
                  ),
                  Text(
                    'Einstellungen',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppTheme.elementSpacing * 2,
            ),
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
            //   onTap: () => VRouter.of(context).to('/settings/devices'),
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
            SettingsListItem(
              icon: Icons.color_lens,
              text: L10n.of(context)!.changeTheme,
              hasNavigation: true,
              onTap: () {
                controller.switchTab('style');
              },
            ),
            SettingsListItem(
              icon: Icons.security,
              text: "Own Security",
              hasNavigation: true,
              onTap: () {
                controller.switchTab('security');
              },
            ),
            SettingsListItem(
              icon: Icons.key_rounded,
              text: L10n.of(context)!.inviteContact,
              hasNavigation: true,
              onTap: () {
                controller.switchTab('invite');
              },
            ),
            SettingsListItem(
              icon: Icons.notifications_outlined,
              text: L10n.of(context)!.notifications,
              hasNavigation: true,
              onTap: () {
                controller.switchTab('notifications');
              },
            ),
            SettingsListItem(
              icon: Icons.forum_outlined,
              text: L10n.of(context)!.chat,
              hasNavigation: true,
              onTap: () {
                controller.switchTab('chat');
              },
            ),
            SettingsListItem(
              icon: Icons.login_rounded,
              text: L10n.of(context)!.logout,
              hasNavigation: false,
              onTap: () async {
                //matrix logout
                //need to implement the chatbackup in our normal key first
                //controller.logoutAction();
                //my logout
                await Auth().signOut();
                //pop
                VRouter.of(context).pop();
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
