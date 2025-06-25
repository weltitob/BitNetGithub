import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionList extends StatefulWidget {
  final collectionName;
  final collectionImg;

  const CollectionList(
      {Key? key, required this.collectionName, required this.collectionImg})
      : super(key: key);

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  bool likeNft = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              widget.collectionImg,
              width: 28.w,
              height: 28.w,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Text(
              widget.collectionName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
