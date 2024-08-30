import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

class CurrentBatchesScreen extends StatefulWidget {
  const CurrentBatchesScreen({super.key});

  @override
  State<CurrentBatchesScreen> createState() => _CurrentBatchesScreenState();
}

class _CurrentBatchesScreenState extends State<CurrentBatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
            text: L10n.of(context)!.currentBatches,
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            }),
        body: Container(
          margin: const EdgeInsets.only(top: AppTheme.cardPadding * 4),
        ),
        context: context);
  }
}
