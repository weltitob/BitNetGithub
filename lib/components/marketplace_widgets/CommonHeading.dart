import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonHeading extends StatefulWidget {
  final headingText;
  final hasButton;
  final onPress;
  final collapseBtn;
  final child;
  final isChild;
  final isNormalChild;

  const CommonHeading(
      {Key? key,
      this.headingText = '',
      required this.hasButton,
      this.onPress,
      this.collapseBtn = false,
      this.child,
      this.isChild,
      this.isNormalChild = false})
      : super(key: key);

  @override
  State<CommonHeading> createState() => _CommonHeadingState();
}

class _CommonHeadingState extends State<CommonHeading> {
  bool openCloseCollapse = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: widget.collapseBtn
              ? EdgeInsets.all(0.w)
              : EdgeInsets.symmetric(horizontal: 20.w),
          margin: EdgeInsets.only(bottom: 15.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.headingText,
                  style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(
                        fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              widget.hasButton
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, widget.onPress);
                      },
                      child: Container(
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
                    )
                  : Container(),
              widget.collapseBtn
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          openCloseCollapse = !openCloseCollapse;
                        });
                      },
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: const Color.fromRGBO(255, 255, 255, 0.1),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: openCloseCollapse ? 8.h : 7.h,
                          horizontal: openCloseCollapse ? 7.w : 8.w,
                        ),
                        child: Image.asset(
                          openCloseCollapse
                              ? bottomArrowIcon
                              : rightArrowIcon,
                          width: openCloseCollapse ? 5.w : 10.w,
                          height: openCloseCollapse ? 10.h : 5.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        widget.collapseBtn ? openCloseCollapse ? widget.child : Container() : Container(),
        widget.isNormalChild ? widget.isChild : Container()
      ],
    );
  }
}
