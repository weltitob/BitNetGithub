import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/PillLabel.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class BitNetFilterPillList extends StatefulWidget {
  final headingText;
  final listDataText;
  const BitNetFilterPillList({Key? key, this.headingText, this.listDataText})
      : super(key: key);
  @override
  State<BitNetFilterPillList> createState() => _BitNetFilterPillListState();
}

class _BitNetFilterPillListState extends State<BitNetFilterPillList> {
  bool openStatus = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonHeading(
          headingText: widget.headingText,
          hasButton: false,
          collapseBtn: true,
          child: Container(
            width: size.width,
            margin: EdgeInsets.only(bottom: 30.h),
            child: Wrap(
              spacing: 15.w,
              runSpacing: 15.w,
              children: List.generate(widget.listDataText.length, (index) {
                return PillLabel(
                  labelText: widget.listDataText[index].labelText,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
