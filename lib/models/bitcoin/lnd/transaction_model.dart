import 'package:bitnet/backbone/helper/helpers.dart';
class BitcoinTransaction {
  String txHash;
  String amount; // Keep as String if negative values are represented with "-" sign
  int numConfirmations;
  String blockHash;
  int blockHeight;
  int timeStamp; // Changed to int
  String totalFees; // Keep as String if negative values are possible
  List<String> destAddresses;
  List<OutputDetail> outputDetails;
  String rawTxHex;
  String label;
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
    required this.rawTxHex,
    required this.label,
    required this.previousOutpoints,
  });

  factory BitcoinTransaction.fromJson(Map<String, dynamic> json) {
    return BitcoinTransaction(
      txHash: json['tx_hash'],
      amount: json['amount'],
      numConfirmations: json['num_confirmations'],
      blockHash: json['block_hash'],
      blockHeight: json['block_height'],
      timeStamp: int.parse(json['time_stamp']), // Parse to int
      totalFees: json['total_fees'],
      destAddresses: List<String>.from(json['dest_addresses'].map((x) => x)),
      outputDetails: List<OutputDetail>.from(json['output_details'].map((x) => OutputDetail.fromJson(x))),
      rawTxHex: json['raw_tx_hex'],
      label: json['label'] ?? '', // Handle potential null value
      previousOutpoints: List<PreviousOutpoint>.from(json['previous_outpoints'].map((x) => PreviousOutpoint.fromJson(x))),
    );
  }
}

class OutputDetail {
  String outputType;
  String address;
  String pkScript;
  int outputIndex; // Changed to int
  String amount; // Keep as String if negative values are represented with "-" sign
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
      outputType: json['output_type'],
      address: json['address'],
      pkScript: json['pk_script'],
      outputIndex: int.parse(json['output_index']), // Parse to int
      amount: json['amount'],
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

  // From JSON
  factory PreviousOutpoint.fromJson(Map<String, dynamic> json) {
    return PreviousOutpoint(
      outpoint: json['outpoint'],
      isOurOutput: json['is_our_output'],
    );
  }
}

class BitcoinTransactionsList {
  List<BitcoinTransaction> transactions;

  BitcoinTransactionsList({
    required this.transactions,
  });

  // From JSON
  factory BitcoinTransactionsList.fromJson(Map<String, dynamic> json) {
    return BitcoinTransactionsList(
      transactions: List<BitcoinTransaction>.from(json['transactions'].map((x) => BitcoinTransaction.fromJson(x))),
    );
  }
}