
import 'dart:ui';
import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;

class LogoutModal extends StatelessWidget {
  const LogoutModal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 91.w,
                child: Image.asset(
                  modalShap1,
                  width: 89.w,
                  height: 113.w,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 49.h,
                right: 0,
                child: Image.asset(
                  modalShap2,
                  width: 77.w,
                  height: 101.w,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 0,
                bottom: -4.h,
                child: Image.asset(
                  modalShap3,
                  width: 138.w,
                  height: 60.w,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: -103.h,
                right: 0,
                child: Image.asset(
                  modalShap4,
                  width: 136.w,
                  height: 133.w,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 20.w, bottom: 54.w, right: 20.w, left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30.h),
                      child: Text(
                        'Are You\nSure?',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30.h),
                      child: Text(
                        'you want to logout\nyour account?',
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 8.w),
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                primary: const Color.fromRGBO(24, 31, 39, 1),
                                backgroundColor:
                                    const Color.fromRGBO(255, 255, 255, 0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                side: BorderSide(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.1),
                                  style: BorderStyle.solid,
                                  width: 2.w,
                                ),
                              ),
                              child: Container(
                                width: size.width,
                                padding: EdgeInsets.all(12.w),
                                child: Text(
                                  'Cancel',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 8.w),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                  context,
                                  route.kInitialRoute
                                );
                              },
                              style: TextButton.styleFrom(
                                primary: const Color.fromRGBO(24, 31, 39, 1),
                                backgroundColor:
                                    const Color.fromRGBO(97, 90, 232, 1),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.r),
                                  ),
                                ),
                              ),
                              child: Container(
                                width: size.width,
                                padding: EdgeInsets.all(12.w),
                                child: Text(
                                  'Logout',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
