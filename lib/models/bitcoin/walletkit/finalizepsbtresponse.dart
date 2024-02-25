class FinalizePsbtResponse {
  final String signedPsbt;
  final String rawFinalTx;

  FinalizePsbtResponse({
    required this.signedPsbt,
    required this.rawFinalTx,
  });

  factory FinalizePsbtResponse.fromJson(Map<String, dynamic> json) {
    return FinalizePsbtResponse(
      signedPsbt: json['signed_psbt'],
      rawFinalTx: json['raw_final_tx'],
    );
  }
}
