import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CollectionHeader extends StatelessWidget {
  final Size size;
  final String? name;
  final List<int> inscriptions;

  const CollectionHeader({
    Key? key,
    required this.size,
    required this.name,
    required this.inscriptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: AppTheme.cardPadding.h / 4, bottom: AppTheme.cardPadding.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 0.h),
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border(
                        bottom: BorderSide(color: primaryColor, width: 5))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    nftImage5,
                    width: size.width,
                    height: 240.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: (size.width - 100.w) / 2,
                child: Container(
                  color: primaryColor,
                  width: 100.w,
                  height: 50.w,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: size.width,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 5),
                          borderRadius: BorderRadius.circular(100.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.asset(
                          user1Image,
                          width: 100.w,
                          height: 100.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            name != null ? name! : L10n.of(context)!.unknown,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(
            'Inscriptions #${inscriptions[0]}-${inscriptions[inscriptions.length - 1]}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
