
import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthShape extends StatelessWidget {

final List<Widget> children;
  const AuthShape({Key? key,
  required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return 
    Stack(
      children: [
        Positioned(
          top: -statusBarHeight,
          right: 114.w,
          child: Image.asset(
            modalShap1,
            width: 115.w,
            height: 142.w,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 62.w - statusBarHeight,
          right: 0.w,
          child: Image.asset(
            modalShap2,
            width: 96.w,
            height: 127.w,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 318.h - statusBarHeight,
          left: 0.h,
          child: Image.asset(
            modalShap3,
            width: 173.w,
            height: 76.w,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 337.h - statusBarHeight,
          right: 0.h,
          child: Image.asset(
            modalShap4,
            width: 171.w,
            height: 167.w,
            fit: BoxFit.contain,
          ),
        ),
        ...children
      ],
    );
  }
}
