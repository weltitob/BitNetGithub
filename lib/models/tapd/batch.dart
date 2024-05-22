import 'package:bitnet/models/tapd/asset.dart';

class Batch {
  final String? batchKey;
  final String? batchTxid;
  final String? state;
  final List<AssetInBatchList> assets;

  Batch({
    required this.batchKey,
    required this.batchTxid,
    required this.state,
    required this.assets,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    var assetsJson = json['assets'] as List;
    List<AssetInBatchList> assetsList = assetsJson.map((i) => AssetInBatchList .fromJson(i)).toList();

    return Batch(
      batchKey: json['batch_key'] as String?,
      batchTxid: json['batch_txid'] as String?,
      state: json['state'] as String?,
      assets: assetsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'batch_key': batchKey,
    'batch_txid': batchTxid,
    'state': state,
    'assets': assets.map((e) => e.toJson()).toList(),
  };
}
