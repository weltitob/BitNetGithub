import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/models/tapd/pendingbatch.dart';


class MintAssetResponse {
  final PendingBatch? pendingBatch;

  MintAssetResponse({
    this.pendingBatch,
  });

  factory MintAssetResponse.fromJson(Map<String, dynamic> json) {
    return MintAssetResponse(
      pendingBatch: json['pending_batch'] != null
          ? PendingBatch.fromJson(json['pending_batch'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending_batch': pendingBatch?.toJson(),
    };
  }
}

class PendingBatch {
  final String? batchKey;
  final String? batchTxid;
  final String? state;
  final List<Asset>? assets;

  PendingBatch({
    this.batchKey,
    this.batchTxid,
    this.state,
    this.assets,
  });

  factory PendingBatch.fromJson(Map<String, dynamic> json) {
    return PendingBatch(
      batchKey: json['batch_key'],
      batchTxid: json['batch_txid'],
      state: json['state'],
      assets: json['assets'] != null
          ? (json['assets'] as List).map((i) => Asset.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'batch_key': batchKey,
      'batch_txid': batchTxid,
      'state': state,
      'assets': assets?.map((e) => e.toJson()).toList(),
    };
  }
}

class Asset {
  final String? assetVersion;
  final String? assetType;
  final String? name;
  final AssetMetaResponse? assetMeta;
  final dynamic amount;
  final bool? newGroupedAsset;
  final String? groupKey;
  final String? groupAnchor;

  Asset({
    this.assetVersion,
    this.assetType,
    this.name,
    this.assetMeta,
    this.amount,
    this.newGroupedAsset,
    this.groupKey,
    this.groupAnchor,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      assetVersion: json['asset_version'],
      assetType: json['asset_type'],
      name: json['name'],
      assetMeta: json['asset_meta'] != null ? AssetMetaResponse.fromJson(json['asset_meta']) : null,
      amount: json['amount'],
      newGroupedAsset: json['new_grouped_asset'],
      groupKey: json['group_key'],
      groupAnchor: json['group_anchor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset_version': assetVersion,
      'asset_type': assetType,
      'name': name,
      'asset_meta': assetMeta?.toJson(),
      'amount': amount,
      'new_grouped_asset': newGroupedAsset,
      'group_key': groupKey,
      'group_anchor': groupAnchor,
    };
  }
}