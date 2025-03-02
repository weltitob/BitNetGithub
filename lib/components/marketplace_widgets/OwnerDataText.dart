import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerDataText extends StatelessWidget {
  final String ownerDataTitle;
  final String? ownerDataText;
  final String ownerDataImg;
  final bool hasText;
  final bool hasImage;
  final VoidCallback? onTap;
  
  const OwnerDataText({
    Key? key,
    required this.ownerDataTitle,
    required this.ownerDataImg,
    this.ownerDataText = '',
    this.hasText = false,
    this.hasImage = false,
    this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w, vertical: AppTheme.elementSpacing.h * 0.75),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            hasImage
                ? Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: Image.asset(
                      ownerDataImg,
                      width: 20.w,
                      height: 20.w,
                      fit: BoxFit.contain,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                : Container(),
            Text(
              ownerDataTitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (onTap != null)
              Container(
                margin: EdgeInsets.only(left: 4.w),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}