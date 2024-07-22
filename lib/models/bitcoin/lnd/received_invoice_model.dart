import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

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
    LoggerService logger = Get.find();

    String parseString(dynamic value, String fieldName) {
      if (value == null) {
        logger.e('$fieldName is missing or null');
        throw ArgumentError('$fieldName is missing or null');
      }
      return value as String;
    }

    int parseInt(dynamic value, String fieldName) {
      if (value == null) {
        logger.e('$fieldName is missing or null');
        throw ArgumentError('$fieldName is missing or null');
      }
      return int.tryParse(value.toString()) ?? 0;
    }

    bool parseBool(dynamic value, String fieldName) {
      if (value == null) {
        logger.e('$fieldName is missing or null');
        throw ArgumentError('$fieldName is missing or null');
      }
      return value as bool;
    }

    return ReceivedInvoice(
      memo: parseString(json['memo'], 'memo'),
      rPreimage: parseString(json['r_preimage'], 'r_preimage'),
      rHash: parseString(json['r_hash'], 'r_hash'),
      value: parseInt(json['value'], 'value'),
      valueMsat: parseInt(json['value_msat'], 'value_msat'),
      settled: parseBool(json['settled'], 'settled'),
      creationDate: parseInt(json['creation_date'], 'creation_date'),
      settleDate: parseInt(json['settle_date'], 'settle_date'),
      paymentRequest: parseString(json['payment_request'], 'payment_request'),
      state: parseString(json['state'], 'state'),
      amtPaid: parseInt(json['amt_paid'], 'amt_paid'),
      amtPaidSat: parseInt(json['amt_paid_sat'], 'amt_paid_sat'),
      amtPaidMsat: parseInt(json['amt_paid_msat'], 'amt_paid_msat'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memo': memo,
      'r_preimage': rPreimage,
      'r_hash': rHash,
      'value': value,
      'value_msat': valueMsat,
      'settled': settled,
      'creation_date': creationDate,
      'settle_date': settleDate,
      'payment_request': paymentRequest,
      'state': state,
      'amt_paid': amtPaid,
      'amt_paid_sat': amtPaidSat,
      'amt_paid_msat': amtPaidMsat
    };
  }
}

class ReceivedInvoicesList {
  final List<ReceivedInvoice> invoices;

  ReceivedInvoicesList({required this.invoices});

  factory ReceivedInvoicesList.fromJson(Map<String, dynamic>? json) {
    print('json $json');
    if (json == null || json['invoices'] == null) {
      throw ArgumentError('JSON data or "invoices" key is missing or null');
    }
    return ReceivedInvoicesList(
      invoices: List<ReceivedInvoice>.from((json['invoices'] as List).map((x) => ReceivedInvoice.fromJson(x as Map<String, dynamic>))),
    );
  }

  factory ReceivedInvoicesList.fromList(List<Map<String, dynamic>> json) {
    return ReceivedInvoicesList(
      invoices: List<ReceivedInvoice>.from(json.map((x) => ReceivedInvoice.fromJson(x))),
    );
  }
}
