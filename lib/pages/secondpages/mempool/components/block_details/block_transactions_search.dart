import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:flutter/material.dart';

/// Search field for block transactions that displays transaction count
class BlockTransactionsSearch extends StatelessWidget {
  final int transactionCount;
  final Function(String) handleSearch;
  final Function onTap;
  final bool isEnabled;

  const BlockTransactionsSearch({
    Key? key,
    required this.transactionCount,
    required this.handleSearch,
    required this.onTap,
    this.isEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: SearchFieldWidget(
          isSearchEnabled: isEnabled,
          hintText: '$transactionCount transactions',
          handleSearch: handleSearch,
        ),
      ),
    );
  }
}
