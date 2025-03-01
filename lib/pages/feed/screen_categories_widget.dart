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
      opacity: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing  * 0.75, vertical: AppTheme.elementSpacing / 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundedButtonWidget(
              iconData: _getIconForCategory(text),
              onTap: () {},
              buttonType: ButtonType.solid,
              size: AppTheme.cardPadding * 1.25,
            ),
            const SizedBox(width: AppTheme.elementSpacing * 0.5),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInactiveTab(BuildContext context, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing * 0.75, vertical: AppTheme.elementSpacing / 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedButtonWidget(
            iconData: _getIconForCategory(text),
            onTap: () {},
            buttonType: ButtonType.transparent,
            size: AppTheme.cardPadding * 1.25,
          ),
          const SizedBox(width: AppTheme.elementSpacing * 0.5),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}