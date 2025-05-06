import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class FilterBottomSheet extends StatelessWidget {
  final Function(String) onSortingChanged;
  final String currentSortingFilter;

  const FilterBottomSheet({
    Key? key,
    required this.onSortingChanged,
    required this.currentSortingFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: "Filter & Sort",
        hasBackButton: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header

                // Sorting Options

                // Sorting Option List
                Column(
                  children: [
                    _buildSortOption(context, "Recently Listed"),
                    _buildSortOption(context, "Rank"),
                    _buildSortOption(context, "Lowest Price"),
                    _buildSortOption(context, "Highest Price"),
                    _buildSortOption(context, "Lowest Inscription"),
                    _buildSortOption(context, "Highest Inscription"),
                  ],
                ),

                // Apply Button
              ],
            ),
          ),
          BottomCenterButton(
              buttonTitle: "Apply",
              buttonState: ButtonState.idle,
              onButtonTap: () {}),
        ],
      ),
    );
  }

  Widget _buildSortOption(BuildContext context, String title) {
    final isSelected = currentSortingFilter == title;

    return ListTile(
      onTap: () {
        onSortingChanged(title);
      },
      contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.elementSpacing, vertical: 4.0),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppTheme.colorBitcoin : null,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: AppTheme.colorBitcoin)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      tileColor: isSelected ? AppTheme.colorBitcoin.withOpacity(0.1) : null,
    );
  }
}
