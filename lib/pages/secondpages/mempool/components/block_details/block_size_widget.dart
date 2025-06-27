import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Widget displaying block size information
class BlockSizeWidget extends StatelessWidget {
  final bool isAccepted;

  const BlockSizeWidget({
    Key? key,
    this.isAccepted = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    // Get the appropriate size and weight based on whether we're looking at accepted or unaccepted block
    double mbSize = isAccepted
        ? controller.txDetailsConfirmed!.size / 1000000
        : controller.mempoolBlocks[controller.indexShowBlock.value].blockSize! /
            1000000;

    double mwu = controller.txDetailsConfirmed!.weight / 1000000;

    // Calculate the width based on the ratio
    double maxWidth = AppTheme.cardPadding * 3;
    double ratio = (mbSize / mwu) * maxWidth;
    double orangeContainerWidth =
        ratio.clamp(0, maxWidth); // Ensuring it doesn't exceed maxWidth

    return GlassContainer(
      height: isAccepted ? null : AppTheme.cardPadding * 6.5.h,
      width: isAccepted ? null : AppTheme.cardPadding * 6.5.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title row with help icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                L10n.of(context)!.blockSize,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                width: AppTheme.elementSpacing / 2,
              ),
              Icon(
                Icons.help_outline_rounded,
                color: AppTheme.white80,
                size: AppTheme.cardPadding * 0.75,
              )
            ],
          ),

          const SizedBox(
            height: AppTheme.cardPadding * 0.5,
          ),

          // Size visualization
          Stack(
            children: [
              // Background container
              Container(
                height: AppTheme.cardPadding * 3,
                width: AppTheme.cardPadding * 3,
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusSmall,
                  color: Colors.grey,
                ),
              ),

              // Filled container representing the ratio
              Container(
                height: AppTheme.cardPadding * 3,
                width: orangeContainerWidth,
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusSmall,
                  color: AppTheme.colorBitcoin,
                ),
              ),

              // Text overlay showing the size
              SizedBox(
                height: AppTheme.cardPadding * 3,
                width: AppTheme.cardPadding * 3,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${mbSize.toStringAsFixed(2)} MB',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppTheme.white90,
                          shadows: [
                            AppTheme.boxShadowBig,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: AppTheme.elementSpacing * 0.75,
          ),

          // Size reference
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "of ${mwu.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Transform.translate(
                offset: const Offset(0, 2),
                child: Text(
                  isAccepted ? ' MB  ' : ' MWU  ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
