import 'package:bitnet/models/bitcoin/walletkit/outpoint.dart';

class FundedPsbtResponse {
  final String fundedPsbt;
  final int changeOutputIndex;
  final List<LockedUtxo> lockedUtxos;

  FundedPsbtResponse({
    required this.fundedPsbt,
    required this.changeOutputIndex,
    required this.lockedUtxos,
  });

  factory FundedPsbtResponse.fromJson(Map<String, dynamic> json) {
    var utxosFromJson = json['locked_utxos'] as List;
    List<LockedUtxo> utxosList = utxosFromJson.map((utxoJson) => LockedUtxo.fromJson(utxoJson)).toList();

    return FundedPsbtResponse(
      fundedPsbt: json['funded_psbt'],
      changeOutputIndex: json['change_output_index'],
      lockedUtxos: utxosList,
    );
  }
}

class LockedUtxo {
  final String id;
  final Outpoint outpoint;

  LockedUtxo({
    required this.id,
    required this.outpoint,
  });

  factory LockedUtxo.fromJson(Map<String, dynamic> json) {
    return LockedUtxo(
      id: json['id'],
      outpoint: Outpoint.fromJson(json['outpoint']),
    );
  }
}
