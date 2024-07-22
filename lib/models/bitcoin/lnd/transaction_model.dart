class BitcoinTransaction {
  String? txHash;
  String? amount;
  dynamic numConfirmations;
  String blockHash;
  dynamic blockHeight;
  dynamic timeStamp;
  String? totalFees;
  List<String> destAddresses;
  List<OutputDetail> outputDetails;
  String? rawTxHex; // Make nullable if not always provided
  String? label; // Make nullable if not always provided
  List<PreviousOutpoint> previousOutpoints;

  BitcoinTransaction({
    required this.txHash,
    required this.amount,
    required this.numConfirmations,
    required this.blockHash,
    required this.blockHeight,
    required this.timeStamp,
    required this.totalFees,
    required this.destAddresses,
    required this.outputDetails,
    this.rawTxHex, // Remove required if nullable
    this.label, // Remove required if nullable
    required this.previousOutpoints,
  });

  factory BitcoinTransaction.fromJson(Map<String, dynamic> json) {
    return BitcoinTransaction(
      txHash: json['tx_hash'] ?? '',
      amount: json['amount'] ?? '',
      numConfirmations: json['num_confirmations'] ?? '',
      blockHash: json['block_hash'] ?? '',
      blockHeight: json['block_height'] ?? '',
      timeStamp: json['time_stamp'] is int ? json['time_stamp'] : int.parse(json['time_stamp'] ?? '0'),
      totalFees: json['total_fees'] ?? '',
      destAddresses: json['dest_addresses'] != null ? List<String>.from(json['dest_addresses'].map((x) => x as String)) : [],
      outputDetails: json['output_details'] != null
          ? List<OutputDetail>.from(json['output_details'].map((x) => OutputDetail.fromJson(x as Map<String, dynamic>)))
          : [],
      rawTxHex: json['raw_tx_hex'] as String?,
      label: json['label'] as String?,
      previousOutpoints:
          List<PreviousOutpoint>.from(json['previous_outpoints'].map((x) => PreviousOutpoint.fromJson(x as Map<String, dynamic>))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tx_hash': txHash ?? '',
      'amount': amount ?? '',
      'num_confirmations': numConfirmations ?? '',
      'block_hash': blockHash,
      'block_height': blockHeight ?? '',
      'time_stamp': timeStamp ?? 0,
      'total_fees': totalFees ?? '',
      'dest_addresses': destAddresses,
      'output_details': outputDetails.map((x) => x.toJson()),
      'raw_tx_hex': rawTxHex ?? '',
      'label': label ?? '',
      'previous_outpoints': previousOutpoints.map((x) => x.toJson())
    };
  }
}

class OutputDetail {
  String outputType;
  String address;
  String pkScript;
  int outputIndex;
  String amount;
  bool isOurAddress;

  OutputDetail({
    required this.outputType,
    required this.address,
    required this.pkScript,
    required this.outputIndex,
    required this.amount,
    required this.isOurAddress,
  });

  factory OutputDetail.fromJson(Map<String, dynamic> json) {
    return OutputDetail(
      outputType: json['output_type']!,
      address: json['address']!,
      pkScript: json['pk_script']!,
      outputIndex: json['output_index'] is int ? json['output_index'] : int.parse(json['output_index']),
      amount: json['amount']!,
      isOurAddress: json['is_our_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'output_type': outputType,
      'address': address,
      'pk_script': pkScript,
      'output_index': outputIndex,
      'amount': amount,
      'is_our_address': isOurAddress
    };
  }
}

class PreviousOutpoint {
  String outpoint;
  bool isOurOutput;

  PreviousOutpoint({
    required this.outpoint,
    required this.isOurOutput,
  });

  factory PreviousOutpoint.fromJson(Map<String, dynamic> json) {
    return PreviousOutpoint(
      outpoint: json['outpoint']!,
      isOurOutput: json['is_our_output'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'outpoint': outpoint, 'is_our_output': isOurOutput};
  }
}

class BitcoinTransactionsList {
  List<BitcoinTransaction> transactions;

  BitcoinTransactionsList({
    required this.transactions,
  });

  factory BitcoinTransactionsList.fromJson(Map<String, dynamic> json) {
    return BitcoinTransactionsList(
      transactions: List<BitcoinTransaction>.from(json['transactions'].map((x) => BitcoinTransaction.fromJson(x as Map<String, dynamic>))),
    );
  }
  factory BitcoinTransactionsList.fromList(List<Map<String, dynamic>> json) {
    return BitcoinTransactionsList(
      transactions: List<BitcoinTransaction>.from(json.map((x) => BitcoinTransaction.fromJson(x))),
    );
  }
}
