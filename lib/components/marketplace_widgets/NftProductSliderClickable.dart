import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;

class NftProductSliderClickable extends StatefulWidget {
  final id;
  final nftImage;
  final cryptoImage;
  final nftName;
  final cryptoText;
  final nftMainName;
  final columnMargin;
  final rank;
  final Function(int)? onTap;
  final Function()? onTapBuy;
  final Function()? onLongTap;
  final selected;

  const NftProductSliderClickable(
      {Key? key,
      required this.id,
      required this.nftImage,
      required this.nftName,
      required this.cryptoImage,
      required this.cryptoText,
      required this.nftMainName,
      this.columnMargin,
      required this.rank,
      required this.selected,
      this.onTap,
      this.onTapBuy,
      this.onLongTap})
      : super(key: key);

  @override
  State<NftProductSliderClickable> createState() => _NftProductSliderState();
}

class _NftProductSliderState extends State<NftProductSliderClickable> {
  bool likeNft = false;

  void onTapHandler() {
    if (widget.onTap == null) return;
    widget.onTap!(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTapHandler,
      onLongPress: widget.onLongTap,
      child: Container(
        width: 224.w,
        padding: EdgeInsets.all(10.w),
        margin: widget.columnMargin
            ? EdgeInsets.symmetric(horizontal: 8.w)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color: widget.selected
                    ? AppTheme.colorBitcoin
                    : Colors.transparent)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140.w,
              child: Stack(children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.w),
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
                Positioned(
                    bottom: 12,
                    right: 6,
                    child: GlassContainer(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Rank - " + widget.rank.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(),
                      ),
                    ))),
              ]),
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
                      top: 5.w, bottom: 4.w, right: 10.w, left: 10.w),
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
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
                      height: 12.w,
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
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    widget.nftName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                LongButtonWidget(
                    customWidth: 7 * 10,
                    customHeight: 7 * 2.5,
                    title: "Buy",
                    titleStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12, color: Colors.white),
                    onTap: widget.onTapBuy)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
