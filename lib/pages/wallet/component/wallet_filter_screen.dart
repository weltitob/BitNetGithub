import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/FilterPillList.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class WalletFilterScreen extends GetWidget<WalletFilterController> {
  const WalletFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: L10n.of(context)!.filter,
      ),
      context: context,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding,
            vertical: AppTheme.cardPadding * 2),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: GlassContainer(
                    height: AppTheme.cardPadding * 1.75,
                    child: TextButton(
                      child: Text(
                        L10n.of(context)!.clear,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onPressed: () {
                        controller.selectedFilters.clear();
                        controller.start =
                            controller.startDate.value.millisecondsSinceEpoch ~/
                                1000;
                        controller.end =
                            controller.endDate.value.millisecondsSinceEpoch ~/
                                1000;
                      },
                    ))),
            SizedBox(height: AppTheme.cardPadding),
            BitNetFilterPillList(
              headingText: L10n.of(context)!.filterOptions,
              listDataText: [
                PillLabelModal(labelText: L10n.of(context)!.lightning),
                PillLabelModal(labelText: L10n.of(context)!.onchain),
                PillLabelModal(labelText: L10n.of(context)!.sent),
                PillLabelModal(labelText: L10n.of(context)!.received),
              ],
            ),
            CommonHeading(
              headingText: L10n.of(context)!.timeFrame,
              hasButton: false,
              collapseBtn: true,
              child: Container(
                margin: EdgeInsets.only(bottom: 30.h),
                child: Row(
                  children: [
                    Expanded(
                        child: StatefulBuilder(builder: (context, setState) {
                      return GlassContainer(
                          child: InkWell(
                        onTap: () async {
                          controller.startDate.value =
                              await controller.selectDate(context);
                          controller.start = controller
                                  .startDate.value.millisecondsSinceEpoch ~/
                              1000;
                          setState(() {});
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppTheme.elementSpacing / 2),
                          child: Center(
                              child: Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(controller.startDate.value),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ))),
                        ),
                      ));
                    })),
                    Container(
                      margin: EdgeInsets.only(left: 10.w, right: 11.w),
                      child: Text(
                        L10n.of(context)!.to,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                    Expanded(
                      child: StatefulBuilder(builder: (context, setState) {
                        return GlassContainer(
                          child: InkWell(
                            onTap: () async {
                              controller.endDate.value =
                                  await controller.selectDate(context);
                              controller.end = controller
                                      .endDate.value.millisecondsSinceEpoch ~/
                                  1000;
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(controller.endDate.value),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            LongButtonWidget(
                title: L10n.of(context)!.apply,
                onTap: () {
                  controller.start =
                      controller.startDate.value.millisecondsSinceEpoch ~/ 1000;
                  controller.end =
                      controller.endDate.value.millisecondsSinceEpoch ~/ 1000;
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
