import 'package:bitnet/models/bitcoin/walletkit/input.dart';
import 'package:bitnet/models/bitcoin/walletkit/output.dart';

class RawTransactionData {
  final List<Input> inputs;
  final Outputs outputs; // Angenommen, Outputs ist eine Klasse oder Map

  RawTransactionData({
    required this.inputs,
    required this.outputs,
  });

  factory RawTransactionData.fromJson(Map<String, dynamic> json) {
    return RawTransactionData(
      inputs: List<Input>.from(json['inputs'].map((i) => Input.fromJson(i))),
      outputs: Outputs.fromJson(json['outputs']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs.map((i) => i.toJson()).toList(),
      'outputs': outputs.toJson(),
    };
  }
}
