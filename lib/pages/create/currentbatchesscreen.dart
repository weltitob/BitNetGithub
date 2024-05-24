import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            text: 'Current Batches',
            context: context,
            onTap: () {
              Navigator.of(context).pop();
            }
        ),
        body: Container(
          margin: EdgeInsets.only(top: AppTheme.cardPadding * 4),
        ),
        context: context
    );
  }
}
