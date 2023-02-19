import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexus_wallet/theme.dart';

enum TransactionDirection {
  receive,
  send,
}

class Transaction {
  final TransactionDirection tradeDirection;
  final String date;
  final String transactionSender;
  final String transactionReceiver;
  final double amount;

  Transaction({
    required this.tradeDirection,
    required this.date,
    required this.transactionSender,
    required this.transactionReceiver,
    required this.amount,
  });

  String get dateFormatted =>
      DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd').parse(date));

  String get amountString {
    final amountSign =
        tradeDirection == TransactionDirection.receive ? '+' : '-';
    return '$amountSign${NumberFormat('#,###.####').format(amount)}';
  }
}

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
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
        widget.transaction.tradeDirection == TransactionDirection.receive
            ? true
            : false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.cardPadding,),
        child: Container(
          height: AppTheme.cardPadding * 3,
          color: lighten(Theme.of(context).backgroundColor, 10),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing,
                    vertical: AppTheme.elementSpacing * 1.25),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppTheme.elementSpacing * 1.25),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 0.075, 0.925, 1],
                          colors: _hasReceived ?
                          [
                            Color(0x99FFFFFF),
                            AppTheme.colorPrimaryGradient,
                            AppTheme.colorBitcoin,
                            Color(0x99FFFFFF),
                            ] :
                          [
                            Color(0x99FFFFFF),
                            Color(0xFF7127B7),
                            Color(0xFF522F77),
                            Color(0x99FFFFFF),
                          ]
                        ),
                      ),
                      child: Container(
                        width: AppTheme.cardPadding * 1.5,
                        height: AppTheme.cardPadding * 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppTheme.elementSpacing * 1.25),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: _hasReceived ? [
                                AppTheme.colorBitcoin,
                                AppTheme.colorPrimaryGradient,
                              ] :
                              [
                                Color(0xFF522F77),
                                Color(0xFF7127B7),
                              ]
                          ),
                        ),
                        child: Icon(
                          size: AppTheme.cardPadding * 1.5,
                          _hasReceived
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward,
                          color: AppTheme.white90,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.elementSpacing),
                    title(),
                    const Spacer(),
                    Text(
                      widget.transaction.amountString,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: _hasReceived
                              ? AppTheme.colorBitcoin
                              : AppTheme.white90),
                    ),
                  ],
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

  Widget title() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.transaction.date.toString(),
          style: Theme.of(widget.context).textTheme.bodySmall,
        ),
        Text(widget.transaction.transactionSender.toString(),
            style: Theme.of(widget.context).textTheme.bodyMedium),
      ],
    );
  }
}
