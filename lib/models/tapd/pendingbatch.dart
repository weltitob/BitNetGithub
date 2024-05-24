// Define the PendingBatch class
import 'package:bitnet/models/tapd/asset.dart';

class PendingBatch {
  final String batchKey;
  final String batchTxid;
  final String state;
  final List<Asset> assets;

  PendingBatch({
    required this.batchKey,
    required this.batchTxid,
    required this.state,
    required this.assets,
  });

  factory PendingBatch.fromJson(Map<String, dynamic> json) {
    var assetsList = json['assets'] as List;
    List<Asset> assets = assetsList.map((i) => Asset.fromJson(i)).toList();

    return PendingBatch(
      batchKey: json['batch_key'],
      batchTxid: json['batch_txid'],
      state: json['state'],
      assets: assets,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batch_key': batchKey,
      'batch_txid': batchTxid,
      'state': state,
      'assets': assets.map((asset) => asset.toJson()).toList(),
    };
  }
}
