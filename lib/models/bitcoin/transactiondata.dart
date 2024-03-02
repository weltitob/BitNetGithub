import 'package:bitnet/components/items/transactionitem.dart';
import 'package:flutter/material.dart';

class TransactionItemData {
  final TransactionType type;
  final TransactionDirection direction;
  final TransactionStatus status;
  final String receiver;
  final String txHash;
  final String amount;
  final int timestamp; // The timestamp property

  TransactionItemData({
    required this.type,
    required this.direction,
    required this.status,
    required this.receiver,
    required this.txHash,
    required this.amount,
    required this.timestamp,
  });
}