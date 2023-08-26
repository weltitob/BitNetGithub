import 'package:BitNet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:BitNet/backbone/cloudfunctions/gettransactions.dart';
import 'package:BitNet/models/transaction.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/models/user/userwallet.dart';
import 'package:provider/provider.dart';

class TransactionItem extends StatefulWidget {
  final BitcoinTransaction transaction;
  final BuildContext context;
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.context,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    bool _hasReceived =
        widget.transaction.transactionDirection == "received" ? true : false;
    bool _isConfirmed =
        widget.transaction.transactionStatus == "confirmed" ? true : false;
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
          color: lighten(Theme.of(context).backgroundColor, 10),
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
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              AppTheme.elementSpacing * 1.5),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0, 0.075, 0.925, 1],
                              colors: _hasReceived
                                  ? [
                                      Color(0x99FFFFFF),
                                      AppTheme.colorPrimaryGradient,
                                      AppTheme.colorBitcoin,
                                      Color(0x99FFFFFF),
                                    ]
                                  : [
                                      Color(0x99FFFFFF),
                                      Color(0xFF7127B7),
                                      Color(0xFF522F77),
                                      Color(0x99FFFFFF),
                                    ]),
                        ),
                        child: Container(
                          width: AppTheme.cardPadding * 1.8,
                          height: AppTheme.cardPadding * 1.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppTheme.elementSpacing * 1.5),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: _hasReceived
                                    ? [
                                        AppTheme.colorBitcoin,
                                        AppTheme.colorPrimaryGradient,
                                      ]
                                    : [
                                        Color(0xFF522F77),
                                        Color(0xFF7127B7),
                                      ]),
                          ),
                          child: Icon(
                            size: AppTheme.cardPadding * 1.75,
                            _hasReceived
                                ? Icons.arrow_downward_rounded
                                : Icons.arrow_upward_rounded,
                            color: AppTheme.white90,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.elementSpacing),
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
                                  _hasReceived ?
                                  widget.transaction.transactionSender.toString()
                                      : widget.transaction.transactionReceiver,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                  Theme.of(widget.context).textTheme.titleSmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppTheme.elementSpacing / 4,),
                          Row(
                            children: [
                              Text(
                                widget.transaction.dateFormatted,
                                style: Theme.of(widget.context).textTheme.bodySmall,
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
                            widget.transaction.amountString,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: _hasReceived
                                        ? AppTheme.white90
                                        : AppTheme.white90),
                          ),
                          SizedBox(height: AppTheme.elementSpacing / 4,),
                          GlassContainer(
                            borderThickness: 1.5, // remove border if not active
                            blur: 50,
                            opacity: 0.1,
                            borderRadius: AppTheme.cardRadiusMid,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.elementSpacing / 3,
                                  vertical: AppTheme.elementSpacing / 15),
                              child: Row(
                                children: [
                                  Icon(
                                    _isConfirmed
                                        ? Icons.check_rounded
                                        : Icons.refresh_rounded,
                                    color: _isConfirmed
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor,
                                    size: AppTheme.elementSpacing,
                                  ),
                                  SizedBox(width: AppTheme.elementSpacing / 4),
                                  Text(
                                    _isConfirmed ? "erhalten" : "ausstehend ",
                                    style: _isConfirmed
                                        ? Theme.of(widget.context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: AppTheme.successColor)
                                        : Theme.of(widget.context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: AppTheme.errorColor),
                                  ),
                                ],
                              ),
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
                  onTap: () => print("Transaction tapped"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
