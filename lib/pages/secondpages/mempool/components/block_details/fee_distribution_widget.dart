import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Widget displaying block fee distribution
class FeeDistributionWidget extends StatelessWidget {
  final bool isAccepted;

  const FeeDistributionWidget({
    Key? key,
    this.isAccepted = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    // Get the appropriate fee data based on whether we're looking at accepted or unaccepted block
    num medianFee = isAccepted
        ? controller.txDetailsConfirmed!.extras.medianFee
        : controller.mempoolBlocks[controller.indexShowBlock.value].medianFee!;

    num totalFees = isAccepted
        ? controller.txDetailsConfirmed!.extras.totalFees
        : controller.mempoolBlocks[controller.indexShowBlock.value].totalFees!;

    List<num> feeRange = isAccepted
        ? controller.txDetailsConfirmed!.extras.feeRange
        : controller.mempoolBlocks[controller.indexShowBlock.value].feeRange!;

    return GlassContainer(
      child: Column(children: [
        // Header with fee information
        BitNetListTile(
          leading: const Icon(
            FontAwesomeIcons.moneyBill,
            size: AppTheme.cardPadding * 0.75,
          ),
          text: L10n.of(context)!.feeDistribution,
          trailing: Container(
            child: Row(
              children: [
                Text(
                  '\$${_formatAmount(((totalFees / 100000000) * controller.currentUSD.value).toStringAsFixed(0))}',
                  style: const TextStyle(
                    color: AppTheme.successColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(
          height: AppTheme.elementSpacing,
        ),

        // Median fee
        Text(
            '${L10n.of(context)!.median}' +
                '~' +
                '\$${(((medianFee * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppTheme.white90,
                )),

        const SizedBox(
          height: AppTheme.elementSpacing,
        ),

        // Fee distribution gauge
        Container(
          width: AppTheme.cardPadding * 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SfLinearGauge(
                showTicks: false,
                showLabels: false,
                useRangeColorForAxis: true,
                axisTrackStyle: const LinearAxisTrackStyle(
                    thickness: AppTheme.cardPadding,
                    color: Colors.grey,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                    gradient: LinearGradient(
                        colors: [AppTheme.errorColor, AppTheme.successColor],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.1, 0.9],
                        tileMode: TileMode.clamp)),
                minimum: feeRange.first.toDouble(),
                maximum: feeRange.last.toDouble(),
                markerPointers: [
                  LinearWidgetPointer(
                      value: medianFee.toDouble(),
                      child: Container(
                        height: AppTheme.cardPadding * 1.25,
                        width: AppTheme.elementSpacing * 0.75,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ))
                ],
              ),

              // Fee range labels
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.elementSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '\$${(((feeRange.first * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppTheme.errorColor,
                            )),
                    Text(
                        '\$${(((feeRange.last * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppTheme.successColor,
                            )),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: AppTheme.cardPadding,
        ),
      ]),
    );
  }

  // Helper method to format amounts with commas
  String _formatAmount(String price) {
    String priceInText = "";
    int counter = 0;
    for (int i = (price.length - 1); i >= 0; i--) {
      counter++;
      String str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }
}
