import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/marketplace_widgets/CommonBtn.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/FilterPillList.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WalletFilterScreen extends GetWidget<WalletFilterController> {
  const WalletFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          FilterPillList(
            headingText: 'Filter Options',
            listDataText: [
              PillLabelModal(labelText: "Lightning"),
              PillLabelModal(labelText: "Onchain"),
              PillLabelModal(labelText: "Sent"),
              PillLabelModal(labelText: "Received"),
            ],
          ),
          CommonHeading(
            headingText: 'TimeFrame',
            hasButton: false,
            collapseBtn: true,
            child: Container(
              margin: EdgeInsets.only(bottom: 30.h),
              child: Row(
                children: [
                  Expanded(
                      child: GlassContainer(
                    child: InkWell(
                      onTap: () async {
                        controller.startDate.value =
                            await controller.selectDate(context);
                      },
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(controller.startDate.value),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromRGBO(249, 249, 249, 1),
                                  ))),
                        ),
                      ),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 11.w),
                    child: Text(
                      'To',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GlassContainer(
                    child: InkWell(
                      onTap: () async {
                        controller.endDate.value =
                            await controller.selectDate(context);
                      },
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(controller.endDate.value),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        const Color.fromRGBO(249, 249, 249, 1),
                                  ))),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width - 40.w,
            child: const CommonBtn(
                hasOnPress: false, text: 'Apply', hasBackPress: true),
          ),
        ],
      ),
    );
  }
}
