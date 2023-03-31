import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nexus_wallet/backbone/helper/helpers.dart';

class Fees {
  final String fees_low;
  final String fees_medium;
  final String fees_high;

  // constructor
  Fees({
    required this.fees_low,
    required this.fees_medium,
    required this.fees_high,
  });

  Map<String, dynamic> toMap() {
    return {
      'fees_low': fees_low,
      'fees_medium': fees_medium,
      'fees_high': fees_high,
    };
  }

  factory Fees.fromJson(Map<String, dynamic> json) {
    return Fees(
      fees_low: json['fees_low'].toString(),
      fees_medium: json['fees_medium'].toString(),
      fees_high: json['fees_high'].toString(),
    );
  }

  factory Fees.fromMap(Map<String, dynamic> map) {
    return Fees(
      fees_low: map['fees_low'],
      fees_medium: map['fees_medium'].toString(),
      fees_high: map['fees_high'].toString(),
    );
  }

  factory Fees.fromDocument(DocumentSnapshot doc) {
    return Fees(
      fees_low: doc["fees_low"],
      fees_medium: doc['fees_medium'],
      fees_high: doc['fees_high'],
    );
  }
}
