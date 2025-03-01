import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenCategoryWidget extends StatelessWidget {
  final String image;
  final String text;
  final String header;
  final int index;
  
  const ScreenCategoryWidget({
    required this.image, 
    required this.text, 
    required this.header, 
    required this.index, 
    super.key
  });

  // Helper method to get the appropriate FontAwesomeIcon
  IconData _getIconForCategory(String text) {
    switch (text) {
      case 'Tokens':
        return FontAwesomeIcons.coins;
      case 'Assets':
        return FontAwesomeIcons.images;
      case 'People':
        return FontAwesomeIcons.userGroup;
      case 'Blockchain':
        return FontAwesomeIcons.cubes;
      case 'Liked':
        return FontAwesomeIcons.solidHeart;
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Using GetBuilder to ensure the widget rebuilds when the tab controller changes
    return GetBuilder<FeedController>(
      builder: (controller) {
        final bool isSelected = index == controller.tabController?.index;
        final primaryColor = Theme.of(context).colorScheme.primary;
        
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppTheme.elementSpacing / 2,
            vertical: AppTheme.elementSpacing / 2,
          ),
          width: 74, // Fixed width instead of using ScreenUtil to avoid overflow
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: AppTheme.cardRadiusMid,
              onTap: () {
                controller.tabController?.animateTo(index);
                controller.update(); // Force update after tab change
              },
              splashColor: primaryColor.withOpacity(0.1),
              highlightColor: primaryColor.withOpacity(0.05),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusMid,
                ),
                child: GlassContainer(
                  blur: isDarkMode ? 5 : 2,
                  opacity: isDarkMode ? 0.15 : 0.05,
                  borderThickness: isSelected ? 2 : 1,
                  borderRadius: AppTheme.cardRadiusMid,
                  customColor: isSelected 
                    ? (isDarkMode ? AppTheme.black80.withOpacity(0.25) : Colors.white.withOpacity(0.85))
                    : (isDarkMode ? AppTheme.black80.withOpacity(0.1) : Colors.white.withOpacity(0.6)),
                  customShadow: isSelected && !isDarkMode ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ] : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Indicator bar for selected item
                        if (isSelected)
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            height: 3,
                            width: 30,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? primaryColor.withOpacity(isDarkMode ? 0.15 : 0.08) 
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getIconForCategory(text),
                            size: 20, // Fixed size instead of using ScreenUtil
                            color: isSelected
                                ? primaryColor
                                : isDarkMode ? AppTheme.white70 : AppTheme.black70,
                          ),
                        ),
                        
                        // Text label
                        const SizedBox(height: 6),
                        Text(
                          text, 
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 12,
                            fontWeight: isSelected 
                              ? FontWeight.bold 
                              : FontWeight.normal,
                            color: isSelected
                              ? primaryColor
                              : isDarkMode ? AppTheme.white80 : AppTheme.black80,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}