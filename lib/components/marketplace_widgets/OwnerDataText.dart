
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerDataText extends StatelessWidget {
  final ownerDataTitle;
  final ownerDataText;
  final ownerDataImg;
  final hasText;
  final hasImage;
  const OwnerDataText(
      {Key? key,
      this.ownerDataText = '',
      this.ownerDataTitle,
      this.ownerDataImg,
      this.hasText = false,
      this.hasImage = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          hasText
              ? Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  child: Text(
                    ownerDataText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              : Container(),
          hasImage
              ? Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    ownerDataImg,
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.contain,
                    color: AppTheme.black100,
                  ),
                )
              : Container(),
          Text(
            ownerDataTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
