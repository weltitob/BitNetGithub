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
    // Helper function to safely parse integers
    int safeParseInt(dynamic value, {int defaultValue = 0}) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String && value.isNotEmpty) {
        return int.tryParse(value) ?? defaultValue;
      }
      return int.tryParse(value.toString()) ?? defaultValue;
    }
    
    return LightningPayment(
      paymentHash: json['payment_hash'] ?? '',
      value: safeParseInt(json['value']),
      creationDate: safeParseInt(json['creation_date']),
      fee: safeParseInt(json['fee']),
      paymentPreimage: json['payment_preimage'] ?? '',
      valueSat: safeParseInt(json['value_sat']),
      valueMsat: safeParseInt(json['value_msat']),
      paymentRequest: json['payment_request'] ?? '',
      status: json['status'] ?? '',
      feeSat: safeParseInt(json['fee_sat']),
      feeMsat: safeParseInt(json['fee_msat']),
      creationTimeNs: safeParseInt(json['creation_time_ns']),
      htlcs: (json['htlcs'] as List<dynamic>?)?.map((x) => Htlc.fromJson(x as Map<String, dynamic>)).toList() ?? [],
      paymentIndex: json['payment_index'] ?? '',
      failureReason: json['failure_reason'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_hash': this.paymentHash,
      'value': this.value,
      'creation_date': creationDate,
      'fee': fee,
      'payment_preimage': paymentPreimage,
      'value_sat': valueSat,
      'value_msat': valueMsat,
      'payment_request': paymentRequest,
      'status': status,
      'fee_sat': feeSat,
      'fee_msat': feeMsat,
      'creation_time_ns': creationTimeNs,
      'htlcs': htlcs.map((htlc) => htlc.toJson()).toList(),
      'payment_index': paymentIndex,
      'failure_reason': failureReason
    };
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
    // Helper function to safely parse integers
    int safeParseInt(dynamic value, {int defaultValue = 0}) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String && value.isNotEmpty) {
        return int.tryParse(value) ?? defaultValue;
      }
      return int.tryParse(value.toString()) ?? defaultValue;
    }
    
    return Htlc(
      attemptId: safeParseInt(json['attempt_id']),
      status: json['status'] ?? '',
      route: json['route'] != null ? Route.fromJson(json['route'] as Map<String, dynamic>) : Route.empty(),
      attemptTimeNs: safeParseInt(json['attempt_time_ns']),
      resolveTimeNs: safeParseInt(json['resolve_time_ns']),
      failure: json['failure'],
      preimage: json['preimage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attempt_id': attemptId,
      'status': status,
      'route': route.toJson(),
      'attempt_time_ns': attemptTimeNs,
      'resolve_time_ns': resolveTimeNs,
      'failure': failure,
      'preimage': preimage
    };
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
    // Helper function to safely parse integers
    int safeParseInt(dynamic value, {int defaultValue = 0}) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String && value.isNotEmpty) {
        return int.tryParse(value) ?? defaultValue;
      }
      return int.tryParse(value.toString()) ?? defaultValue;
    }
    
    return Route(
      totalTimeLock: safeParseInt(json['total_time_lock']),
      totalFees: safeParseInt(json['total_fees']),
      totalAmt: safeParseInt(json['total_amt']),
      hops: (json['hops'] as List<dynamic>?)?.map((x) => Hop.fromJson(x as Map<String, dynamic>)).toList() ?? [],
      totalFeesMsat: safeParseInt(json['total_fees_msat']),
      totalAmtMsat: safeParseInt(json['total_amt_msat']),
    );
  }

  factory Route.empty() {
    return Route(
      totalTimeLock: 0,
      totalFees: 0,
      totalAmt: 0,
      hops: [],
      totalFeesMsat: 0,
      totalAmtMsat: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_time_lock': totalTimeLock,
      'total_fees': totalFees,
      'total_amt': totalAmt,
      'hops': hops.map((hop) => hop.toJson()).toList(),
      'total_fees_msat': totalFeesMsat,
      'total_amt_msat': totalAmtMsat
    };
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
    // Helper function to safely parse integers
    int safeParseInt(dynamic value, {int defaultValue = 0}) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String && value.isNotEmpty) {
        return int.tryParse(value) ?? defaultValue;
      }
      return int.tryParse(value.toString()) ?? defaultValue;
    }
    
    return Hop(
      chanId: json['chan_id'] ?? '',
      chanCapacity: json['chan_capacity'] ?? '',
      amtToForward: safeParseInt(json['amt_to_forward']),
      fee: safeParseInt(json['fee']),
      expiry: safeParseInt(json['expiry']),
      amtToForwardMsat: safeParseInt(json['amt_to_forward_msat']),
      feeMsat: safeParseInt(json['fee_msat']),
      pubKey: json['pub_key'] ?? '',
      tlvPayload: json['tlv_payload'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'chan_id': chanId,
      'chan_capacity': chanCapacity,
      'amt_to_forward': amtToForward,
      'fee': fee,
      'expiry': expiry,
      'amt_to_forward_msat': amtToForwardMsat,
      'fee_msat': feeMsat,
      'pub_key': pubKey,
      'tlv_payload': tlvPayload
    };
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
