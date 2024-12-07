class LightningPayment {
  String paymentHash;
  int value;
  int creationDate;
  int fee;
  String paymentPreimage;
  int valueSat;
  int valueMsat;
  String paymentRequest;
  String status;
  int feeSat;
  int feeMsat;
  int creationTimeNs;
  List<Htlc> htlcs;
  String paymentIndex;
  String failureReason;

  LightningPayment({
    required this.paymentHash,
    required this.value,
    required this.creationDate,
    required this.fee,
    required this.paymentPreimage,
    required this.valueSat,
    required this.valueMsat,
    required this.paymentRequest,
    required this.status,
    required this.feeSat,
    required this.feeMsat,
    required this.creationTimeNs,
    required this.htlcs,
    required this.paymentIndex,
    required this.failureReason,
  });

  factory LightningPayment.fromJson(Map<String, dynamic> json) {
    return LightningPayment(
      paymentHash: json['payment_hash'],
      value: int.parse(json['value'].toString()),
      creationDate: int.parse(json['creation_date'].toString()),
      fee: int.parse(json['fee'].toString()),
      paymentPreimage: json['payment_preimage'],
      valueSat: int.parse(json['value_sat'].toString()),
      valueMsat: int.parse(json['value_msat'].toString()),
      paymentRequest: json['payment_request'],
      status: json['status'],
      feeSat: int.parse(json['fee_sat'].toString()),
      feeMsat: int.parse(json['fee_msat'].toString()),
      creationTimeNs: int.parse(json['creation_time_ns'].toString()),
      htlcs: List<Htlc>.from(json['htlcs'].map((x) => Htlc.fromJson(x))),
      paymentIndex: json['payment_index'],
      failureReason:
          json['failure_reason'] ?? '', // Assuming failureReason can be null
    );
  }
}

class Htlc {
  int attemptId;
  String status;
  Route route;
  int attemptTimeNs;
  int resolveTimeNs;
  dynamic failure;
  String preimage;

  Htlc({
    required this.attemptId,
    required this.status,
    required this.route,
    required this.attemptTimeNs,
    required this.resolveTimeNs,
    this.failure,
    required this.preimage,
  });

  factory Htlc.fromJson(Map<String, dynamic> json) {
    return Htlc(
      attemptId: int.parse(json['attempt_id'].toString()),
      status: json['status'],
      route: Route.fromJson(json['route']),
      attemptTimeNs: int.parse(json['attempt_time_ns'].toString()),
      resolveTimeNs: int.parse(json['resolve_time_ns'].toString()),
      failure: json['failure'],
      preimage: json['preimage'],
    );
  }
}

class Route {
  int totalTimeLock;
  int totalFees;
  int totalAmt;
  List<Hop> hops;
  int totalFeesMsat;
  int totalAmtMsat;

  Route({
    required this.totalTimeLock,
    required this.totalFees,
    required this.totalAmt,
    required this.hops,
    required this.totalFeesMsat,
    required this.totalAmtMsat,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      totalTimeLock: int.parse(json['total_time_lock'].toString()),
      totalFees: int.parse(json['total_fees'].toString()),
      totalAmt: int.parse(json['total_amt'].toString()),
      hops: List<Hop>.from(json['hops'].map((x) => Hop.fromJson(x))),
      totalFeesMsat: int.parse(json['total_fees_msat'].toString()),
      totalAmtMsat: int.parse(json['total_amt_msat'].toString()),
    );
  }
}

class Hop {
  String chanId;
  String chanCapacity;
  int amtToForward;
  int fee;
  int expiry;
  int amtToForwardMsat;
  int feeMsat;
  String pubKey;
  bool tlvPayload;

  Hop({
    required this.chanId,
    required this.chanCapacity,
    required this.amtToForward,
    required this.fee,
    required this.expiry,
    required this.amtToForwardMsat,
    required this.feeMsat,
    required this.pubKey,
    required this.tlvPayload,
  });

  factory Hop.fromJson(Map<String, dynamic> json) {
    return Hop(
      chanId: json['chan_id'],
      chanCapacity: json['chan_capacity'],
      amtToForward: int.parse(json['amt_to_forward'].toString()),
      fee: int.parse(json['fee'].toString()),
      expiry: int.parse(json['expiry'].toString()),
      amtToForwardMsat: int.parse(json['amt_to_forward_msat'].toString()),
      feeMsat: int.parse(json['fee_msat'].toString()),
      pubKey: json['pub_key'],
      tlvPayload: json['tlv_payload'],
    );
  }
}

class LightningPaymentsList {
  List<LightningPayment> payments;
  int firstIndexOffset;
  int lastIndexOffset;
  int totalNumPayments;

  LightningPaymentsList({
    required this.payments,
    required this.firstIndexOffset,
    required this.lastIndexOffset,
    required this.totalNumPayments,
  });

  factory LightningPaymentsList.fromJson(Map<String, dynamic> json) {
    return LightningPaymentsList(
      payments: List<LightningPayment>.from(
          json['payments'].map((x) => LightningPayment.fromJson(x))),
      firstIndexOffset: int.parse(json['first_index_offset'].toString()),
      lastIndexOffset: int.parse(json['last_index_offset'].toString()),
      totalNumPayments: int.parse(json['total_num_payments'].toString()),
    );
  }

  factory LightningPaymentsList.fromList(List<Map<String, dynamic>> json) {
    return LightningPaymentsList(
      payments: List<LightningPayment>.from(
          json.map((x) => LightningPayment.fromJson(x))),
      firstIndexOffset: -1,
      lastIndexOffset: -1,
      totalNumPayments: -1,
    );
  }
}
