import 'package:bitnet/backbone/helper/correctencodingerrors.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionBuilder extends StatelessWidget {
  final String description;

  const DescriptionBuilder({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonHeading(
      headingText: 'About',
      hasButton: false,
      collapseBtn: true,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                correctEncoding(description),
                textAlign: TextAlign.start,
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
