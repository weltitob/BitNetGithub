class Input {
  final String txidStr;
  final String txidBytes;
  final int outputIndex;

  Input({
    required this.txidStr,
    required this.txidBytes,
    required this.outputIndex,
  });

  // Methode zur Erzeugung einer Input-Instanz aus einem Map (z.B. für JSON Parsing)
  factory Input.fromJson(Map<String, dynamic> json) {
    return Input(
      txidStr: json['txid_str'],
      txidBytes: json['txid_bytes'],
      outputIndex: json['output_index'],
    );
  }

  // Methode zur Umwandlung einer Input-Instanz in ein Map (z.B. für JSON Serialization)
  Map<String, dynamic> toJson() {
    return {
      'txid_str': txidStr,
      'txid_bytes': txidBytes,
      'output_index': outputIndex,
    };
  }
}
