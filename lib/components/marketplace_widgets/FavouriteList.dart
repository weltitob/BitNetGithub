import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteList extends StatefulWidget {
  final nftImage;
  final cryptoImage;
  final nftName;
  final cryptoText;
  final nftMainName;

  const FavouriteList(
      {Key? key,
      required this.nftImage,
      required this.nftName,
      required this.cryptoImage,
      required this.cryptoText,
      required this.nftMainName})
      : super(key: key);

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  bool likeNft = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: 224.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              child: Image.asset(
                widget.nftImage,
                width: size.width,
                height: 134.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                padding: EdgeInsets.only(
                    top: 5.h, bottom: 4.h, right: 10.w, left: 10.w),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 6.w),
                      child: Image.asset(
                        widget.cryptoImage,
                        height: 12.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      widget.cryptoText,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    likeNft = !likeNft;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  padding: EdgeInsets.all(6.w),
                  width: 24.w,
                  height: 24.w,
                  child: Image.asset(
                    likeNft ? activeHeartIcon : unActiveHeartIcon,
                    width: 12.w,
                    height: 12.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 7.h),
            child: Text(
              widget.nftMainName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(249, 249, 249, 1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            child: Text(
              widget.nftName,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(255, 255, 255, 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
