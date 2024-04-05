import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:go_router/go_router.dart';


class TrendingSellersSlider extends StatelessWidget {
  final nftImage;
  final nftName;
  final userImage;

  const TrendingSellersSlider(
      {Key? key, required this.nftImage, required this.nftName, this.userImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        context.goNamed(kCollectionScreenRoute,
        pathParameters: {'collection_id': this.nftName});
      },
      child: Container(
        width: 224.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.1),
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.r),
                topLeft: Radius.circular(12.r),
              ),
              child: Image.asset(
                nftImage,
                fit: BoxFit.cover,
                width: size.width,
                height: 100.w,
              ),
            ),
            Column(
              children: [
                Transform.translate(
                  offset: Offset(0.0, -24.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.asset(
                      userImage,
                      width: 48.w,
                      height: 48.w,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0.0, -14.h),
                  child: Text(
                    nftName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(249, 249, 249, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
