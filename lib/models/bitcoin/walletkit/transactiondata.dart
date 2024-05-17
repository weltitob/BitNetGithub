import 'package:bitnet/models/bitcoin/walletkit/rawtransactiondata.dart';

class TransactionData {
  final String? psbt; // Optional, da es in den Kommentaren steht
  final RawTransactionData raw;
  final int targetConf;
  final String? satPerVbyte; // Optional, da es in den Kommentaren steht
  final String account;
  final int minConfs;
  final bool spendUnconfirmed;
  final int changeType;

  TransactionData({
    this.psbt,
    required this.raw,
    required this.targetConf,
    this.satPerVbyte,
    required this.account,
    required this.minConfs,
    required this.spendUnconfirmed,
    required this.changeType,
  });

  // Für JSON Parsing, falls erforderlich
  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      psbt: json['psbt'],
      raw: RawTransactionData.fromJson(json['raw']),
      targetConf: json['target_conf'],
      satPerVbyte: json['sat_per_vbyte'],
      account: json['account'],
      minConfs: json['min_confs'],
      spendUnconfirmed: json['spend_unconfirmed'],
      changeType: json['change_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'psbt': psbt,
      'raw': raw.toJson(),
      'target_conf': targetConf,
      'sat_per_vbyte': satPerVbyte,
      'account': account,
      'min_confs': minConfs,
      'spend_unconfirmed': spendUnconfirmed,
      'change_type': changeType,
    };
  }
}