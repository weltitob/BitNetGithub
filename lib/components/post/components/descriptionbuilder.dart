import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DescriptionBuilder extends StatelessWidget {
  final String descirption;
  const DescriptionBuilder({
    Key? key,
    required this.descirption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonHeading(
      headingText: 'About',
      hasButton: false,
      collapseBtn: true,
      child: Container(
        margin: EdgeInsets.only(bottom: AppTheme.cardPadding.h),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
              child: Text(
                descirption,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

