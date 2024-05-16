
import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChaunInfo extends StatelessWidget {
  final chainHeading;
  final chainPeragraph;
  final hasBtn;

  const ChaunInfo(
      {Key? key, this.chainHeading, this.chainPeragraph, this.hasBtn = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 7.h),
            child: Text(
              chainHeading,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
               ),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  chainPeragraph,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                   ),
                ),
              ),
              hasBtn ? GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: chainPeragraph
                    ),
                  );
                },
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 7.w),
                  margin: EdgeInsets.only(left: 19.w),
                  child: Image.asset(
                    paperPlusIcon,
                    width: 10.w,
                    height: 12.h,
                    color: AppTheme.colorSchemeSeed,
                    fit: BoxFit.contain,
                  ),
                ),
              ) : Container(),
            ],
          )
        ],
      ),
    );
  }
}
