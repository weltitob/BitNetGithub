import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CenterWidgetIcon extends StatefulWidget {
  final IconData iconData;
  final String label;
  final int index;
  final VoidCallback onTap;

  const CenterWidgetIcon({
    Key? key,
    required this.iconData,
    required this.index,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  State<CenterWidgetIcon> createState() => _CenterWidgetIconState();
}

class _CenterWidgetIconState extends State<CenterWidgetIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
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

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final theme = Theme.of(context);

    return Obx(() {
      final bool isSelected = (controller.currentview.value == widget.index);
      
      return GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing.w * 0.5,
                    vertical: AppTheme.elementSpacing.h * 0.5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon with background
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                        ),
                        child: Icon(
                          widget.iconData,
                          size: AppTheme.iconSize,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Label
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        style: theme.textTheme.labelSmall!.copyWith(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        child: Text(
                          widget.label,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      
                      const SizedBox(height: 2),
                      
                      // Indicator dot instead of bar for modern look
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? theme.colorScheme.primary 
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
