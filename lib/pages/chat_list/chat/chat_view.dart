import 'package:bitnet/backbone/helper/matrix_helpers/other/stream_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetFAB.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';


import 'package:bitnet/pages/chat_list/chat/chat.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/chat_app_bar_title.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/chat_event_list.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/encryption_button.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/pinned_events.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/reactions_picker.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/reply_display.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/tombstone_display.dart';
import 'package:bitnet/pages/matrix/widgets/connection_status_header.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:bitnet/pages/matrix/widgets/unread_rooms_badge.dart';
import '../../matrix/matrix_pages/chat/chat_input_row.dart';

enum _EventContextAction { info, report }

class ChatView extends StatelessWidget {
  final ChatController controller;

  const ChatView(this.controller, {Key? key}) : super(key: key);

  List<Widget> _appBarActions(BuildContext context) {
    if (controller.selectMode) {
      return [
        if (controller.canEditSelectedEvents)
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: L10n.of(context)!.edit,
            onPressed: controller.editSelectedEventAction,
          ),
        IconButton(
          icon: const Icon(Icons.copy_outlined),
          tooltip: L10n.of(context)!.copy,
          onPressed: controller.copyEventsAction,
        ),
        if (controller.canSaveSelectedEvent)
          // Use builder context to correctly position the share dialog on iPad
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.adaptive.share),
              tooltip: L10n.of(context)!.share,
              onPressed: () => controller.saveSelectedEvent(context),
            ),
          ),
        if (controller.canRedactSelectedEvents)
          IconButton(
            icon: const Icon(Icons.delete_outlined),
            tooltip: L10n.of(context)!.redactMessage,
            onPressed: controller.redactEventsAction,
          ),
        IconButton(
          icon: const Icon(Icons.push_pin_outlined),
          onPressed: controller.pinEvent,
          tooltip: L10n.of(context)!.pinMessage,
        ),
        if (controller.selectedEvents.length == 1)
          PopupMenuButton<_EventContextAction>(
            onSelected: (action) {
              switch (action) {
                case _EventContextAction.info:
                  controller.showEventInfo();
                  controller.clearSelectedEvents();
                  break;
                case _EventContextAction.report:
                  controller.reportEventAction();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _EventContextAction.info,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.info_outlined),
                    const SizedBox(width: 12),
                    Text(L10n.of(context)!.messageInfo),
                  ],
                ),
              ),
              PopupMenuItem(
                value: _EventContextAction.report,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: AppTheme.errorColor,
                    ),
                    const SizedBox(width: 12),
                    Text(L10n.of(context)!.reportMessage),
                  ],
                ),
              ),
            ],
          ),
      ];
    } else if (controller.isArchived) {
      return [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton.icon(
            onPressed: controller.forgetRoom,
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            icon: const Icon(Icons.delete_forever_outlined),
            label: Text(L10n.of(context)!.delete),
          ),
        )
      ];
    } else {
      return [
        if (Matrix.of(context).voipPlugin != null &&
            controller.room.isDirectChat)
          IconButton(
            onPressed: controller.onPhoneButtonTap,
            icon: const Icon(Icons.call_outlined),
            tooltip: L10n.of(context)!.placeCall,
          ),
        EncryptionButton(controller.room),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.room.membership == Membership.invite) {
      showFutureLoadingDialog(
        context: context,
        future: () => controller.room.join(),
      );
    }
    final bottomSheetPadding = AppTheme.isColumnMode(context)
        ? AppTheme.elementSpacing * 1.5
        : AppTheme.elementSpacing * 0.75;
    final colorScheme = Theme.of(context).colorScheme;

      return WillPopScope(
        onWillPop: ()async {
                  if (controller.selectedEvents.isNotEmpty) {
          controller.clearSelectedEvents();
          return false;
        } else if (controller.showEmojiPicker) {
          controller.emojiPickerAction();
          return false;
        } else {
                    context.go('/feed');

          return false;
        }

        },
        child: GestureDetector(
          onTapDown: (_) => controller.setReadMarker(),
          behavior: HitTestBehavior.opaque,
          child: bitnetScaffold(
                extendBodyBehindAppBar: true,
                context: context,
                appBar: bitnetAppBar(
                  //titleSpacing: 0,
                  //elevation: 3,
                  // actionsIconTheme: IconThemeData(
                  //   color: controller.selectedEvents.isEmpty
                  //       ? null
                  //       : Theme.of(context).colorScheme.primary,
                  // ),
                  context: context,
                  customLeading: controller.selectMode
                      ?
                  GestureDetector(
                    onTap: controller.clearSelectedEvents,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: AppTheme.elementSpacing * 1.5,
                          right: AppTheme.elementSpacing * 0.5,
                          top: AppTheme.elementSpacing,
                          bottom: AppTheme.elementSpacing),
                      child: RoundedButtonWidget(
                        buttonType: ButtonType.solid,
                        iconData: Icons.close_outlined,
                        onTap: () {
                          context.go('/feed');
                        },
                      ),
                    ),
                  ) :
                  InkWell(
                          onTap: () => context.go('/feed'),
                          child: UnreadRoomsBadge(
                            filter: (r) => r.id != controller.roomId,
                            badgePosition: BadgePosition.topEnd(end: 8, top: 4),
                            child: Center(
                              child:  Container(
                                margin: const EdgeInsets.only(
                                    left: AppTheme.elementSpacing * 1.5,
                                    right: AppTheme.elementSpacing * 0.5,
                                    top: AppTheme.elementSpacing,
                                    bottom: AppTheme.elementSpacing),
                                child: RoundedButtonWidget(
                                  buttonType: ButtonType.solid,
                                  iconData: Icons.arrow_back_outlined,
                                  onTap: () {
                                    context.go('/feed');
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                  customTitle: ChatAppBarTitle(controller),
                  actions: _appBarActions(context),
                ),
                floatingActionButton: Padding(
                      padding: const EdgeInsets.only(bottom: AppTheme.cardPadding * 2),
                      child: AnimatedOpacity(
                        opacity: controller.showScrollDownButton &&
                            controller.selectedEvents.isEmpty ? 1 : 0,
                        duration: Duration(milliseconds: 200),
                        child: BitNetFAB(
                            onPressed: controller.scrollDown,
                          ),
                      ),
                    ),
                body: DropTarget(
                  onDragDone: controller.onDragDone,
                  onDragEntered: controller.onDragEntered,
                  onDragExited: controller.onDragExited,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).colorScheme.background,
                        ),
                      // if (Matrix.of(context).wallpaper != null)
                      //   Image.file(
                      //     Matrix.of(context).wallpaper!,
                      //     width: double.infinity,
                      //     height: double.infinity,
                      //     fit: BoxFit.cover,
                      //     filterQuality: FilterQuality.medium,
                      //   )
                      // else
                      //   Container(
                      //     decoration: BoxDecoration(
                      //       gradient: LinearGradient(
                      //         begin: Alignment.topCenter,
                      //         colors: [
                      //           colorScheme.primaryContainer.withAlpha(64),
                      //           colorScheme.secondaryContainer.withAlpha(64),
                      //           colorScheme.tertiaryContainer.withAlpha(64),
                      //           colorScheme.primaryContainer.withAlpha(64),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      StreamBuilder(
                          stream: controller.room.onUpdate.stream
                              .rateLimit(const Duration(seconds: 1)),
                          builder: (context, snapshot) => FutureBuilder(
                              future: controller.loadTimelineFuture,
                              builder: (BuildContext context, snapshot) {
                          return Column(
                            children: <Widget>[
                              TombstoneDisplay(controller),
                              PinnedEvents(controller),
                              Expanded(
                                child: GestureDetector(
                                  onTap: controller.clearSingleSelectedEvent,
                                  child: Builder(
                                    builder: (context) {
                                      if (controller.timeline == null) {
                                        return Center(
                                          child: dotProgress(context),
                                        );
                                      }
        
                                      return ChatEventList(
                                        controller: controller,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              if (controller.room.canSendDefaultMessages &&
                                  controller.room.membership == Membership.join)
                                Container(
                                  margin: EdgeInsets.only(
                                    left: bottomSheetPadding,
                                    right: bottomSheetPadding,
                                    bottom: bottomSheetPadding
                                  ),
                                  constraints: const BoxConstraints(
                                    maxWidth: AppTheme.columnWidth * 2.5,
                                  ),
                                  alignment: Alignment.center,
                                  child: Material(
                                    borderRadius: AppTheme.cardRadiusMid,
                                    elevation: 4,
                                    shadowColor: Colors.black.withAlpha(64),
                                    clipBehavior: Clip.hardEdge,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : AppTheme.colorSchemeSeed,
                                    child: controller.room.isAbandonedDMRoom ==
                                            true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  foregroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                ),
                                                icon: const Icon(
                                                  Icons.archive_outlined,
                                                ),
                                                onPressed: controller.leaveChat,
                                                label: Text(
                                                  L10n.of(context)!.leave,
                                                ),
                                              ),
                                              TextButton.icon(
                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                ),
                                                icon: const Icon(
                                                  Icons.forum_outlined,
                                                ),
                                                onPressed:
                                                    controller.recreateChat,
                                                label: Text(
                                                  L10n.of(context)!.reopenChat,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const ConnectionStatusHeader(),
                                              ReactionsPicker(controller),
                                              ReplyDisplay(controller),
                                              ChatInputRow(controller),
                                            ],
                                          ),
                                  ),
                                ),
                            ],
                          );
                        }),
                      ),
                      if (controller.dragging)
                        Container(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.9),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.upload_outlined,
                            size: 100,
                          ),
                        ),
                    ],
                  ),
                )),
        ),
      );
  }
}
