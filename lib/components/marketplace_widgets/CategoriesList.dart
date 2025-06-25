import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesList extends StatelessWidget {
  final String categoriesText;

  const CategoriesList({Key? key, this.categoriesText = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route.kCategoriesDetailScreenRoute);
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16.h),
        margin: EdgeInsets.only(bottom: 15.h),
        width: size.width,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(right: 15.w),
              child: Text(
                categoriesText,
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: const Color.fromRGBO(255, 255, 255, 0.1),
              ),
              padding: EdgeInsets.only(
                  top: 7.h, bottom: 7.h, right: 8.w, left: 10.w),
              child: Image.asset(
                rightArrowIcon,
                width: 10.w,
                height: 5.h,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
