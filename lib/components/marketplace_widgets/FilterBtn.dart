import 'dart:ui';
import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;

class FilterBtn extends StatelessWidget {
  const FilterBtn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20.w,
      bottom: 20.w,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route.kFilterScreenRoute);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
            child: Container(
              padding: EdgeInsets.only(
                  top: 8.h, bottom: 8.h, right: 12.w, left: 12.w),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Image.asset(
                    filterIcon,
                    width: 16.w,
                    height: 16.w,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 7.w),
                    child: Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
