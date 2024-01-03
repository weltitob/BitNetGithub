import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/mempool_models/bitcoin_data.dart';
import 'package:bitnet/models/mempool_models/mempool_model.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
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
                  padding:
                      const EdgeInsets.only(left: AppTheme.cardPadding / 2),
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
            height: AppTheme.cardPadding * 6,
            width: AppTheme.cardPadding *
                6, //MediaQuery.of(context).size.height * 0.2,
            margin: widget.isAccepted
                ? const EdgeInsets.only(left: AppTheme.cardPadding, top: 10)
                : const EdgeInsets.only(
                    top: 10,
                    left: AppTheme.cardPadding / 2,
                    right: AppTheme.cardPadding / 2),
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
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                // const SizedBox(height: 10),
                // Text(
                //   '${widget.blockData.extras!.feeRange!.first.toStringAsFixed(0)} - ${widget.blockData.extras!.feeRange!.last.toStringAsFixed(0)} sat/vB',
                //   style: TextStyle(color: Colors.yellow.shade300),
                // ),
                const SizedBox(height: AppTheme.elementSpacing * 0.5),
                widget.isAccepted
                    ? Text(
                        '${widget.size.toStringAsFixed(2)} MB',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      )
                    : Text(
                        '${(widget.mempoolBlocks!.blockSize! / 1000000).toStringAsFixed(2)} MB',
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                const SizedBox(height: AppTheme.elementSpacing * 0.5),
                widget.isAccepted
                    ? Text(
                        '${formatPrice(widget.blockData?.txCount)} transactions',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      )
                    : Text(
                        '${formatPrice(widget.mempoolBlocks?.nTx)} transactions',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                const SizedBox(height: AppTheme.elementSpacing * 0.5),
                widget.isAccepted
                    ? Text(
                        '${widget.time}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      )
                    : Text(
                        'In ~${widget.mins} minutes',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
              ],
            ),
          ),
          i! == 1 && widget.txId == widget.blockData?.id
              ? Container(
                  margin: widget.isAccepted
                      ? const EdgeInsets.only(left: AppTheme.cardPadding)
                      : const EdgeInsets.only(left: 0),
                  child: const Icon(Icons.arrow_drop_down_rounded,
                      size: AppTheme.cardPadding * 2.5),
                )
              : const SizedBox(
                  height: AppTheme.cardPadding * 1.5,
                ),
        ],
      ),
    );
  }
}
