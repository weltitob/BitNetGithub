import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class BitNetTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<Tab> tabs;
  final EdgeInsets buttonMargin;
  final EdgeInsets contentPadding;
  final double borderWidth;
  final Color unselectedBorderColor;
  final double radius;
  final ScrollPhysics physics;
  final BoxDecoration unselectedDecoration;

  // controller: controller.tabController,
  // buttonMargin: EdgeInsets.only(
  // left: AppTheme.elementSpacing,),
  // contentPadding: const EdgeInsets.symmetric(
  // vertical: AppTheme.elementSpacing * 0.5,
  // horizontal: AppTheme.elementSpacing,
  // ),
  // borderWidth: AppTheme.tabbarBorderWidth,
  // unselectedBorderColor: Colors.transparent,
  // borderColor: Colors.white.withOpacity(0.2),
  // radius: AppTheme.cardPaddingSmall,
  // physics: ClampingScrollPhysics(),
  // // give the indicator a decoration (color and border radius)
  // decoration: BoxDecoration(
  // color: Colors.white.withOpacity(0.1),
  // borderRadius: AppTheme.cardRadiusSmall,
  // ),
  // unselectedDecoration: BoxDecoration(
  // color: Colors.transparent,
  // borderRadius: AppTheme.cardRadiusSmall,
  // ),

  const BitNetTabBar({
    Key? key,
    this.tabController,
    required this.tabs,
    this.buttonMargin = const EdgeInsets.only(left: AppTheme.elementSpacing), // Default value from AppTheme.elementSpacing
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: AppTheme.elementSpacing * 0.5,
      horizontal: AppTheme.elementSpacing / 4,
    ),
    this.borderWidth = AppTheme.tabbarBorderWidth,
    this.unselectedBorderColor = Colors.transparent,
    this.radius = AppTheme.cardPaddingSmall,
    this.physics = const ClampingScrollPhysics(),
    this.unselectedDecoration = const BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(AppTheme.cardPaddingSmall)),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool useBitcoinGradient = theme.colorScheme.primary == AppTheme.colorBitcoin;
    
    return HorizontalFadeListView(
      child: ButtonsTabBar(
        controller: tabController,
        buttonMargin: buttonMargin,
        contentPadding: contentPadding,
        borderWidth: borderWidth,
        unselectedBorderColor: unselectedBorderColor,
        borderColor: theme.colorScheme.primary.withOpacity(0.3),
        radius: radius,
        physics: physics,
        duration: 250,
        decoration: useBitcoinGradient
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.colorBitcoin,
                  AppTheme.colorPrimaryGradient,
                ],
              ),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.colorBitcoin.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            )
          : BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
        unselectedDecoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        ),
        tabs: tabs,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: useBitcoinGradient 
              ? Colors.white 
              : theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}