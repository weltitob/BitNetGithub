import 'package:intl/intl.dart';

enum TransactionDirection {
  receive,
  send,
}

class Transaction {
  final TransactionDirection transactionDirection;
  final String date;
  final String transactionSender;
  final String transactionReceiver;
  final String amount;

  Transaction({
    required this.transactionDirection,
    required this.date,
    required this.transactionSender,
    required this.transactionReceiver,
    required this.amount,
  });

  String get dateFormatted =>
      DateFormat('dd MMMM yyyy').format(DateFormat('yyyy-MM-dd').parse(date));

  String get amountString {
    final amountSign =
        transactionDirection == TransactionDirection.receive ? '+' : '-';
    return '$amountSign${NumberFormat('#,###.####').format(amount)}';
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionDirection': transactionDirection,
      'date': date,
      'transactionReceiver': transactionReceiver,
      'transactionSender': transactionSender,
      'amount': amount,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionDirection: json['transactionDirection'],
      date: json['date'].toString(),
      transactionReceiver: json['transactionReceiver'].toString(),
      transactionSender: json['transactionSender'].toString(),
      amount: json['amount'].toString(),
    );
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      transactionDirection: map['transactionDirection'],
      date: map['date'].toString(),
      transactionReceiver: map['transactionReceiver'].toString(),
      transactionSender: map['transactionSender'].toString(),
      amount: map['amount'].toString(),
    );
  }

}
