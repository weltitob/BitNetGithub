import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nexus_wallet/backbone/helpers.dart';

class BitcoinTransaction {
  final String transactionDirection;
  final String timestampSent;
  final String timestampConfirmed;
  final String transactionSender;
  final String transactionReceiver;
  final String amount;
  final String transactionStatus;
  final String transactionUid;

  BitcoinTransaction({
    required this.transactionDirection,
    required this.timestampSent,
    required this.timestampConfirmed,
    required this.transactionSender,
    required this.transactionReceiver,
    required this.amount,
    required this.transactionStatus,
    required this.transactionUid,
  });

  String get dateFormatted => displayTimeAgoFromTimestamp(
      DateTime.fromMillisecondsSinceEpoch(int.parse(timestampSent)).toString());

  String get amountString {
    final amountSign = transactionDirection == "received" ? '+' : '-';
    return '$amountSign${double.parse(amount)}';
  }

  Map<String, dynamic> toMap() {
    return {
      'transactionDirection': transactionDirection,
      'timestampSent': timestampSent,
      'timestampConfirmed': timestampConfirmed,
      'transactionReceiver': transactionReceiver,
      'transactionSender': transactionSender,
      'amount': amount,
      'transactionStatus': transactionStatus,
      'transactionUid': transactionUid,
    };
  }

  factory BitcoinTransaction.fromJson(Map<String, dynamic> json) {
    return BitcoinTransaction(
      transactionDirection: json['transactionDirection'].toString(),
      timestampConfirmed: json['timestampConfirmed'].toString(),
      timestampSent: json['timestampSent'].toString(),
      transactionReceiver: json['transactionReceiver'].toString(),
      transactionSender: json['transactionSender'].toString(),
      amount: json['amount'].toString(),
      transactionStatus: json['transactionStatus'].toString(),
      transactionUid: json['transactionUid'].toString(),
    );
  }

  factory BitcoinTransaction.fromMap(Map<String, dynamic> map) {
    return BitcoinTransaction(
      transactionDirection: map['transactionDirection'],
      timestampSent: map['timestampSent'].toString(),
      timestampConfirmed: map['timestampConfirmed'].toString(),
      transactionReceiver: map['transactionReceiver'].toString(),
      transactionSender: map['transactionSender'].toString(),
      amount: map['amount'].toString(),
      transactionStatus: map['transactionStatus'].toString(),
      transactionUid: map['transactionUid'].toString(),
    );
  }

  factory BitcoinTransaction.fromDocument(DocumentSnapshot doc) {
    return BitcoinTransaction(
      transactionDirection: doc["transactionDirection"],
      timestampConfirmed: doc['timestampConfirmed'],
      timestampSent: doc['timestampSent'],
      transactionReceiver: doc['transactionReceiver'],
      transactionSender: doc['transactionSender'],
      amount: doc['amount'],
      transactionStatus: doc['transactionStatus'],
      transactionUid: doc['transactionUid'],
      // date: DateTime.fromMillisecondsSinceEpoch(
      //   (doc['timestamp'] as Timestamp).millisecondsSinceEpoch,
      // ),
    );
  }
}
