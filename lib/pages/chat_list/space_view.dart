import 'package:bitnet/backbone/helper/matrix_helpers/matrix_sdk_extensions/matrix_locals.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/pages/chat_list/chat_list.dart';
import 'package:bitnet/components/items/chat_list_item.dart';
import 'package:bitnet/pages/chat_list/search_title.dart';
import 'package:bitnet/backbone/helper/localized_exception_extension.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';
import 'package:vrouter/vrouter.dart';
import 'package:bitnet/components/container/avatar.dart';
import '../../components/fields/searchfield/chat_list_searchbar.dart';

class SpaceView extends StatelessWidget {
  final ChatListController controller;
  final ScrollController scrollController;
  const SpaceView(
    this.controller, {
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = Matrix.of(context).client;
    final activeSpaceId = controller.activeSpaceId;
    final allSpaces = client.rooms.where((room) => room.isSpace);

    if (activeSpaceId == null) {
      final rootSpaces = allSpaces
          .where(
            (space) => !allSpaces.any(
              (parentSpace) => parentSpace.spaceChildren
                  .any((child) => child.roomId == space.id),
            ),
          )
          .toList();

      return CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final rootSpace = rootSpaces[i];
                final displayname = rootSpace.getLocalizedDisplayname(
                  MatrixLocals(L10n.of(context)!),
                );
                return Material(
                  color: Theme.of(context).colorScheme.background,
                  child: BitNetListTile(
                    leading: Avatar(
                      mxContent: rootSpace.avatar,
                      name: displayname,
                    ),
                    customTitle: Text(
                      displayname,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      L10n.of(context)!
                          .numChats(rootSpace.spaceChildren.length.toString()),
                    ),
                    onTap: () => controller.setActiveSpace(rootSpace.id),
                    onLongPress: () =>
                        controller.onSpaceChildContextMenu(null, rootSpace),
                    trailing: const Icon(Icons.chevron_right_outlined),
                  ),
                );
              },
              childCount: rootSpaces.length,
            ),
          ),
        ],
      );
    }

    return FutureBuilder<GetSpaceHierarchyResponse>(
      future: controller.getFuture(activeSpaceId),

      builder: (context, snapshot) {
        final response = snapshot.data;
        final error = snapshot.error;
        if (error != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(error.toLocalizedString(context)),
              ),
              IconButton(
                onPressed: controller.refresh,
                icon: const Icon(Icons.refresh_outlined),
              )
            ],
          );
        }
        if (response == null) {
          return CustomScrollView(
            slivers: [
              //ChatListSearchbar(controller: controller),
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ],
          );
        }
        final parentSpace = allSpaces.firstWhereOrNull(
          (space) =>
              space.spaceChildren.any((child) => child.roomId == activeSpaceId),
        );
        final spaceChildren = response.rooms;
        final canLoadMore = response.nextBatch != null;
        return VWidgetGuard(
          onSystemPop: (redirector) async {
            if (parentSpace != null) {
              controller.setActiveSpace(parentSpace.id);
              redirector.stopRedirection();
              return;
            }
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              //ChatListSearchbar(controller: controller),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    if (i == 0) {
                      return ListTile(
                        leading: BackButton(
                          onPressed: () =>
                              controller.setActiveSpace(parentSpace?.id),
                        ),
                        title: Text(
                          parentSpace == null
                              ? L10n.of(context)!.allSpaces
                              : parentSpace.getLocalizedDisplayname(
                                  MatrixLocals(L10n.of(context)!),
                                ),
                        ),
                        trailing: IconButton(
                          icon: snapshot.connectionState != ConnectionState.done
                              ? const CircularProgressIndicator.adaptive()
                              : const Icon(Icons.refresh_outlined),
                          onPressed:
                              snapshot.connectionState != ConnectionState.done
                                  ? null
                                  : controller.refresh,
                        ),
                      );
                    }
                    i--;
                    if (canLoadMore && i == spaceChildren.length) {
                      return ListTile(
                        title: Text(L10n.of(context)!.loadMore),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          controller.prevBatch = response.nextBatch;
                          controller.refresh();
                        },
                      );
                    }
                    final spaceChild = spaceChildren[i];
                    final room = client.getRoomById(spaceChild.roomId);
                    if (room != null && !room.isSpace) {
                      return ChatListItem(
                        room,
                        onLongPress: () =>
                            controller.onSpaceChildContextMenu(spaceChild, room),
                        activeChat: controller.activeChat == room.id,
                      );
                    }
                    final isSpace = spaceChild.roomType == 'm.space';
                    final topic = spaceChild.topic?.isEmpty ?? true
                        ? null
                        : spaceChild.topic;
                    if (spaceChild.roomId == activeSpaceId) {
                      return SearchTitle(
                        title: spaceChild.name ??
                            spaceChild.canonicalAlias ??
                            'Space',
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Avatar(
                            size: 24,
                            mxContent: spaceChild.avatarUrl,
                            name: spaceChild.name,
                            fontSize: 9,
                          ),
                        ),
                        color: Theme.of(context)
                            .colorScheme
                            .secondaryContainer
                            .withAlpha(128),
                        trailing: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(Icons.edit_outlined),
                        ),
                        onTap: () => controller.onJoinSpaceChild(spaceChild),
                      );
                    }
                    return ListTile(
                      leading: Avatar(
                        mxContent: spaceChild.avatarUrl,
                        name: spaceChild.name,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              spaceChild.name ??
                                  spaceChild.canonicalAlias ??
                                  L10n.of(context)!.chat,
                              maxLines: 1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (!isSpace) ...[
                            const Icon(
                              Icons.people_outline,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              spaceChild.numJoinedMembers.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ],
                      ),
                      onTap: () => controller.onJoinSpaceChild(spaceChild),
                      onLongPress: () =>
                          controller.onSpaceChildContextMenu(spaceChild, room),
                      subtitle: Text(
                        topic ??
                            (isSpace
                                ? L10n.of(context)!.enterSpace
                                : L10n.of(context)!.enterRoom),
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      trailing: isSpace
                          ? const Icon(Icons.chevron_right_outlined)
                          : null,
                    );
                  },
                  childCount: spaceChildren.length + 1 + (canLoadMore ? 1 : 0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum SpaceChildContextAction {
  join,
  leave,
  removeFromSpace,
}
