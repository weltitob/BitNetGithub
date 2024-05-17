import 'package:matrix/matrix.dart';

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
    if (json == null) {
      Logs().e('JSON data must not be null');
      throw ArgumentError('JSON data must not be null');
    }
    Map<String, dynamic>? result = json['result'] as Map<String, dynamic>?;
    if (result == null) {
      Logs().e('Result key missing or null in the JSON data');
      throw ArgumentError('Result key missing or null in the JSON data');
    }
    return ReceivedInvoice(
      memo: result['memo'] as String?,
      rPreimage: result['r_preimage'] as String?,
      rHash: result['r_hash'] as String?,
      value: int.tryParse(result['value'].toString()) ?? 0,
      valueMsat: int.tryParse(result['value_msat'].toString()) ?? 0,
      settled: result['settled'] as bool? ?? false,
      creationDate: int.tryParse(result['creation_date'].toString()) ?? 0,
      settleDate: int.tryParse(result['settle_date'].toString()) ?? 0,
      paymentRequest: result['payment_request'] as String?,
      state: result['state'] as String?,
      amtPaid: int.tryParse(result['amt_paid'].toString()) ?? 0,
      amtPaidSat: int.tryParse(result['amt_paid_sat'].toString()) ?? 0,
      amtPaidMsat: int.tryParse(result['amt_paid_msat'].toString()) ?? 0,
    );
  }
}

class ReceivedInvoicesList {
  final List<ReceivedInvoice> invoices;

  ReceivedInvoicesList({required this.invoices});

  factory ReceivedInvoicesList.fromJson(Map<String, dynamic>? json) {
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
