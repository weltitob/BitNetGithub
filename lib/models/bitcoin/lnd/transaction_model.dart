
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
      timeStamp: int.parse(json['time_stamp']??0),
      totalFees: json['total_fees'] ?? '',
      destAddresses: List<String>.from(json['dest_addresses'].map((x) => x as String)),
      outputDetails: List<OutputDetail>.from(json['output_details'].map((x) => OutputDetail.fromJson(x as Map<String, dynamic>))),
      rawTxHex: json['raw_tx_hex'] as String?,
      label: json['label'] as String?,
      previousOutpoints: List<PreviousOutpoint>.from(json['previous_outpoints'].map((x) => PreviousOutpoint.fromJson(x as Map<String, dynamic>))),
    );
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
      outputIndex: int.parse(json['output_index']),
      amount: json['amount']!,
      isOurAddress: json['is_our_address'],
    );
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
}
