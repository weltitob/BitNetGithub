import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WalletCenterWidget extends StatelessWidget {
  const WalletCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletsController>();
    return Container(
      height: AppTheme.cardPadding * 2,
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusBigger,
        boxShadow: [AppTheme.boxShadowProfile],
      ),
      child: GlassContainer(
        borderThickness: 1.5, // remove border if not active
        blur: 50,
        opacity: 0.1,
        width: 1,
        borderRadius: BorderRadius.only(
          bottomLeft: AppTheme.cornerRadiusMid,
          bottomRight: AppTheme.cornerRadiusMid,
          topLeft: AppTheme.cornerRadiusMid,
          topRight: AppTheme.cornerRadiusMid,
        ),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WalletCenterWidgetIcon(
                iconData: Icons.payments,
                index: 0,
                onTap: () {
                  controller.currentView.value = 0;
                },
              ),
              WalletCenterWidgetIcon(
                iconData: Icons.notifications,
                index: 1,
                onTap: () {
                  controller.currentView.value = 1;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletCenterWidgetIcon extends StatelessWidget {
  final IconData iconData;
  final int index;
  final Function() onTap;
  const WalletCenterWidgetIcon({required this.iconData, required this.index, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletsController>();
    return Obx(() {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppTheme.cardPadding * 2.5.w,
          height: AppTheme.cardPadding * 1.75.h,
          child: Icon(
            iconData,
            size: AppTheme.iconSize,
            color: controller.currentView.value == index
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
          ),
        ),
      );
    });
  }
}
