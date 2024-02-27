import 'package:bitnet/backbone/helper/matrix_helpers/matrix_sdk_extensions/matrix_locals.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/other/stream_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/chat_list/chat_list.dart';
import 'package:bitnet/components/items/chat_list_item.dart';
import 'package:bitnet/pages/chat_list/chat_spaces_list.dart';
import 'package:bitnet/pages/chat_list/search_title.dart';
import 'package:bitnet/pages/chat_list/space_view.dart';
import 'package:bitnet/pages/matrix/widgets/connection_status_header.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/adaptive_bottom_sheet.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/profile_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/public_room_bottom_sheet.dart';
import 'package:matrix/matrix.dart';
import 'package:vrouter/vrouter.dart';
import '../../components/fields/searchfield/chat_list_searchbar.dart';

class ChatListViewBody extends StatelessWidget {
  final ChatListController controller;

  const ChatListViewBody(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roomSearchResult = controller.roomSearchResult;
    final userSearchResult = controller.userSearchResult;
    final client = Matrix.of(context).client;

    return PageTransitionSwitcher(
      transitionBuilder: (
        Widget child,
        Animation<double> primaryAnimation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          child: child,
        );
      },
      child: StreamBuilder(
        key: ValueKey(
          client.userID.toString() +
              controller.activeFilter.toString() +
              controller.activeSpaceId.toString(),
        ),
        stream: client.onSync.stream
            .where((s) => s.hasRoomUpdate)
            .rateLimit(const Duration(seconds: 1)),
        builder: (context, _) {
          if (controller.activeFilter == ActiveFilter.spaces &&
              !controller.isSearchMode) {
            return SpaceView(
              controller,
              scrollController: controller.scrollController,
              key: Key(controller.activeSpaceId ?? 'Spaces'),
            );
          }
          if (controller.waitForFirstSync && client.prevBatch != null) {
            final rooms = controller.filteredRooms;

            return SafeArea(
              child: bitnetScaffold(
                context: context,
                body: CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    SliverPadding(
                        padding: EdgeInsets.only(top: AppTheme.cardPadding),
                        sliver: ChatListSearchbar(controller: controller)),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          if (controller.isSearchMode) ...[
                            SearchTitle(
                              title: L10n.of(context)!.publicRooms,
                              icon: const Icon(Icons.explore_outlined),
                            ),
                            AnimatedContainer(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(),
                              height: roomSearchResult == null ||
                                      roomSearchResult.chunk.isEmpty
                                  ? 0
                                  : 106,
                              duration: AppTheme.animationDuration,
                              curve: AppTheme.animationCurve,
                              child: roomSearchResult == null
                                  ? null
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: AppTheme.elementSpacing),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            roomSearchResult.chunk.length,
                                        itemBuilder: (context, i) =>
                                            _SearchItem(
                                          title:
                                              roomSearchResult.chunk[i].name ??
                                                  roomSearchResult
                                                      .chunk[i]
                                                      .canonicalAlias
                                                      ?.localpart ??
                                                  L10n.of(context)!.group,
                                          avatar: roomSearchResult
                                              .chunk[i].avatarUrl,
                                          onPressed: () =>
                                              BitNetBottomSheet(
                                            context: context,
                                            child:
                                                PublicRoomBottomSheet(
                                              roomAlias: roomSearchResult
                                                      .chunk[i]
                                                      .canonicalAlias ??
                                                  roomSearchResult
                                                      .chunk[i].roomId,
                                              outerContext: context,
                                              chunk: roomSearchResult.chunk[i],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            SearchTitle(
                              title: L10n.of(context)!.users,
                              icon: const Icon(Icons.group_outlined),
                            ),
                            AnimatedContainer(
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(),
                              height: userSearchResult == null ||
                                      userSearchResult.results.isEmpty
                                  ? 0
                                  : 106,
                              duration: AppTheme.animationDuration,
                              curve: AppTheme.animationCurve,
                              child: userSearchResult == null
                                  ? null
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: AppTheme.elementSpacing),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            userSearchResult.results.length,
                                        itemBuilder: (context, i) =>
                                            _SearchItem(
                                          title: userSearchResult
                                                  .results[i].displayName ??
                                              userSearchResult.results[i].userId
                                                  .localpart ??
                                              L10n.of(context)!.unknownDevice,
                                          avatar: userSearchResult
                                              .results[i].avatarUrl,
                                          onPressed: () =>
                                              BitNetBottomSheet(
                                            context: context,
                                            child:  ProfileBottomSheet(
                                              userId: userSearchResult
                                                  .results[i].userId,
                                              outerContext: context,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                          controller.isSearchMode
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                    top: AppTheme.elementSpacing,
                                    right: AppTheme.elementSpacing,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                AppTheme.cardPadding * 3,
                                        child: SpacesWidget(controller)
                                      ),
                                      RoundedButtonWidget(
                                        onTap: () {
                                          print(
                                              "Create new space screen forward");
                                          VRouter.of(context)
                                              .to('/rooms/create');
                                          //richtig forwarden
                                          //VRouter.of(context).to('/rooms/newspace');
                                        },
                                        iconData: Icons.add,
                                      ),
                                    ],
                                  ),
                                ),
                          const ConnectionStatusHeader(),
                          AnimatedContainer(
                            height: controller.isTorBrowser ? 64 : 0,
                            duration: AppTheme.animationDuration,
                            curve: AppTheme.animationCurve,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(),
                            child: Material(
                              color: Theme.of(context).colorScheme.surface,
                              child: ListTile(
                                leading: const Icon(Icons.vpn_key),
                                title: Text(L10n.of(context)!.dehydrateTor),
                                subtitle:
                                    Text(L10n.of(context)!.dehydrateTorLong),
                                trailing:
                                    const Icon(Icons.chevron_right_outlined),
                                onTap: controller.dehydrate,
                              ),
                            ),
                          ),
                          if (controller.isSearchMode)
                            SearchTitle(
                              title: L10n.of(context)!.chats,
                              icon: const Icon(Icons.forum_outlined),
                            ),
                          if (rooms.isEmpty && !controller.isSearchMode) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.all(AppTheme.cardPadding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/start_chat.png',
                                    height: AppTheme.cardPadding * 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int i) {
                          if (!rooms[i]
                              .getLocalizedDisplayname(
                                MatrixLocals(L10n.of(context)!),
                              )
                              .toLowerCase()
                              .contains(
                                controller.searchController.text.toLowerCase(),
                              )) {
                            return const SizedBox.shrink();
                          }

                          return ChatListItem(
                            rooms[i],
                            key: Key('chat_list_item_${rooms[i].id}'),
                            selected: controller.selectedRoomIds
                                .contains(rooms[i].id),
                            onTap: controller.selectMode == SelectMode.select
                                ? () => controller.toggleSelection(rooms[i].id)
                                : null,
                            onLongPress: () =>
                                controller.toggleSelection(rooms[i].id),
                            activeChat: controller.activeChat == rooms[i].id,
                          );
                        },
                        childCount: rooms.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          const dummyChatCount = 5;

          final titleColor =
              Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(100);
          final subtitleColor =
              Theme.of(context).textTheme.bodyLarge!.color!.withAlpha(50);

          return Padding(
            padding: const EdgeInsets.only(left: AppTheme.elementSpacing),
            child: ListView.builder(
              key: const Key('dummychats'),
              itemCount: dummyChatCount,
              itemBuilder: (context, i) => Opacity(
                opacity: (dummyChatCount - i) / dummyChatCount,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: titleColor,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 14,
                          decoration: BoxDecoration(
                            color: titleColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const SizedBox(width: 36),
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: subtitleColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: subtitleColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Container(
                    decoration: BoxDecoration(
                      color: subtitleColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    height: 12,
                    margin: const EdgeInsets.only(right: 22),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SearchItem extends StatelessWidget {
  final String title;
  final Uri? avatar;
  final void Function() onPressed;

  const _SearchItem({
    required this.title,
    this.avatar,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: AppTheme.cardPadding * 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppTheme.elementSpacing),
              Avatar(
                mxContent: avatar,
                name: title,
                profileId: title,
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.elementSpacing / 2),
                child: Text(title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
        ),
      );
}
