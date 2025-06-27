import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NftDropSlider extends StatelessWidget {
  final nftImage;
  final nftName;

  const NftDropSlider({Key? key, required this.nftImage, required this.nftName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: 150.w,
        height: 150.w,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.1),
            borderRadius: BorderRadius.circular(14.r)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Stack(
            children: [
              Image.asset(
                nftImage,
                fit: BoxFit.cover,
                width: 150.w,
                height: 150.w,
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 150.w,
                  height: 150.w,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0.0, 1.0),
                      colors: <Color>[
                        Color.fromRGBO(24, 31, 39, 0),
                        Color.fromRGBO(24, 31, 39, 0.25),
                        Color.fromRGBO(24, 31, 39, 0.9)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    nftName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(249, 249, 249, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
