import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class SortingCategoryPopup extends StatelessWidget {
  final Function(String str) onChanged;
  final String currentSortingCategory;

  const SortingCategoryPopup(
      {Key? key, required this.onChanged, required this.currentSortingCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        backgroundColor: Colors.transparent,
        context: context,
        direction: PopoverDirection.bottom,
        bodyBuilder: (context) {
          return _buildOptions(context);
        },
      ),
      child: Container(
          decoration: BoxDecoration(
              color: AppTheme.colorBitcoin,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Row(
              children: [
                Text(currentSortingCategory,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white)),
                const Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
          )),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildOptionItem(context, "Recently Listed", true),
        _buildOptionItem(context, "Rank", false),
        _buildOptionItem(context, "Lowest Price", false),
        _buildOptionItem(context, "Highest Price", false),
        _buildOptionItem(context, "Lowest Inscription", false),
        _buildOptionItem(context, "Highest Inscription", true, isLast: true),
      ],
    );
  }

  Widget _buildOptionItem(BuildContext context, String title, bool isFirst,
      {bool isLast = false}) {
    return GestureDetector(
      onTap: () {
        onChanged(title);
        Navigator.of(context).pop();
      },
      child: Container(
          width: 160,
          decoration: BoxDecoration(
            color: AppTheme.colorGlassContainer,
            borderRadius: BorderRadius.only(
              topLeft: isFirst ? Radius.circular(20) : Radius.zero,
              topRight: isFirst ? Radius.circular(20) : Radius.zero,
              bottomLeft: isLast ? Radius.circular(20) : Radius.zero,
              bottomRight: isLast ? Radius.circular(20) : Radius.zero,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(title, style: TextStyle(color: Colors.white)),
          )),
    );
  }
}
