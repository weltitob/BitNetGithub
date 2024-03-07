import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBtn extends StatelessWidget {
  final text;
  final onPress;
  final hasBackPress;
  final hasMargin;
  final hasOnPress;
  final bgColor;
  final hasBgColor;
  final hasTextColor;
  final textColor;

  const CommonBtn(
      {Key? key,
      this.text,
      this.onPress,
      this.hasBackPress = false,
      this.hasMargin = false,
      this.hasOnPress = true,
      this.hasBgColor = false,
      this.hasTextColor = false,
      this.bgColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: hasMargin ? EdgeInsets.only(bottom: 12.h) : EdgeInsets.zero,
      child: TextButton(
        onPressed: () {
          hasOnPress ? Navigator.pushNamed(context, onPress) : null;
          hasBackPress ? Navigator.pop(context) : null;
        },
        style: TextButton.styleFrom(
          backgroundColor:
              hasBgColor ? bgColor : const Color.fromRGBO(97, 90, 232, 1),
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
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.w500,
              color: hasTextColor ? textColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
