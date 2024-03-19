import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/items/lightning_transaction_details.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:intl/intl.dart';

enum TransactionType { lightning, onChain, }

enum TransactionStatus { failed, pending, confirmed }

enum TransactionDirection { received, sent }


class TransactionItem extends StatefulWidget {
  final TransactionItemData data;
  final BuildContext context;

  const TransactionItem({
    Key? key,
    required this.context,
    required this.data,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    // Use DateFormat for formatting the timestamp
    final String formattedDate = displayTimeAgoFromInt(widget.data.timestamp);
    return Padding(
      padding: const EdgeInsets.only(
          left: AppTheme.cardPadding,
          right: AppTheme.cardPadding,
          bottom: AppTheme.elementSpacing),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppTheme.cardPadding,
        ),
        child: Container(
          height: AppTheme.cardPadding * 3,
          color: lighten(Theme.of(context).colorScheme.background, 10),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: AppTheme.elementSpacing * 1, right: AppTheme.elementSpacing * 1.25,
                    top: AppTheme.elementSpacing * 1, bottom: AppTheme.elementSpacing * 1),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Avatar()),
                      const SizedBox(width: AppTheme.elementSpacing * 0.75),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: AppTheme.cardPadding * 5,
                                child: Text(
                                  widget.data.receiver.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(widget.context).textTheme.titleSmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppTheme.elementSpacing / 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   width: AppTheme.cardPadding * 3,
                              //   child: Text(
                              //     widget.receiver,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: Theme.of(widget.context).textTheme.bodySmall,
                              //   ),
                              // ),
                              Text(
                                formattedDate,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(widget.context).textTheme.bodyMedium,
                              ),

                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.data.amount,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: widget.data.direction == TransactionDirection.received
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing / 3,
                                vertical: AppTheme.elementSpacing / 15),
                            child: Row(
                              children: [
                                //only for received transactions
                                Icon(
                                     Icons.circle,
                                  color: widget.data.status == TransactionStatus.confirmed
                                       ? AppTheme.successColor : widget.data.status == TransactionStatus.pending ? AppTheme.colorBitcoin
                                      : AppTheme.errorColor,
                                  size: AppTheme.cardPadding * 0.75,
                                ),
                                SizedBox(width: AppTheme.elementSpacing / 2,),
                                Image.asset(
                                  widget.data.type == TransactionType.onChain ? "assets/images/bitcoin.png" : "assets/images/lightning.png",
                                  width: AppTheme.cardPadding * 0.75,
                                  height: AppTheme.cardPadding * 0.75,
                                  fit: BoxFit.contain,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if(widget.data.type == TransactionType.lightning) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              LightningTransactionDetails(data: widget.data,)));
                    } else {

                    }
                    },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
