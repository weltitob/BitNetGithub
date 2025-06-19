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
    final theme = Theme.of(context);
    
    return Container(
      height: AppTheme.cardPadding * 3.2.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w),
      padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w, vertical: AppTheme.elementSpacing.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CollectionTabIcon(
              iconData: Icons.table_rows_rounded,
              index: 0,
              currentIndex: currentTabIndex,
              label: "Row",
              onTap: () => onTabChanged(0),
            ),
          ),
          Expanded(
            child: CollectionTabIcon(
              iconData: Icons.view_column_rounded,
              index: 1,
              currentIndex: currentTabIndex,
              label: "Column",
              onTap: () => onTabChanged(1),
            ),
          ),
          Expanded(
            child: CollectionTabIcon(
              iconData: Icons.monetization_on_outlined,
              index: 2,
              currentIndex: currentTabIndex,
              label: "Price",
              onTap: () => onTabChanged(2),
            ),
          ),
          Expanded(
            child: CollectionTabIcon(
              iconData: Icons.people_outline,
              index: 3,
              currentIndex: currentTabIndex,
              label: "Owners",
              onTap: () => onTabChanged(3),
            ),
          ),
          Expanded(
            child: CollectionTabIcon(
              iconData: Icons.info_outline,
              index: 4,
              currentIndex: currentTabIndex,
              label: "Info",
              onTap: () => onTabChanged(4),
            ),
          ),
        ],
      ),
    );
  }
}