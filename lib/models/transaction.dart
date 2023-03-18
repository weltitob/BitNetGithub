import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nexus_wallet/backbone/helpers.dart';


class BitcoinTransaction {
  final String transactionDirection;
  final String date;
  final String transactionSender;
  final String transactionReceiver;
  final String amount;

  BitcoinTransaction({
    required this.transactionDirection,
    required this.date,
    required this.transactionSender,
    required this.transactionReceiver,
    required this.amount,
  });

  String get dateFormatted =>
      displayTimeAgoFromTimestamp(date);

  String get amountString {
    final amountSign =
        transactionDirection == "received" ? '+' : '-';
    return '$amountSign${double.parse(amount)}';
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

  factory BitcoinTransaction.fromJson(Map<String, dynamic> json) {
    return BitcoinTransaction(
      transactionDirection: json['transactionDirection'].toString(),
      date: json['date'].toString(),
      transactionReceiver: json['transactionReceiver'].toString(),
      transactionSender: json['transactionSender'].toString(),
      amount: json['amount'].toString(),
    );
  }

  factory BitcoinTransaction.fromMap(Map<String, dynamic> map) {
    return BitcoinTransaction(
      transactionDirection: map['transactionDirection'],
      date: map['date'].toString(),
      transactionReceiver: map['transactionReceiver'].toString(),
      transactionSender: map['transactionSender'].toString(),
      amount: map['amount'].toString(),
    );
  }

  factory BitcoinTransaction.fromDocument(DocumentSnapshot doc) {
    return BitcoinTransaction(
      transactionDirection: doc["transactionDirection"],
      date: doc['date'],
      transactionReceiver: doc['transactionReceiver'],
      transactionSender: doc['transactionSender'],
      amount: doc['amount'],
      // date: DateTime.fromMillisecondsSinceEpoch(
      //   (doc['timestamp'] as Timestamp).millisecondsSinceEpoch,
      // ),
    );
  }

}
