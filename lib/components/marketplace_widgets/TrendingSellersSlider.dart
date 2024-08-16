import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  margin: EdgeInsets.symmetric(horizontal: 8.w),

        child: GlassContainer(
          borderThickness: 0,
          width: 324.w,
          // decoration: BoxDecoration(
          //     border: Border.all(color: AppTheme.black100),
          //     color: const Color.fromRGBO(255, 255, 255, 0.1),
          //     borderRadius: BorderRadius.circular(12.r)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppTheme.cardPadding),
                  topLeft: Radius.circular(AppTheme.cardPadding),
                ),
                child: Image.asset(
                  nftImage,
                  fit: BoxFit.cover,
                  width: size.width,
                  height: 80.w,
                ),
              ),
               Positioned(
                bottom: 4,
                left: 0,
                right: 0,
                 child: Column(
                  mainAxisSize: MainAxisSize.min,
                   children: [
                     ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius:BorderRadius.circular(100.r),
                       child: Image.asset(
                         userImage,
                         width: 48.w,
                         height: 48.w,
                       ),
                     ),
                        Text(
                          nftName,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                   ],
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
