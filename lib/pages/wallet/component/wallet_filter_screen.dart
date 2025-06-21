import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/FilterPillList.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WalletFilterScreen extends GetWidget<WalletFilterController> {
  const WalletFilterScreen(
      {this.hideLightning = false,
      this.hideOnchain = false,
      this.hideFilters = false,
      this.forcedFilters,
      super.key});
  final bool hideLightning;
  final bool hideOnchain;
  final List<String>? forcedFilters;
  final bool hideFilters;

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
            child: LongButtonWidget(
                customWidth: AppTheme.cardPadding * 3.75,
                customHeight: AppTheme.cardPadding * 1.25,
                buttonType: ButtonType.transparent,
                title: L10n.of(context)!.clear,
                onTap: () {
                  controller.selectedFilters.clear();
                  if (forcedFilters != null) {
                    for (int i = 0; i < forcedFilters!.length; i++) {
                      controller.toggleFilter(forcedFilters![i]);
                    }
                  }
                  controller.start =
                      controller.startDate.value.millisecondsSinceEpoch ~/ 1000;
                  controller.end =
                      controller.endDate.value.millisecondsSinceEpoch ~/ 1000;
                }),
          )
        ],
        hasBackButton: false,
        context: context,
        text: L10n.of(context)!.filter,
      ),
      context: context,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.cardPadding,
                vertical: AppTheme.cardPadding * 2),
            child: Column(
              children: [
                const SizedBox(height: AppTheme.cardPadding),
                if (!hideFilters)
                  BitNetFilterPillList(
                    headingText: L10n.of(context)!.filterOptions,
                    listDataText: [
                      if (!hideLightning)
                        PillLabelModal(labelText: L10n.of(context)!.lightning),
                      if (!hideOnchain)
                        PillLabelModal(labelText: L10n.of(context)!.onchain),
                      PillLabelModal(labelText: L10n.of(context)!.sent),
                      PillLabelModal(labelText: L10n.of(context)!.received),
                      PillLabelModal(labelText: 'Loop'),
                    ],
                  ),
                SizedBox(height: AppTheme.cardPadding.h * 1.75),
                CommonHeading(
                  headingText: L10n.of(context)!.timeFrame,
                  hasButton: false,
                  collapseBtn: true,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(child:
                            StatefulBuilder(builder: (context, setState) {
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
                              padding: const EdgeInsets.all(
                                  AppTheme.elementSpacing / 2),
                              child: Center(
                                  child: Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(controller.startDate.value),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall)),
                            ),
                          ));
                        })),
                        Container(
                          margin: EdgeInsets.only(
                              left: AppTheme.elementSpacing.w,
                              right: AppTheme.elementSpacing.w),
                          child: Text(L10n.of(context)!.to,
                              style: Theme.of(context).textTheme.titleSmall),
                        ),
                        Expanded(
                          child: StatefulBuilder(builder: (context, setState) {
                            return GlassContainer(
                              child: InkWell(
                                onTap: () async {
                                  controller.endDate.value =
                                      await controller.selectDate(context);
                                  controller.end = controller.endDate.value
                                          .millisecondsSinceEpoch ~/
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
                                            .titleSmall),
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
              ],
            ),
          ),
          BottomCenterButton(
              buttonTitle: L10n.of(context)!.apply,
              buttonState: ButtonState.idle,
              onButtonTap: () {
                controller.start =
                    controller.startDate.value.millisecondsSinceEpoch ~/ 1000;
                controller.end =
                    controller.endDate.value.millisecondsSinceEpoch ~/ 1000;
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
