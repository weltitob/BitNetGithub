import 'package:flutter/material.dart';

class ReceivedInvoice {
  final String? memo;
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
    this.memo,
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
    // Access the 'result' object within the JSON
    Map<String, dynamic> result = json['result'];

    // Now parse the data from the 'result' object
    return ReceivedInvoice(
      memo: result['memo'] as String?,
      rPreimage: result['r_preimage'],
      rHash: result['r_hash'],
      value: int.tryParse(result['value'].toString()) ?? 0,
      valueMsat: int.tryParse(result['value_msat'].toString()) ?? 0,
      settled: result['settled'] ?? false,
      creationDate: int.tryParse(result['creation_date'].toString()) ?? 0,
      settleDate: int.tryParse(result['settle_date'].toString()) ?? 0,
      paymentRequest: result['payment_request'],
      state: result['state'],
      amtPaid: int.tryParse(result['amt_paid'].toString()) ?? 0,
      amtPaidSat: int.tryParse(result['amt_paid_sat'].toString()) ?? 0,
      amtPaidMsat: int.tryParse(result['amt_paid_msat'].toString()) ?? 0,
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