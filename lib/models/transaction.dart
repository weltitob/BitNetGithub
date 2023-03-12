import 'package:intl/intl.dart';

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