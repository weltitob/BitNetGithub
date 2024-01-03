import 'package:bitnet/backbone/helper/matrix_helpers/matrix_sdk_extensions/matrix_locals.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/matrix/matrix_pages/chat/events/reply_content.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';
import '../../../chat_list/chat/chat.dart';

class ReplyDisplay extends StatelessWidget {
  final ChatController controller;
  const ReplyDisplay(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppTheme.animationDuration,
      curve: AppTheme.animationCurve,
      height: controller.editEvent != null || controller.replyEvent != null
          ? 56
          : 0,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      child: Material(
        color: Theme.of(context).secondaryHeaderColor,
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: L10n.of(context)!.close,
              icon: const Icon(Icons.close),
              onPressed: controller.cancelReplyEventAction,
            ),
            Expanded(
              child: controller.replyEvent != null
                  ? ReplyContent(
                      controller.replyEvent!,
                      timeline: controller.timeline!,
                    )
                  : _EditContent(
                      controller.editEvent
                          ?.getDisplayEvent(controller.timeline!),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditContent extends StatelessWidget {
  final Event? event;

  const _EditContent(this.event);

  @override
  Widget build(BuildContext context) {
    final event = this.event;
    if (event == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: <Widget>[
        Icon(
          Icons.edit,
          color: Theme.of(context).primaryColor,
        ),
        Container(width: 15.0),
        FutureBuilder<String>(
          future: event.calcLocalizedBody(
            MatrixLocals(L10n.of(context)!),
            withSenderNamePrefix: false,
            hideReply: true,
          ),
          builder: (context, snapshot) {
            return Text(
              snapshot.data ??
                  event.calcLocalizedBodyFallback(
                    MatrixLocals(L10n.of(context)!),
                    withSenderNamePrefix: false,
                    hideReply: true,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            );
          },
        ),
      ],
    );
  }
}
