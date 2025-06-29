import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

/// Widget displaying block health information
class BlockHealthWidget extends StatelessWidget {
  final bool isAccepted;

  const BlockHealthWidget({
    Key? key,
    this.isAccepted = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    // For unaccepted blocks, assume 100% health since they haven't been mined yet
    double matchRate =
        isAccepted ? controller.txDetailsConfirmed!.extras.matchRate : 100.0;

    return GlassContainer(
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
                L10n.of(context)!.health,
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
            height: AppTheme.cardPadding * 0.75,
          ),

          // Health status icon
          Icon(
            FontAwesomeIcons.faceSmile,
            color: matchRate >= 99
                ? AppTheme.successColor
                : matchRate >= 75 && matchRate < 99
                    ? AppTheme.colorBitcoin
                    : AppTheme.errorColor,
            size: AppTheme.cardPadding * 2.5,
          ),

          const SizedBox(
            height: AppTheme.elementSpacing * 1.25,
          ),

          // Health percentage text
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ('$matchRate %'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
