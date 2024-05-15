import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PillLabel extends StatefulWidget {
  final labelText;

  const PillLabel({Key? key, required this.labelText}) : super(key: key);

  @override
  State<PillLabel> createState() => _PillLabelState();
}

class _PillLabelState extends State<PillLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      padding: EdgeInsets.only(
        top: 5.w,
        bottom: 4.w,
        left: 10.w,
        right: 10.w,
      ),
      child: Text(
        widget.labelText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
