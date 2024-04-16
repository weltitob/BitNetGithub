import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/pages/secondpages/keymetrics/keymetrics.dart';
import 'package:flutter/material.dart';

class KeyMetricsScreen extends StatefulWidget {
  const KeyMetricsScreen({super.key});

  @override
  State<KeyMetricsScreen> createState() => _KeyMetricsScreenState();
}

class _KeyMetricsScreenState extends State<KeyMetricsScreen> {
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      contentPadding: const EdgeInsets.only(top: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppTheme.cardPadding),
            child: Text(
              "Key metrics",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          buildKeymetrics(),
        ],
      ),
    );
  }
}
