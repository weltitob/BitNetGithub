import 'package:bitnet/backbone/helper/theme/theme.dart';
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
      height: 56.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CollectionTabIcon(
            iconData: Icons.grid_view_rounded,
            index: 0,
            currentIndex: currentTabIndex,
            label: "Items",
            onTap: () => onTabChanged(0),
          ),
          CollectionTabIcon(
            iconData: Icons.view_list_rounded,
            index: 1,
            currentIndex: currentTabIndex,
            label: "Activity",
            onTap: () => onTabChanged(1),
          ),
          CollectionTabIcon(
            iconData: Icons.analytics_outlined,
            index: 2,
            currentIndex: currentTabIndex,
            label: "Analytics",
            onTap: () => onTabChanged(2),
          ),
          CollectionTabIcon(
            iconData: Icons.info_outline,
            index: 3,
            currentIndex: currentTabIndex,
            label: "Info",
            onTap: () => onTabChanged(3),
          ),
        ],
      ),
    );
  }
}