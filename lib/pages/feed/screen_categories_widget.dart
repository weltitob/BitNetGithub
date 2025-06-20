import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart'; // Import the helpers file for HapticFeedback
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';

class ScreenCategoryWidget extends StatelessWidget {
  final String text;
  final int index;

  const ScreenCategoryWidget(
      {required this.text, required this.index, super.key});

  // Helper method to get the appropriate icon and color for each category
  IconData _getIconForCategory(String text) {
    switch (text) {
      case 'Tokens':
        return FontAwesomeIcons.coins;
      case 'People':
        return FontAwesomeIcons.userGroup;
      case 'Websites':
        return FontAwesomeIcons.globe;
      case 'Assets':
        return FontAwesomeIcons.images;
      case 'Blockchain':
        return FontAwesomeIcons.cubes;
      case 'Apps':
        return Icons.apps_rounded;
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get controller only once - no need to use GetBuilder
    final controller = Get.find<FeedController>();
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Function to handle tab change
    void handleTabChange() {
      print("Tab pressed: $index");

      // Use the direct tab switching method instead of manipulating the controller
      controller.switchToTab(index);

      // Add haptic feedback for better user experience using our custom HapticFeedback class
      HapticFeedback.lightImpact();
    }

    // Use Obx for more efficient reactive updates
    return Obx(() {
      // Reactive isSelected check
      final bool isSelected = index == controller.currentTabIndex.value;
      final Color textColor = isSelected
          ? Theme.of(context).colorScheme.primary
          : isDarkMode
              ? AppTheme.white60
              : AppTheme.black60;

      // Performance improvement: use const padding
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: handleTabChange,
            // Simplified tap colors
            splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            highlightColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.05),
            // Cache child widget based on selection state
            child: Container(
              child: isSelected
                  ? _buildSelectedTab(context, textColor, handleTabChange)
                  : _buildInactiveTab(context, textColor, handleTabChange),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSelectedTab(
      BuildContext context, Color textColor, VoidCallback onTabChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.elementSpacing * 0.75,
          vertical: AppTheme.elementSpacing / 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon only, no text
          Icon(
            _getIconForCategory(text),
            size: 26,
            color: textColor,
          ),
          
          // Animated underline indicator
          AnimatedContainer(
            duration: AppTheme.animationDuration,
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(top: 6),
            height: 3,
            width: 28,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInactiveTab(
      BuildContext context, Color textColor, VoidCallback onTabChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.elementSpacing * 0.75,
          vertical: AppTheme.elementSpacing / 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon only, no text  
          Icon(
            _getIconForCategory(text),
            size: 26,
            color: textColor,
          ),
          
          // Hidden underline indicator (width: 0)
          AnimatedContainer(
            duration: AppTheme.animationDuration,
            curve: Curves.easeInOut,
            margin: EdgeInsets.only(top: 6),
            height: 3,
            width: 0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ],
      ),
    );
  }
}
