import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/mempool_models/bitcoin_data.dart';
import 'package:bitnet/models/mempool_models/mempool_model.dart';
import 'package:bitnet/pages/secondpages/mempool/colorhelper.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DataWidget extends StatefulWidget {
  final bool isAccepted;

  // For accepted blocks
  final BlockData? blockData;
  final size;
  final time;

  // For not accepted yet
  final MempoolBlocks? mempoolBlocks;
  final String? mins;

  // For both
  final int? index;
  final String? txId;
  final bool singleTx;
  final bool hasUserTxs;
  // Constructor for accepted blocks
  const DataWidget.accepted({
    Key? key,
    required this.blockData,
    required this.size,
    required this.time,
    this.index,
    this.txId,
    required this.singleTx,
    required this.hasUserTxs,
  })  : isAccepted = true,
        mempoolBlocks = null,
        mins = null,
        super(key: key);

  // Constructor for not accepted blocks
  const DataWidget.notAccepted({
    Key? key,
    required this.mempoolBlocks,
    required this.mins,
    this.index,
    this.txId,
    required this.hasUserTxs,
    required this.singleTx,
  })  : isAccepted = false,
        blockData = null,
        size = null,
        time = null,
        super(key: key);

  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  int? i;

  @override
  Widget build(BuildContext context) {
    i = widget.index;
    final controller = Get.put(HomeController());

    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // widget.isAccepted
          //     ? Padding(
          //         padding: EdgeInsets.only(left: AppTheme.cardPadding / 2.w),
          //         child: Text(
          //           widget.blockData!.height.toString(),
          //           style: Theme.of(context)
          //               .textTheme
          //               .titleMedium!
          //               .copyWith(color: AppTheme.colorBitcoin),
          //         ),
          //       )
          //     : Text(
          //         "",
          //         style: Theme.of(context)
          //             .textTheme
          //             .titleMedium!
          //             .copyWith(color: Colors.transparent),
          //       ),
          // const SizedBox(
          //   height: AppTheme.elementSpacing,
          // ),
          Stack(
            children: [
              Container(
                height: AppTheme.cardPadding * 5.75.w,
                width: AppTheme.cardPadding *
                    5.75.w, //MediaQuery.of(context).size.height * 0.2,
                margin: widget.isAccepted
                    ? EdgeInsets.only(left: AppTheme.cardPadding.w)
                    : EdgeInsets.only(
                        left: AppTheme.cardPadding / 2.5.w,
                        right: AppTheme.cardPadding / 2.5.w),
                padding: const EdgeInsets.all(AppTheme.elementSpacing),
                decoration: getDecoration(
                  widget.isAccepted
                      ? widget.blockData?.extras?.medianFee ?? 0
                      : widget.mempoolBlocks?.medianFee ?? 0,
                  widget.isAccepted,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.isAccepted
                        ? Text(
                            widget.blockData!.height
                                .toString(), // '${widget.size.toStringAsFixed(2)} MB',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp),
                          )
                        : Text(
                            "Pending", // '${(widget.mempoolBlocks!.blockSize! / 1000000).toStringAsFixed(2)} MB',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(height: AppTheme.elementSpacing * 1.h),
                    widget.isAccepted
                        ? Text(
                            '${L10n.of(context)!.fee}: ~' +
                                '\$' +
                                '${(widget.blockData!.extras!.medianFee! * 140 / 100000000 * controller.currentUSD.value).toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.white),
                          )
                        : Text(
                            '${L10n.of(context)!.fee}: ~' +
                                '\$' +
                                '${(widget.mempoolBlocks!.medianFee! * 140 / 100000000 * controller.currentUSD.value).toStringAsFixed(2)}',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),

                    // SizedBox(height: AppTheme.elementSpacing * 0.4.h),
                    // widget.isAccepted
                    //     ? FittedBox(
                    //         child: Text(
                    //           '${formatPrice(widget.blockData?.txCount)} transactions',
                    //           maxLines: 1,
                    //           style:
                    //               TextStyle(fontSize: 14.sp, color: Colors.white),
                    //         ),
                    //       )
                    //     : FittedBox(
                    //         child: Text(
                    //           '${formatPrice(widget.mempoolBlocks?.nTx)} transactions',
                    //           maxLines: 1,
                    //           style:
                    //               TextStyle(fontSize: 14.sp, color: Colors.white),
                    //           overflow: TextOverflow.ellipsis,
                    //         ),
                    //       ),
                    SizedBox(height: AppTheme.elementSpacing * 0.3.h),
                    widget.isAccepted
                        ? FittedBox(
                            child: Text(
                              '${widget.time}',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                          )
                        : FittedBox(
                            child: Text(
                              'In ~${widget.mins} ${L10n.of(context)!.minutesTx}',
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.white),
                            ),
                          ),
                  ],
                ),
              ),
              if (widget.hasUserTxs)
                Positioned(
                  bottom: 0,
                  left: 40,
                  child: Container(
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.colorBitcoin,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: const Center(
                      child: Text(
                        'has Tx',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          i! == 1 && widget.txId == widget.blockData?.id
              ? Container(
                  margin: widget.isAccepted
                      ? const EdgeInsets.only(left: AppTheme.cardPadding)
                      : const EdgeInsets.only(left: 0),
                  child: const Icon(Icons.arrow_drop_down_rounded,
                      size: AppTheme.cardPadding * 2),
                )
              : SizedBox(
                  height: AppTheme.cardPadding * 1.h,
                ),
        ],
      ),
    );
  }
}
