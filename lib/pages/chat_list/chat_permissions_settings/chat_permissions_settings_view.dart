import 'package:bitnet/backbone/helper/responsiveness/max_width_body.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/pages/chat_list/chat_permissions_settings/chat_permissions_settings.dart';
import 'package:bitnet/pages/chat_list/chat_permissions_settings/permission_list_tile.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';


import 'package:bitnet/pages/routetrees/matrix.dart';

class ChatPermissionsSettingsView extends StatelessWidget {
  final GoRouterState routerState;
  final ChatPermissionsSettingsController controller;

  const ChatPermissionsSettingsView(this.controller, {Key? key, required this.routerState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        onTap: () => context.goNamed('rooms',pathParameters: {'roomid': controller.roomId!}),
        context: context,
        customIcon: (routerState.path != null && routerState.path!.startsWith('/spaces/'))
            ? null
            : Icons.close_outlined,
        text: L10n.of(context)!.editChatPermissions,
      ),
      body: MaxWidthBody(
        withScrolling: true,
        child: Padding(
          padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
          child: StreamBuilder(
            stream: controller.onChanged,
            builder: (context, _) {
              final roomId = controller.roomId;
              final room = roomId == null
                  ? null
                  : Matrix.of(context).client.getRoomById(roomId);
              if (room == null) {
                return Center(child: Text(L10n.of(context)!.noRoomsFound));
              }
              final powerLevelsContent = Map<String, dynamic>.from(
                room.getState(EventTypes.RoomPowerLevels)!.content,
              );
              final powerLevels = Map<String, dynamic>.from(powerLevelsContent)
                ..removeWhere((k, v) => v is! int);
              final eventsPowerLevels =
                  Map<String, dynamic>.from(powerLevelsContent['events'] ?? {})
                    ..removeWhere((k, v) => v is! int);
              return Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var entry in powerLevels.entries)
                        PermissionsListTile(
                          permissionKey: entry.key,
                          permission: entry.value,
                          onTap: () => controller.editPowerLevel(
                            context,
                            entry.key,
                            entry.value,
                          ),
                        ),
                      BitNetListTile(
                        text: L10n.of(context)!.notifications,
                      ),
                      Builder(
                        builder: (context) {
                          const key = 'rooms';
                          final int value = powerLevelsContent
                                  .containsKey('notifications')
                              ? powerLevelsContent['notifications']['rooms'] ?? 0
                              : 0;
                          return PermissionsListTile(
                            permissionKey: key,
                            permission: value,
                            category: 'notifications',
                            onTap: () => controller.editPowerLevel(
                              context,
                              key,
                              value,
                              category: 'notifications',
                            ),
                          );
                        },
                      ),
                      BitNetListTile(
                        text: L10n.of(context)!.configureChat,
                      ),
                      for (var entry in eventsPowerLevels.entries)
                        PermissionsListTile(
                          permissionKey: entry.key,
                          category: 'events',
                          permission: entry.value,
                          onTap: () => controller.editPowerLevel(
                            context,
                            entry.key,
                            entry.value,
                            category: 'events',
                          ),
                        ),
                      if (room.canSendEvent(EventTypes.RoomTombstone)) ...{
                        FutureBuilder<Capabilities>(
                          future: room.client.getCapabilities(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 2,
                                ),
                              );
                            }
                            final String roomVersion =
                                '1';

                            return ListTile(
                              title: Text(
                                '${L10n.of(context)!.roomVersion}: $roomVersion',
                              ),
                              onTap: () =>
                                  controller.updateRoomAction(snapshot.data!),
                            );
                          },
                        ),
                      },
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
