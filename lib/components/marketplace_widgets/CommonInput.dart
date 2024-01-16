
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonInput extends StatelessWidget {
  final placeholder;
  final keyboardType;
  final obscureText;

  const CommonInput({Key? key, this.placeholder, this.keyboardType, this.obscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      child: TextFormField(
        cursorColor: const Color.fromRGBO(255, 255, 255, 0.5),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(255, 255, 255, 0.5),
          ),
          filled: true,
          fillColor: const Color.fromRGBO(24, 31, 39, 1),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.sp,
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.sp,
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.sp,
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.sp,
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.sp,
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
