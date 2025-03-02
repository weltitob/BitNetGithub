import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NftProductHorizontal extends StatefulWidget {
  final nftImage;
  final cryptoImage;
  final nftName;
  final cryptoText;
  final nftMainName;
  final columnMargin;
  final rank;
  final Function()? onDelete;

  const NftProductHorizontal(
      {Key? key,
      required this.nftImage,
      required this.nftName,
      required this.cryptoImage,
      required this.cryptoText,
      required this.nftMainName,
      this.columnMargin,
      required this.rank,
      this.onDelete})
      : super(key: key);

  @override
  State<NftProductHorizontal> createState() => _NftProductHorizontalState();
}

class _NftProductHorizontalState extends State<NftProductHorizontal> {
  bool likeNft = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: GlassContainer(
        width: 300.w,
        margin: widget.columnMargin ? EdgeInsets.symmetric(horizontal: 8.w) : EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.w, right: 25.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),
                    ),
                    child: Image.asset(
                      widget.nftImage,
                      height: 60.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 7.h),
                    child: Text(
                      widget.nftMainName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.light ? Colors.black : const Color.fromRGBO(249, 249, 249, 1),
                      ),
                    ),
                  ),
                  GlassContainer(
                    child: Container(
                      padding: EdgeInsets.only(top: 5.w, bottom: 4.w, right: 10.w, left: 10.w),
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
                              color: Theme.of(context).brightness == Brightness.light ? Colors.black : const Color.fromRGBO(255, 255, 255, 0.7),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (widget.onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: widget.onDelete,
                )
            ],
          ),
        ),
      ),
    );
  }
}
