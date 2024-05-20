import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PillLabel extends StatefulWidget {
  final labelText;

  const PillLabel({Key? key, required this.labelText}) : super(key: key);

  @override
  State<PillLabel> createState() => _PillLabelState();
}

class _PillLabelState extends State<PillLabel> {
  final controller = Get.put(WalletFilterController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.toggleFilter(widget.labelText);
        },
        child: controller.selectedFilters.contains(widget.labelText)
            ? GlassContainer(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing.w * 0.5,
                      vertical: AppTheme.elementSpacing.h * 0.5),
                  child: Text(
                    widget.labelText,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing.w * 0.5 + 1.5,
                    vertical: AppTheme.elementSpacing.h * 0.5 + 1.5),
                child: Text(
                  widget.labelText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
      );
    });
  }
}
