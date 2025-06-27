import 'package:bitnet/models/tapd/assetmeta.dart';

class AssetInBatchList {
  String? version;
  String? type;
  String? name;
  AssetMetaResponse? assetMeta;
  String? amount;
  bool? newGroupedAsset;
  String? groupKey;
  String? groupAnchor;

  AssetInBatchList({
    this.version,
    this.type,
    this.name,
    this.assetMeta,
    this.amount,
    this.newGroupedAsset,
    this.groupKey,
    this.groupAnchor,
  });

  factory AssetInBatchList.fromJson(Map<String, dynamic> json) {
    return AssetInBatchList(
      version: json['asset_version'] as String?,
      type: json['asset_type'] as String?,
      name: json['name'] as String?,
      assetMeta: json['asset_meta'] != null
          ? AssetMetaResponse.fromJson(json['asset_meta'])
          : null,
      amount: json['amount'] as String?,
      newGroupedAsset: json['new_grouped_asset'] as bool?,
      groupKey: json['group_key'] as String?,
      groupAnchor: json['group_anchor'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asset_version': version,
      'asset_type': type,
      'name': name,
      'asset_meta': assetMeta?.toJson(),
      'amount': amount,
      'new_grouped_asset': newGroupedAsset,
      'group_key': groupKey,
      'group_anchor': groupAnchor,
    };
  }
}

class Asset {
  String? version;
  AssetGenesis? assetGenesis;
  String? amount;
  int? lockTime;
  int? relativeLockTime;
  int? scriptVersion;
  String? scriptKey;
  bool? scriptKeyIsLocal;
  dynamic assetGroup;
  ChainAnchor? chainAnchor;
  List<dynamic>? prevWitnesses;
  bool? isSpent;
  String? leaseOwner;
  String? leaseExpiry;
  bool? isBurn;

  Asset({
    this.version,
    this.assetGenesis,
    this.amount,
    this.lockTime,
    this.relativeLockTime,
    this.scriptVersion,
    this.scriptKey,
    this.scriptKeyIsLocal,
    this.assetGroup,
    this.chainAnchor,
    this.prevWitnesses,
    this.isSpent,
    this.leaseOwner,
    this.leaseExpiry,
    this.isBurn,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      version: json['asset_version'] as String?,
      assetGenesis: json['asset_genesis'] != null
          ? AssetGenesis.fromJson(json['asset_genesis'])
          : null,
      amount: json['amount'] as String?,
      lockTime: json['lock_time'] as int?,
      relativeLockTime: json['relative_lock_time'] as int?,
      scriptVersion: json['script_version'] as int?,
      scriptKey: json['script_key'] as String?,
      scriptKeyIsLocal: json['script_key_is_local'] as bool?,
      assetGroup: json['asset_group'],
      chainAnchor: json['chain_anchor'] != null
          ? ChainAnchor.fromJson(json['chain_anchor'])
          : null,
      prevWitnesses: json['prev_witnesses'] != null
          ? List<dynamic>.from(json['prev_witnesses'])
          : null,
      isSpent: json['is_spent'] as bool?,
      leaseOwner: json['lease_owner'] as String?,
      leaseExpiry: json['lease_expiry'] as String?,
      isBurn: json['is_burn'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'asset_genesis': assetGenesis?.toJson(),
      'amount': amount,
      'lock_time': lockTime,
      'relative_lock_time': relativeLockTime,
      'script_version': scriptVersion,
      'script_key': scriptKey,
      'script_key_is_local': scriptKeyIsLocal,
      'asset_group': assetGroup,
      'chain_anchor': chainAnchor?.toJson(),
      'prev_witnesses': prevWitnesses,
      'is_spent': isSpent,
      'lease_owner': leaseOwner,
      'lease_expiry': leaseExpiry,
      'is_burn': isBurn,
    };
  }
}

class AssetGenesis {
  String? genesisPoint;
  String? name;
  String? metaHash;
  String? assetId;
  String? assetType;
  int? outputIndex;
  int? version;

  AssetGenesis({
    this.genesisPoint,
    this.name,
    this.metaHash,
    this.assetId,
    this.assetType,
    this.outputIndex,
    this.version,
  });

  factory AssetGenesis.fromJson(Map<String, dynamic> json) {
    return AssetGenesis(
      genesisPoint: json['genesis_point'] as String?,
      name: json['name'] as String?,
      metaHash: json['meta_hash'] as String?,
      assetId: json['asset_id'] as String?,
      assetType: json['asset_type'] as String?,
      outputIndex: json['output_index'] as int?,
      version: json['version'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genesis_point': genesisPoint,
      'name': name,
      'meta_hash': metaHash,
      'asset_id': assetId,
      'asset_type': assetType,
      'output_index': outputIndex,
      'version': version,
    };
  }
}

class ChainAnchor {
  String? anchorTx;
  String? anchorBlockHash;
  String? anchorOutpoint;
  String? internalKey;
  String? merkleRoot;
  String? tapscriptSibling;
  int? blockHeight;

  ChainAnchor({
    this.anchorTx,
    this.anchorBlockHash,
    this.anchorOutpoint,
    this.internalKey,
    this.merkleRoot,
    this.tapscriptSibling,
    this.blockHeight,
  });

  factory ChainAnchor.fromJson(Map<String, dynamic> json) {
    return ChainAnchor(
      anchorTx: json['anchor_tx'] as String?,
      anchorBlockHash: json['anchor_block_hash'] as String?,
      anchorOutpoint: json['anchor_outpoint'] as String?,
      internalKey: json['internal_key'] as String?,
      merkleRoot: json['merkle_root'] as String?,
      tapscriptSibling: json['tapscript_sibling'] as String?,
      blockHeight: json['block_height'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anchor_tx': anchorTx,
      'anchor_block_hash': anchorBlockHash,
      'anchor_outpoint': anchorOutpoint,
      'internal_key': internalKey,
      'merkle_root': merkleRoot,
      'tapscript_sibling': tapscriptSibling,
      'block_height': blockHeight,
    };
  }
}
