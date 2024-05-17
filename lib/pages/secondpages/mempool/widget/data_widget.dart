import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/mempool_models/bitcoin_data.dart';
import 'package:bitnet/models/mempool_models/mempool_model.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:bitnet/pages/secondpages/mempool/colorhelper.dart';

class DataWidget extends StatefulWidget {
  final bool isAccepted;

  // For accepted blocks
  final BlockData? blockData;
  var size;
  var time;

  // For not accepted yet
  final MempoolBlocks? mempoolBlocks;
  final String? mins;

  // For both
  final int? index;
  final String? txId;
  final bool singleTx;

  // Constructor for accepted blocks
  DataWidget.accepted({
    Key? key,
    required this.blockData,
    required this.size,
    required this.time,
    this.index,
    this.txId,
    required this.singleTx,
  })  : isAccepted = true,
        mempoolBlocks = null,
        mins = null,
        super(key: key);

  // Constructor for not accepted blocks
  DataWidget.notAccepted({
    Key? key,
    required this.mempoolBlocks,
    required this.mins,
    this.index,
    this.txId,
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
          widget.isAccepted
              ? Padding(
                  padding: EdgeInsets.only(left: AppTheme.cardPadding / 2.w),
                  child: Text(
                    widget.blockData!.height.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppTheme.colorBitcoin),
                  ),
                )
              : Text(
                  "",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.transparent),
                ),
          const SizedBox(height: AppTheme.elementSpacing),
          Container(
            height: AppTheme.cardPadding * 5.h,
            width: AppTheme.cardPadding *
                6.w, //MediaQuery.of(context).size.height * 0.2,
            margin: widget.isAccepted
                ? EdgeInsets.only(left: AppTheme.cardPadding.w, top: 10.h)
                : EdgeInsets.only(
                    top: 10.h,
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
                        'Fee: ~' +
                            '\$' +
                            '${(widget.blockData!.extras!.medianFee! * 140 / 100000000 * controller.currentUSD.value).toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      )
                    : Text(
                        //controller.mempoolBlocks[controller.indexShowBlock.value].medianFee! * 140) / 100000000) * controller.currentUSD.value).toStringAsFixed(2)}
                        'Fee: ~' +
                            '\$' +
                            '${(widget.mempoolBlocks!.medianFee! * 140 / 100000000 * controller.currentUSD.value).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      ),
                SizedBox(height: AppTheme.elementSpacing * 0.35.h),
                widget.isAccepted
                    ? Text(
                        '${widget.size.toStringAsFixed(2)} MB',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp),
                      )
                    : Text(
                        '${(widget.mempoolBlocks!.blockSize! / 1000000).toStringAsFixed(2)} MB',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                SizedBox(height: AppTheme.elementSpacing * 0.4.h),
                widget.isAccepted
                    ? FittedBox(
                      child: Text(
                          '${formatPrice(widget.blockData?.txCount)} transactions',
                          maxLines: 1,
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                    )
                    : FittedBox(
                      child: Text(
                          '${formatPrice(widget.mempoolBlocks?.nTx)} transactions',
                          maxLines: 1,
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ),
                SizedBox(height: AppTheme.elementSpacing * 0.4.h),
                widget.isAccepted
                    ? Text(
                        '${widget.time}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                      )
                    : FittedBox(
                      child: Text(
                          'In ~${widget.mins} minutes',
                          maxLines: 1,
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                    ),
              ],
            ),
          ),
          i! == 1 && widget.txId == widget.blockData?.id
              ? Container(
                  margin: widget.isAccepted
                      ? const EdgeInsets.only(left: AppTheme.cardPadding)
                      : const EdgeInsets.only(left: 0),
                  child: Icon(Icons.arrow_drop_down_rounded,
                      size: AppTheme.cardPadding * 2.h),
                )
              : SizedBox(
                  height: AppTheme.cardPadding * 1.h,
                ),
        ],
      ),
    );
  }
}
