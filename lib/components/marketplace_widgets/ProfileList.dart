
import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileList extends StatefulWidget {
  final text;
  final icon;
  final hasIcon;
  final hasSwitch;
  const ProfileList(
      {Key? key,
      this.text,
      this.icon,
      this.hasIcon = false,
      this.hasSwitch = false})
      : super(key: key);

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  bool clickSwitch = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 15.w),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          widget.hasIcon
          ? Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: const Color.fromRGBO(255, 255, 255, 0.1),
              ),
              padding: EdgeInsets.all(6.w),
              child: Image.asset(
                widget.icon,
                width: 12.w,
                height: 12.w,
                fit: BoxFit.contain,
              ),
            )
          : Container(),
          widget.hasSwitch ? GestureDetector(
            onTap: () {
              setState(() {
                clickSwitch = !clickSwitch;
              });
            },
            child: Container(
              width: 20.w,
              height: 20.w,
              color: const Color.fromRGBO(24, 31, 39, 1),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 17.w,
                        height: 7.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment(0.0, 1.0),
                            colors: <Color>[
                              Color.fromRGBO(184, 184, 184, 1),
                              Color.fromRGBO(220, 220, 220, 1)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: clickSwitch ? 10.w : 0,
                    top: 4.5.w,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(2.5, 4.33),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        switchIcon,
                        width: 10.w,
                        height: 10.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
