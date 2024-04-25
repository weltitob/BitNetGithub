class LoopQuoteModel {
  final String swapFeeSat;
  final int? htlcPublishFeeSat;
  final String? htlcSweepFeeSat;
  final String? prepayAmtSat;
  final String? swapPaymentDest;
  final int cltvDelta;
  final int confTarget;

  LoopQuoteModel({
    required this.swapFeeSat,
    this.htlcPublishFeeSat,
    this.htlcSweepFeeSat,
    this.prepayAmtSat,
    this.swapPaymentDest,
    required this.cltvDelta,
    required this.confTarget,
  });

  factory LoopQuoteModel.fromJson(Map<String, dynamic> json) {
    return LoopQuoteModel(
      swapFeeSat: json['swap_fee_sat'],
      htlcPublishFeeSat: json['htlc_publish_fee_sat'],
      htlcSweepFeeSat: json['htlc_sweep_fee_sat'],
      prepayAmtSat: json['prepay_amt_sat'],
      swapPaymentDest: json['swap_payment_dest'],
      cltvDelta: json['cltv_delta'],
      confTarget: json['conf_target'],
    );
  }
}
