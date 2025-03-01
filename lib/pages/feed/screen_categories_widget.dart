import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
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
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GetBuilder<FeedController>(
      builder: (controller) {
        final bool isSelected = index == controller.tabController?.index;
        final Color textColor = isSelected
            ? Theme.of(context).colorScheme.primary
            : isDarkMode
                ? AppTheme.white60
                : AppTheme.black60;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                controller.tabController?.animateTo(index);
                controller.update();
              },
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              highlightColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.05),
              child: Container(
                child: isSelected
                    ? _buildSelectedTab(context, textColor)
                    : _buildInactiveTab(context, textColor),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectedTab(BuildContext context, Color textColor) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GlassContainer(
      blur: isDarkMode ? 5 : 2,
      opacity: isDarkMode ? 0.15 : 0.05,
      borderThickness: 1,
      borderRadius: BorderRadius.circular(16),
      customColor: isDarkMode
          ? AppTheme.black80.withOpacity(0.25)
          : Colors.white.withOpacity(0.85),
      customShadow: !isDarkMode ? [
        BoxShadow(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        )
      ] : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundedButtonWidget(
              iconData: _getIconForCategory(text),
              onTap: () {},
              buttonType: ButtonType.solid,
              size: AppTheme.cardPadding * 1.25,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInactiveTab(BuildContext context, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIconForCategory(text),
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}