import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart'; // Import the helpers file for HapticFeedback
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';

class ScreenCategoryWidget extends StatefulWidget {
  final String text;
  final int index;

  const ScreenCategoryWidget(
      {required this.text, required this.index, super.key});

  @override
  State<ScreenCategoryWidget> createState() => _ScreenCategoryWidgetState();
}

class _ScreenCategoryWidgetState extends State<ScreenCategoryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    // Get controller only once - no need to use GetBuilder
    final controller = Get.find<FeedController>();
    final theme = Theme.of(context);

    // Function to handle tab change
    void handleTabChange() {
      print("Tab pressed: ${widget.index}");

      // Use the direct tab switching method instead of manipulating the controller
      controller.switchToTab(widget.index);

      // Add haptic feedback for better user experience using our custom HapticFeedback class
      HapticFeedback.lightImpact();
    }

    // Use Obx for more efficient reactive updates
    return Obx(() {
      // Reactive isSelected check
      final bool isSelected = widget.index == controller.currentTabIndex.value;

      // Performance improvement: use const padding
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: (details) {
            _handleTapUp(details);
            handleTabChange();
          },
          onTapCancel: _handleTapCancel,
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Material(
                  color: Colors.transparent,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 0.75,
                      vertical: AppTheme.elementSpacing / 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(
                              color: theme.colorScheme.primary.withOpacity(0.2),
                              width: 1,
                            )
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RoundedButtonWidget(
                          iconData: _getIconForCategory(widget.text),
                          onTap: () {},
                          buttonType: isSelected ? ButtonType.solid : ButtonType.transparent,
                          size: AppTheme.cardPadding * 1.25,
                        ),
                        const SizedBox(width: AppTheme.elementSpacing * 0.5),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                          child: Text(widget.text),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

}
