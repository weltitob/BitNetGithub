import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TokenMarketplaceTabBar extends StatelessWidget {
  final RxInt currentTab;
  final Function(int) onTabChanged;

  const TokenMarketplaceTabBar({
    Key? key,
    required this.currentTab,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;

    // Get colors for the indicator based on theme
    final Color indicatorColor = isLightMode 
        ? Colors.black.withOpacity(0.2)
        : Colors.white.withOpacity(0.2);

    return Positioned(
      bottom: 0,
      child: Container(
        width: containerWidth,
        height: 65,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TabIcon(
              label: 'Offers',
              iconData: Icons.local_offer_outlined,
              index: 0,
              currentTab: currentTab,
              onTap: () => onTabChanged(0),
            ),
            _TabIcon(
              label: 'Analytics',
              iconData: Icons.analytics_outlined,
              index: 1,
              currentTab: currentTab,
              onTap: () => onTabChanged(1),
            ),
            _TabIcon(
              label: 'Info',
              iconData: Icons.info_outline,
              index: 2,
              currentTab: currentTab,
              onTap: () => onTabChanged(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabIcon extends StatelessWidget {
  final IconData iconData;
  final String label;
  final int index;
  final RxInt currentTab;
  final VoidCallback onTap;

  const _TabIcon({
    Key? key,
    required this.iconData,
    required this.index,
    required this.currentTab,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final bool isSelected = (currentTab.value == index);
      
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 60.w,
          height: 40.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Icon(
                iconData,
                size: 26,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              
              // Indicator bar
              AnimatedContainer(
                duration: AppTheme.animationDuration,
                curve: Curves.easeInOut,
                margin: EdgeInsets.only(top: 6),
                height: 3,
                width: isSelected ? 28 : 0,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}