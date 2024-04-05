import 'package:bitnet/backbone/helper/matrix_helpers/matrix_sdk_extensions/matrix_locals.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/other/date_time_extension.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/other/room_status_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/send_file_dialog.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/material.dart';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';

import '../../../../components/container/avatar.dart';

enum ArchivedRoomAction { delete, rejoin }

class ChatListItem extends StatelessWidget {
  final Room room;
  final bool activeChat;
  final bool selected;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const ChatListItem(
    this.room, {
    this.activeChat = false,
    this.selected = false,
    this.onTap,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  void clickAction(BuildContext context) async {
    if (onTap != null) return onTap!();
    if (activeChat) return;
    if (room.membership == Membership.invite) {
      final joinResult = await showFutureLoadingDialog(
        context: context,
        future: () async {
          final waitForRoom = room.client.waitForRoomInSync(
            room.id,
            join: true,
          );
          await room.join();
          await waitForRoom;
        },
      );
      if (joinResult.error != null) return;
    }

    if (room.membership == Membership.ban) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(L10n.of(context)!.youHaveBeenBannedFromThisChat),
        ),
      );
      return;
    }

    if (room.membership == Membership.leave) {
      context.goNamed('archive', pathParameters: {'roomid': room.id});
    }

    if (room.membership == Membership.join) {
      // Share content into this room
      final shareContent = Matrix.of(context).shareContent;
      if (shareContent != null) {
        final shareFile = shareContent.tryGet<MatrixFile>('file');
        if (shareContent.tryGet<String>('msgtype') ==
                'chat.fluffy.shared_file' &&
            shareFile != null) {
          await showDialog(
            context: context,
            useRootNavigator: false,
            builder: (c) => SendFileDialog(
              files: [shareFile],
              room: room,
            ),
          );
        } else {
          room.sendEvent(shareContent);
        }
        Matrix.of(context).shareContent = null;
      }

      context.goNamed('rooms', pathParameters: {'roomid': room.id});
    }
  }

  Future<void> archiveAction(BuildContext context) async {
    {
      if ([Membership.leave, Membership.ban].contains(room.membership)) {
        await showFutureLoadingDialog(
          context: context,
          future: () => room.forget(),
        );
        return;
      }
      final confirmed = await showOkCancelAlertDialog(
        useRootNavigator: false,
        context: context,
        title: L10n.of(context)!.areYouSure,
        okLabel: L10n.of(context)!.yes,
        cancelLabel: L10n.of(context)!.no,
      );
      if (confirmed == OkCancelResult.cancel) return;
      await showFutureLoadingDialog(
        context: context,
        future: () => room.leave(),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = room.pushRuleState != PushRuleState.notify;
    final typingText = room.getLocalizedTypingText(context);
    final ownMessage =
        room.lastEvent?.senderId == Matrix.of(context).client.userID;
    final unread = room.isUnread || room.membership == Membership.invite;
    final unreadBubbleSize = unread || room.hasNewMessages
        ? room.notificationCount > 0
            ? 20.0
            : 14.0
        : 0.0;
    final displayname = room.getLocalizedDisplayname(
      MatrixLocals(L10n.of(context)!),
    );
    return Container(
      child: BitNetListTile(
        margin: const EdgeInsets.symmetric(
          horizontal: AppTheme.elementSpacing / 2,
          vertical: 2,
        ),
        isActive: activeChat,
        selected: selected,
        visualDensity: const VisualDensity(vertical: -0.5),
        onLongPress: onLongPress,
        leading: selected
            ? SizedBox(
                width: Avatar.defaultSize,
                height: Avatar.defaultSize,
                child: Stack(
                  children: [
                    Avatar(
                      mxContent: room.avatar,
                      name: displayname,
                      onTap: onLongPress,
                      profileId: room.id,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Material(
                        color: AppTheme.colorSchemeSeed,
                        borderRadius:
                            BorderRadius.circular(Avatar.defaultSize / 4),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppTheme.elementSpacing / 4),
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: AppTheme.white90,
                            size: AppTheme.elementSpacing * 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Avatar(
                mxContent: room.avatar,
                name: displayname,
                onTap: onLongPress,
                profileId: room.id,
              ),
        customTitle: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                displayname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppTheme.white90,
                  fontWeight: unread ? FontWeight.bold : null,
                )
              ),
            ),
            if (isMuted)
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Icon(
                  Icons.notifications_off_outlined,
                  size: 16,
                ),
              ),
            if (room.isFavourite)
              Padding(
                padding: EdgeInsets.only(
                  right: room.notificationCount > 0 ? 4.0 : 0.0,
                ),
                child: Icon(
                  Icons.push_pin,
                  size: 16,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                room.timeCreated.localizedTimeShort(context),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: unread
                      ? AppTheme.white90
                      : Theme.of(context).textTheme.bodyMedium!.color,
                )
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (typingText.isEmpty &&
                ownMessage &&
                room.lastEvent!.status.isSending) ...[
              SizedBox(
                width: 16,
                height: 16,
                child: dotProgress(context, size: 10),
              ),
              const SizedBox(width: 4),
            ],
            AnimatedContainer(
              width: typingText.isEmpty ? 0 : 18,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              duration: AppTheme.animationDuration,
              curve: AppTheme.animationCurve,
              padding: const EdgeInsets.only(right: AppTheme.elementSpacing / 4),
              child: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).colorScheme.onBackground,
                size: AppTheme.elementSpacing,
              ),
            ),
            Expanded(
              child: typingText.isNotEmpty
                  ? Text(
                      typingText,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      maxLines: 1,
                      softWrap: false,
                    )
                  : FutureBuilder<String>(
                      future: room.lastEvent?.calcLocalizedBody(
                            MatrixLocals(L10n.of(context)!),
                            hideReply: true,
                            hideEdit: true,
                            plaintextBody: true,
                            removeMarkdown: true,
                            withSenderNamePrefix: !room.isDirectChat ||
                                room.directChatMatrixID !=
                                    room.lastEvent?.senderId,
                          ) ??
                          Future.value(L10n.of(context)!.emptyChat),
                      builder: (context, snapshot) {
                        return Text(
                          room.membership == Membership.invite
                              ? L10n.of(context)!.youAreInvitedToThisChat
                              : snapshot.data ??
                                  room.lastEvent?.calcLocalizedBodyFallback(
                                    MatrixLocals(L10n.of(context)!),
                                    hideReply: true,
                                    hideEdit: true,
                                    plaintextBody: true,
                                    removeMarkdown: true,
                                    withSenderNamePrefix: !room.isDirectChat ||
                                        room.directChatMatrixID !=
                                            room.lastEvent?.senderId,
                                  ) ??
                                  L10n.of(context)!.emptyChat,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                            // color:
                            // Theme.of(context).colorScheme.onSurfaceVariant,
                            decoration: room.lastEvent?.redacted == true
                                ? TextDecoration.lineThrough
                                : null,
                          )
                        );
                      },
                    ),
            ),
            const SizedBox(width: AppTheme.elementSpacing / 2),
            AnimatedContainer(
              duration: AppTheme.animationDuration,
              curve: AppTheme.animationCurve,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              height: unreadBubbleSize,
              width:
                  room.notificationCount == 0 && !unread && !room.hasNewMessages
                      ? 0
                      : (unreadBubbleSize - 9) *
                              room.notificationCount.toString().length +
                          9,
              decoration: BoxDecoration(
                color: room.highlightCount > 0 ||
                        room.membership == Membership.invite
                    ? AppTheme.errorColor
                    : room.notificationCount > 0 || room.markedUnread
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              ),
              child: Center(
                child: room.notificationCount > 0
                    ? Text(
                        room.notificationCount.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: room.highlightCount > 0
                              ? Colors.white
                              : room.notificationCount > 0
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                        )
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
        onTap: () => clickAction(context),
      ),
    );
  }
}
