import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostView extends StatefulWidget {
  final nftImg;
  final nftName;
  final nftPrice;

  const MostView(
      {Key? key,
      required this.nftImg,
      required this.nftName,
      required this.nftPrice})
      : super(key: key);

  @override
  State<MostView> createState() => _MostViewState();
}

class _MostViewState extends State<MostView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Image.asset(
            widget.nftImg,
            width: 44.w,
            height: 44.h,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.nftName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  widget.nftPrice,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
