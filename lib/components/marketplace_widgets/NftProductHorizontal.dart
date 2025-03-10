import 'package:bitnet/backbone/helper/theme/theme.dart';
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
        margin: widget.columnMargin ? EdgeInsets.symmetric(horizontal: 8.w) : EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w / 2),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Asset image - fixed square dimensions and centered
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
                child: Container(
                  height: 60.w,
                  width: 60.w,
                  child: Image.asset(
                    widget.nftImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Spacing between image and text
              SizedBox(width: 15.w),
              
              // Text content column
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NFT name
                    Text(
                      widget.nftMainName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.light 
                          ? Colors.black 
                          : const Color.fromRGBO(249, 249, 249, 1),
                      ),
                    ),
                    
                    SizedBox(height: 5.h),
                    
                    // Crypto price
                    GlassContainer(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              widget.cryptoImage,
                              height: 12.w,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              widget.cryptoText,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).brightness == Brightness.light 
                                  ? Colors.black 
                                  : const Color.fromRGBO(255, 255, 255, 0.7),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Delete button if needed
              if (widget.onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: widget.onDelete,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                )
            ],
          ),
        ),
      ),
    );
  }
}