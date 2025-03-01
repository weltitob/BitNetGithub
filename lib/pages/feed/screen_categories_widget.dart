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
  const ScreenCategoryWidget({required this.image, required this.text, required this.header, required this.index, super.key});

  // Helper method to get the appropriate FontAwesomeIcon
  IconData _getIconForCategory(String text) {
    switch (text) {
      case 'Tokens':
        return FontAwesomeIcons.coins;
      case 'Assets':
        return FontAwesomeIcons.images;
      case 'People':
        return FontAwesomeIcons.users;
      case 'Blockchain':
        return FontAwesomeIcons.cube;
      case 'Liked':
        return FontAwesomeIcons.heart;
      default:
        return FontAwesomeIcons.circleQuestion;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
        top: 10,
        bottom: 10,
        left: 3,
      ),
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: AppTheme.cardRadiusMid,
        boxShadow: [
          AppTheme.boxShadowSuperSmall,
        ],
      ),
      child: Transform.scale(
        scale: index == controller.tabController?.index ? 1 : 0.9,
        child: GlassContainer(
          borderThickness: index == controller.tabController?.index ? 3 : 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Using FontAwesomeIcon instead of Image
              Icon(
                _getIconForCategory(text),
                size: 28.sp,
                color: index == controller.tabController?.index
                    ? AppTheme.colorBitcoin
                    : isDarkMode ? AppTheme.white70 : AppTheme.black70,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(text, 
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: index == controller.tabController?.index 
                      ? FontWeight.bold 
                      : FontWeight.normal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}