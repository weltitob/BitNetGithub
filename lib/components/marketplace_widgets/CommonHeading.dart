import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CommonHeading extends StatefulWidget {
  final headingText;
  final hasButton;
  final onPress;
  final collapseBtn;
  final child;
  final isChild;
  final isNormalChild;
  bool isCollapsed;
  final IconData customButtonIcon;

  CommonHeading({
    Key? key,
    this.headingText = '',
    required this.hasButton,
    this.onPress,
    this.customButtonIcon = Icons.arrow_forward_ios_rounded,
    this.collapseBtn = false,
    this.child,
    this.isChild,
    this.isNormalChild = false,
    this.isCollapsed = true,
  }) : super(key: key);

  @override
  State<CommonHeading> createState() => _CommonHeadingState();
}

class _CommonHeadingState extends State<CommonHeading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppTheme.elementSpacing,
        ),
        Container(
          color: Colors.transparent,
          padding: widget.collapseBtn
              ? EdgeInsets.all(0.w)
              : EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
          margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.headingText,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              widget.hasButton
                  ? RoundedButtonWidget(
                      size: AppTheme.cardPadding * 1.25,
                      buttonType: ButtonType.transparent,
                      iconColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      onTap: () {
                        if (widget.onPress is String) {
                          context.pushNamed(widget.onPress);
                        } else if (widget.onPress is Function) {
                          widget.onPress();
                        }
                      },
                      iconData: widget.customButtonIcon,
                    )
                  : Container(),
              widget.collapseBtn
                  ? RoundedButtonWidget(
                      size: AppTheme.cardPadding * 1.25,
                      buttonType: ButtonType.transparent,
                      iconData: widget.isCollapsed
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      onTap: () {
                        setState(() {
                          widget.isCollapsed = !widget.isCollapsed;
                        });
                      },
                    )
                  // GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             isCollapsed = !isCollapsed;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: 24.w,
                  //           height: 24.w,
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //                 color: Theme.of(context).brightness ==
                  //                         Brightness.light
                  //                     ? AppTheme.black60
                  //                     : AppTheme.white60),
                  //             borderRadius: BorderRadius.circular(100.r),
                  //             color: const Color.fromRGBO(255, 255, 255, 0.1),
                  //           ),
                  //           padding: EdgeInsets.symmetric(
                  //             vertical: isCollapsed ? 8.h : 7.h,
                  //             horizontal: isCollapsed ? 7.w : 8.w,
                  //           ),
                  //           child: Image.asset(
                  //             isCollapsed ? bottomArrowIcon : rightArrowIcon,
                  //             width: isCollapsed ? 5.w : 10.w,
                  //             height: isCollapsed ? 10.h : 5.h,
                  //             fit: BoxFit.contain,
                  //             color:
                  //                 Theme.of(context).brightness == Brightness.light
                  //                     ? AppTheme.black60
                  //                     : AppTheme.white60,
                  //           ),
                  //         ),
                  //       )
                  : Container(),
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.elementSpacing * 0.5,
        ),
        widget.collapseBtn
            ? widget.isCollapsed
                ? widget.child
                : Container()
            : Container(),
        widget.isNormalChild ? widget.isChild : Container()
      ],
    );
  }
}
