
import 'package:bitnet/models/bitcoin/walletkit/outpoint.dart';

class Utxo {
  final String addressType;
  final String address;
  final int amountSat;
  final String pkScript;
  final Outpoint outpoint;
  final int confirmations;

  Utxo({
    required this.addressType,
    required this.address,
    required this.amountSat,
    required this.pkScript,
    required this.outpoint,
    required this.confirmations,
  });

  factory Utxo.fromJson(Map<String, dynamic> json) {
    return Utxo(
      addressType: json['address_type'],
      address: json['address'],
      amountSat: int.parse(json['amount_sat']),
      pkScript: json['pk_script'],
      outpoint: Outpoint.fromJson(json['outpoint']),
      confirmations: int.parse(json['confirmations']),
    );
  }
}

class UtxoRequestList {
  final List<Utxo> utxos;

  UtxoRequestList({required this.utxos});

  factory UtxoRequestList.fromJson(Map<String, dynamic> json) {
    var list = json['utxos'] as List;
    List<Utxo> utxosList = list.map((i) => Utxo.fromJson(i)).toList();
    return UtxoRequestList(utxos: utxosList);
  }
}
