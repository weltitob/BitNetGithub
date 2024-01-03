import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import '../../../backbone/helper/localized_exception_extension.dart';
import '../../routetrees/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ConnectionStatusHeader extends StatefulWidget {
  const ConnectionStatusHeader({Key? key}) : super(key: key);

  @override
  ConnectionStatusHeaderState createState() => ConnectionStatusHeaderState();
}

class ConnectionStatusHeaderState extends State<ConnectionStatusHeader> {
  late final StreamSubscription _onSyncSub;

  @override
  void initState() {
    _onSyncSub = Matrix.of(context).client.onSyncStatus.stream.listen(
          (_) => setState(() {}),
        );
    super.initState();
  }

  @override
  void dispose() {
    _onSyncSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final client = Matrix.of(context).client;
    final status = client.onSyncStatus.value ??
        const SyncStatusUpdate(SyncStatus.waitingForResponse);
    final hide = client.onSync.value != null &&
        status.status != SyncStatus.error &&
        client.prevBatch != null;

    return AnimatedContainer(
      duration: AppTheme.animationDuration,
      curve: AppTheme.animationCurve,
      height: hide ? 0 : AppTheme.cardPadding * 2,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(color: lighten(Theme.of(context).colorScheme.background, 20)),
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: dotProgress(context, size: 10)
          ),
          const SizedBox(width: AppTheme.elementSpacing),
          Text(
            status.toLocalizedString(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}

extension on SyncStatusUpdate {
  String toLocalizedString(BuildContext context) {
    switch (status) {
      case SyncStatus.waitingForResponse:
        return L10n.of(context)!.loadingPleaseWait;
      case SyncStatus.error:
        return ((error?.exception ?? Object()) as Object)
            .toLocalizedString(context);
      case SyncStatus.processing:
      case SyncStatus.cleaningUp:
      case SyncStatus.finished:
      default:
        return L10n.of(context)!.synchronizingPleaseWait;
    }
  }
}
