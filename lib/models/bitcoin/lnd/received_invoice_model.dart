import 'package:flutter/material.dart';

class ReceivedInvoice {
  final String memo;
  final String rPreimage;
  final String rHash;
  final int value;
  final int valueMsat;
  final bool settled;
  final int creationDate;
  final int settleDate;
  final String paymentRequest;
  final String state;
  final int amtPaid;
  final int amtPaidSat;
  final int amtPaidMsat;

  ReceivedInvoice({
    required this.memo,
    required this.rPreimage,
    required this.rHash,
    required this.value,
    required this.valueMsat,
    required this.settled,
    required this.creationDate,
    required this.settleDate,
    required this.paymentRequest,
    required this.state,
    required this.amtPaid,
    required this.amtPaidSat,
    required this.amtPaidMsat,
  });

  factory ReceivedInvoice.fromJson(Map<String, dynamic> json) {
    return ReceivedInvoice(
      memo: json['memo'],
      rPreimage: json['r_preimage'],
      rHash: json['r_hash'],
      value: int.parse(json['value'].toString()),
      valueMsat: int.parse(json['value_msat'].toString()),
      settled: json['settled'], //only if true
      creationDate: int.parse(json['creation_date'].toString()),
      settleDate: int.parse(json['settle_date'].toString()),
      paymentRequest: json['payment_request'],
      state: json['state'],
      amtPaid: int.parse(json['amt_paid'].toString()),
      amtPaidSat: int.parse(json['amt_paid_sat'].toString()),
      amtPaidMsat: int.parse(json['amt_paid_msat'].toString()),
    );
  }
}

class ReceivedInvoicesList {
  final List<ReceivedInvoice> invoices;

  ReceivedInvoicesList({required this.invoices});

  factory ReceivedInvoicesList.fromJson(Map<String, dynamic> json) {
    return ReceivedInvoicesList(
      invoices: List<ReceivedInvoice>.from(json['invoices'].map((x) => ReceivedInvoice.fromJson(x))),
    );
  }
}
