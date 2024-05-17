import 'package:bitnet/backbone/helper/matrix_helpers/matrix_sdk_extensions/presence_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
//import 'package:bitnet/l10n/l10n.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/material.dart';

import 'package:bitnet/components/container/avatar.dart';
import 'user_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class UserBottomSheetView extends StatelessWidget {
  final UserBottomSheetController controller;

  const UserBottomSheetView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = controller.widget.user;
    final client = Matrix.of(context).client;
    final presence = client.presences[user.id];
    return SafeArea(
      child: Scaffold(
        appBar: bitnetAppBar(
            text: user.calcDisplayname(),
            buttonType: ButtonType.transparent,
            context: context,
            onTap: () {
              Navigator.of(context, rootNavigator: false).pop;
            },
            actions: [
              CloseButton(
                onPressed: Navigator.of(context, rootNavigator: false).pop,
              ),
            ]),
        body: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Avatar(
                    mxContent: user.avatarUrl,
                    name: user.calcDisplayname(),
                    size: Avatar.defaultSize * 2,
                    fontSize: 24,
                    profileId: user.id,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(right: 16.0),
                    title: Text(user.id),
                    subtitle: presence == null
                        ? null
                        : Text(presence.getLocalizedLastActiveAgo(context)),
                  ),
                ),
              ],
            ),
            if (controller.widget.onMention != null)
              ListTile(
                leading: const Icon(Icons.alternate_email_outlined),
                title: Text(L10n.of(context)!.mention),
                onTap: () =>
                    controller.participantAction(UserBottomSheetAction.mention),
              ),
            if (user.canChangePowerLevel)
              ListTile(
                title: Text(L10n.of(context)!.setPermissionsLevel),
                leading: const Icon(Icons.edit_attributes_outlined),
                onTap: () => controller
                    .participantAction(UserBottomSheetAction.permission),
              ),
            if (user.canKick)
              ListTile(
                title: Text(L10n.of(context)!.kickFromChat),
                leading: const Icon(Icons.exit_to_app_outlined),
                onTap: () =>
                    controller.participantAction(UserBottomSheetAction.kick),
              ),
            if (user.canBan && user.membership != Membership.ban)
              ListTile(
                title: Text(L10n.of(context)!.banFromChat),
                leading: const Icon(Icons.warning_sharp),
                onTap: () =>
                    controller.participantAction(UserBottomSheetAction.ban),
              )
            else if (user.canBan && user.membership == Membership.ban)
              ListTile(
                title: Text(L10n.of(context)!.unbanFromChat),
                leading: const Icon(Icons.warning_outlined),
                onTap: () =>
                    controller.participantAction(UserBottomSheetAction.unban),
              ),
            if (user.id != client.userID &&
                !client.ignoredUsers.contains(user.id))
              ListTile(
                textColor: Theme.of(context).colorScheme.onErrorContainer,
                iconColor: Theme.of(context).colorScheme.onErrorContainer,
                title: Text(L10n.of(context)!.ignore),
                leading: const Icon(Icons.block),
                onTap: () =>
                    controller.participantAction(UserBottomSheetAction.ignore),
              ),
            if (user.id != client.userID)
              ListTile(
                textColor: Theme.of(context).colorScheme.error,
                iconColor: Theme.of(context).colorScheme.error,
                title: Text(L10n.of(context)!.reportUser),
                leading: const Icon(Icons.shield_outlined),
                onTap: () =>
                    controller.participantAction(UserBottomSheetAction.report),
              ),
            if (user.id != client.userID)
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
                child: OutlinedButton.icon(
                  onPressed: () => controller
                      .participantAction(UserBottomSheetAction.message),
                  icon: const Icon(Icons.forum_outlined),
                  label: Text(L10n.of(context)!.sendAMessage),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
