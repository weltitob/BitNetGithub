class Outpoint {
  final String txidBytes;
  final String txidStr;
  final int outputIndex;

  Outpoint({
    required this.txidBytes,
    required this.txidStr,
    required this.outputIndex,
  });

  factory Outpoint.fromJson(Map<String, dynamic> json) {
    return Outpoint(
      txidBytes: json['txid_bytes'],
      txidStr: json['txid_str'],
      outputIndex: json['output_index'],
    );
  }
}
