import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CollectionHeader extends StatefulWidget {
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
  State<CollectionHeader> createState() => _CollectionHeaderState();
}

class _CollectionHeaderState extends State<CollectionHeader>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(
          top: AppTheme.cardPadding.h / 2, bottom: AppTheme.cardPadding.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: widget.size.width,
                height: 260.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 0.h),
                padding: EdgeInsets.symmetric(horizontal: 0.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    nftImage5,
                    width: widget.size.width,
                    height: 240.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Custom Outline

              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: widget.size.width,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withAlpha(200),
                              blurRadius: 1,
                              spreadRadius: 4,
                            )
                          ]),
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
            widget.name != null ? widget.name! : L10n.of(context)!.unknown,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(
            'Inscriptions #${widget.inscriptions[0]}-${widget.inscriptions[widget.inscriptions.length - 1]}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
