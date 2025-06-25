import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostView extends StatefulWidget {
  final nftImg;
  final nftName;
  final nftPrice;

  const MostView(
      {Key? key,
      required this.nftImg,
      required this.nftName,
      required this.nftPrice})
      : super(key: key);

  @override
  State<MostView> createState() => _MostViewState();
}

class _MostViewState extends State<MostView> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppTheme.elementSpacing.w,
          vertical: AppTheme.elementSpacing.h * 0.5),
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.cardPadding),
        onTap: () {},
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black26
                        : Colors.grey.withOpacity(0.3),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: Image.asset(
                  widget.nftImg,
                  width: 48.w,
                  height: 48.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nftName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    widget.nftPrice,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color:
                              isDarkMode ? AppTheme.white90 : AppTheme.black80,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: isDarkMode ? AppTheme.white60 : AppTheme.black60,
            ),
          ],
        ),
      ),
    );
  }
}
