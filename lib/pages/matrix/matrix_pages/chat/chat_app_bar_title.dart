
import 'package:bitnet/backbone/helper/matrix_helpers/matrix_sdk_extensions/matrix_locals.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/user_bottom_sheet/user_bottom_sheet.dart';
import 'package:bitnet/pages/chat_list/chat/chat.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';



class ChatAppBarTitle extends StatelessWidget {
  final ChatController controller;
  const ChatAppBarTitle(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final room = controller.room;
    if (controller.selectedEvents.isNotEmpty) {
      return Text(controller.selectedEvents.length.toString());
    }
    final directChatMatrixID = room.directChatMatrixID;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: directChatMatrixID != null
          ? () => BitNetBottomSheet(
                context: context,
                child: UserBottomSheet(
                  user: room
                      .unsafeGetUserFromMemoryOrFallback(directChatMatrixID),
                  outerContext: context,
                  onMention: () => controller.sendController.text +=
                      '${room.unsafeGetUserFromMemoryOrFallback(directChatMatrixID).mention} ',
                ),
              )
          : controller.isArchived
              ? null
              : () =>
                  context.go(context.namedLocation('rooms', pathParameters: {'roomid': room.id})+"/details"),
      child: Row(
        children: [
          Hero(
            tag: 'content_banner',
            child: Avatar(
              mxContent: room.avatar,
              name: room.getLocalizedDisplayname(
                MatrixLocals(L10n.of(context)!),
              ),
              size: AppTheme.cardPadding * 1.25,
            ),
          ),
          const SizedBox(width: AppTheme.elementSpacing),
          Expanded(
            child: Text(
              room.getLocalizedDisplayname(MatrixLocals(L10n.of(context)!)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
