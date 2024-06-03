import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/pages/secondpages/keymetrics/keymetrics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class KeyMetricsScreen extends StatefulWidget {
  const KeyMetricsScreen({super.key});

  @override
  State<KeyMetricsScreen> createState() => _KeyMetricsScreenState();
}

class _KeyMetricsScreenState extends State<KeyMetricsScreen> {
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.keyMetrics,
        context: context,
        onTap: () {
          context.pop();
        },
      ),
      body: RoundedContainer(
        contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding * 2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: AppTheme.cardPadding),
              child: Text(
                L10n.of(context)!.keyMetrics,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            buildKeymetrics(),
          ],
        ),
      ),
    );
  }
}
