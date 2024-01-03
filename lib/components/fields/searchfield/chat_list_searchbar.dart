import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/chat_list/chat_list.dart';
import 'package:bitnet/components/buttons/client_chooser_button.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

//searchlistheader
class ChatListSearchbar extends StatelessWidget implements PreferredSizeWidget {
  final ChatListController controller;

  const ChatListSearchbar({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectMode = controller.selectMode;

    return SliverAppBar(
      floating: true,
      pinned: AppTheme.isColumnMode(context) || selectMode != SelectMode.normal,
      scrolledUnderElevation: selectMode == SelectMode.normal ? 0 : null,
      backgroundColor:
          selectMode == SelectMode.normal ? Colors.transparent : Theme.of(context).colorScheme.background,
      automaticallyImplyLeading: false,
      leading: selectMode == SelectMode.normal
          ? null
          : IconButton(
              tooltip: L10n.of(context)!.cancel,
              icon: const Icon(Icons.close_outlined),
              onPressed: controller.cancelAction,
              color: Theme.of(context).colorScheme.onBackground,
            ),
      title: selectMode == SelectMode.share
          ? Text(
              L10n.of(context)!.share,
              key: const ValueKey(SelectMode.share),
            )
          : selectMode == SelectMode.select
              ? Container(
                child: Text(
                    controller.selectedRoomIds.length.toString(),
                    key: const ValueKey(SelectMode.select),
                  ),
              )
              : GlassContainer(
                  width: MediaQuery.of(context).size.width,
                  height: AppTheme.cardPadding * 2,
                  borderThickness: 1.5, // remove border if not active
                  blur: 50,
                  opacity: 0.1,
                  borderRadius:
                      BorderRadius.circular(AppTheme.cardPadding * 2 / 2.5),
                  child: TextField(
                    controller: controller.searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: controller.onSearchEnter,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      hintText: L10n.of(context)!.search,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: controller.isSearchMode
                          ? IconButton(
                              tooltip: L10n.of(context)!.cancel,
                              icon: const Icon(Icons.close_outlined),
                              onPressed: controller.cancelSearch,
                              color: Theme.of(context).colorScheme.onBackground,
                            )
                          : Icon(
                              Icons.search_outlined,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      suffixIcon: controller.isSearchMode
                          ? controller.isSearching
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 12,
                                  ),
                                  child: SizedBox.square(
                                    dimension: 20,
                                    child: dotProgress(context, size: AppTheme.elementSpacing)
                                  ),
                                )
                              : TextButton(
                                  onPressed: controller.setServer,
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 12),
                                  ),
                                  child: Text(
                                    controller.searchServer ??
                                        Matrix.of(context)
                                            .client
                                            .homeserver!
                                            .host,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    )
                                  ),
                                )
                          : SizedBox(
                              width: 0,
                              child: Container(),
                              //ClientChooserButton(controller),
                            ),
                    ),
                  ),
                ),
      actions: selectMode == SelectMode.share
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding,
                  vertical: AppTheme.elementSpacing / 2,
                ),
                child: ClientChooserButton(controller),
              ),
            ]
          : selectMode == SelectMode.select
              ? [
                  if (controller.spaces.isNotEmpty)
                    IconButton(
                      tooltip: L10n.of(context)!.addToSpace,
                      icon: const Icon(Icons.workspaces_outlined),
                      onPressed: controller.addToSpace,
                    ),
                  IconButton(
                    tooltip: L10n.of(context)!.toggleUnread,
                    icon: Icon(
                      controller.anySelectedRoomNotMarkedUnread
                          ? Icons.mark_chat_read_outlined
                          : Icons.mark_chat_unread_outlined,
                    ),
                    onPressed: controller.toggleUnread,
                  ),
                  IconButton(
                    tooltip: L10n.of(context)!.toggleFavorite,
                    icon: Icon(
                      controller.anySelectedRoomNotFavorite
                          ? Icons.push_pin_outlined
                          : Icons.push_pin,
                    ),
                    onPressed: controller.toggleFavouriteRoom,
                  ),
                  IconButton(
                    icon: Icon(
                      controller.anySelectedRoomNotMuted
                          ? Icons.notifications_off_outlined
                          : Icons.notifications_outlined,
                    ),
                    tooltip: L10n.of(context)!.toggleMuted,
                    onPressed: controller.toggleMuted,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outlined),
                    tooltip: L10n.of(context)!.archive,
                    onPressed: controller.archiveAction,
                  ),
                ]
              : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
