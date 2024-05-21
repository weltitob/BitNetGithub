

import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';

class ReceivedInvoice {
  final String? memo;
  final String? rPreimage;
  final String? rHash;
  final int value;
  final int valueMsat;
  final bool settled;
  final int creationDate;
  final int settleDate;
  final String? paymentRequest;
  final String? state;
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

  factory ReceivedInvoice.fromJson(Map<String, dynamic>? json) {
    LoggerService logger = Get.find();
    if (json == null) {
      logger.e('JSON data must not be null');
      throw ArgumentError('JSON data must not be null');
    }
    // Map<String, dynamic>? result = json['result'] as Map<String, dynamic>?;
    // if (result == null) {
    //   logger.e('Result key missing or null in the JSON data');
    //   throw ArgumentError('Result key missing or null in the JSON data');
    // }
    return ReceivedInvoice(
      memo: json['memo'] as String?,
      rPreimage: json['r_preimage'] as String?,
      rHash: json['r_hash'] as String?,
      value: int.tryParse(json['value'].toString()) ?? 0,
      valueMsat: int.tryParse(json['value_msat'].toString()) ?? 0,
      settled: json['settled'] as bool? ?? false,
      creationDate: int.tryParse(json['creation_date'].toString()) ?? 0,
      settleDate: int.tryParse(json['settle_date'].toString()) ?? 0,
      paymentRequest: json['payment_request'] as String?,
      state: json['state'] as String?,
      amtPaid: int.tryParse(json['amt_paid'].toString()) ?? 0,
      amtPaidSat: int.tryParse(json['amt_paid_sat'].toString()) ?? 0,
      amtPaidMsat: int.tryParse(json['amt_paid_msat'].toString()) ?? 0,
    );
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
      invoices: List<ReceivedInvoice>.from(
          (json['invoices'] as List).map((x) => ReceivedInvoice.fromJson(x as Map<String, dynamic>?))
      ),
    );
  }
}
