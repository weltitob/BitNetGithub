
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PillLabel extends StatefulWidget {
  final labelText;

  const PillLabel(
      {Key? key,
      required this.labelText})
      : super(key: key);

  @override
  State<PillLabel> createState() => _PillLabelState();
}

class _PillLabelState extends State<PillLabel> {
  final controller = Get.put(WalletFilterController());
  @override
  Widget build(BuildContext context) {
    return Obx(
        () {
        return InkWell(
          onTap: (){
            controller.toggleFilter(widget.labelText);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              color: controller.selectedFilters.contains(widget.labelText) ? Theme.of(context).colorScheme.onPrimaryContainer :const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            padding: EdgeInsets.only(top: 5.w, bottom: 4.w, left: 10.w, right: 10.w),
            child: Text(
              widget.labelText,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: controller.selectedFilters.contains(widget.labelText) ? Colors.black :const Color.fromRGBO(249, 249, 249, 1),
              ),
            ),
          ),
        );
      }
    );
  }
}