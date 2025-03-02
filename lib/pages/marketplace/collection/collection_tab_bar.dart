import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/pages/marketplace/collection/widgets/collection_tab_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionTabBar extends StatelessWidget {
  final int currentTabIndex;
  final Function(int) onTabChanged;

  const CollectionTabBar({
    Key? key,
    required this.currentTabIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.cardPadding * 2.5.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CollectionTabIcon(
            iconData: Icons.view_column_rounded,
            index: 0,
            currentIndex: currentTabIndex,
            label: "Column",
            onTap: () => onTabChanged(0),
          ),
          CollectionTabIcon(
            iconData: Icons.table_rows_rounded,
            index: 1,
            currentIndex: currentTabIndex,
            label: "Row",
            onTap: () => onTabChanged(1),
          ),
          CollectionTabIcon(
            iconData: Icons.monetization_on,
            index: 2,
            currentIndex: currentTabIndex,
            label: "Price",
            onTap: () => onTabChanged(2),
          ),
          CollectionTabIcon(
            iconData: Icons.people,
            index: 3,
            currentIndex: currentTabIndex,
            label: "Owners",
            onTap: () => onTabChanged(3),
          ),
          CollectionTabIcon(
            iconData: Icons.info_outline,
            index: 4,
            currentIndex: currentTabIndex,
            label: "Info",
            onTap: () => onTabChanged(4),
          ),
        ],
      ),
    );
  }
}