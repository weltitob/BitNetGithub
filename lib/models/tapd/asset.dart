import 'dart:convert';

class Asset {
  String version;
  AssetGenesis assetGenesis;
  String amount;
  int lockTime;
  int relativeLockTime;
  int scriptVersion;
  String scriptKey;
  bool scriptKeyIsLocal;
  dynamic assetGroup;
  ChainAnchor chainAnchor;
  List<dynamic> prevWitnesses;
  bool isSpent;
  String leaseOwner;
  String leaseExpiry;
  bool isBurn;

  Asset({
    required this.version,
    required this.assetGenesis,
    required this.amount,
    required this.lockTime,
    required this.relativeLockTime,
    required this.scriptVersion,
    required this.scriptKey,
    required this.scriptKeyIsLocal,
    required this.assetGroup,
    required this.chainAnchor,
    required this.prevWitnesses,
    required this.isSpent,
    required this.leaseOwner,
    required this.leaseExpiry,
    required this.isBurn,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      version: json['version'],
      assetGenesis: AssetGenesis.fromJson(json['asset_genesis']),
      amount: json['amount'],
      lockTime: json['lock_time'],
      relativeLockTime: json['relative_lock_time'],
      scriptVersion: json['script_version'],
      scriptKey: json['script_key'],
      scriptKeyIsLocal: json['script_key_is_local'],
      assetGroup: json['asset_group'],
      chainAnchor: ChainAnchor.fromJson(json['chain_anchor']),
      prevWitnesses: List<dynamic>.from(json['prev_witnesses']),
      isSpent: json['is_spent'],
      leaseOwner: json['lease_owner'],
      leaseExpiry: json['lease_expiry'],
      isBurn: json['is_burn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'asset_genesis': assetGenesis.toJson(),
      'amount': amount,
      'lock_time': lockTime,
      'relative_lock_time': relativeLockTime,
      'script_version': scriptVersion,
      'script_key': scriptKey,
      'script_key_is_local': scriptKeyIsLocal,
      'asset_group': assetGroup,
      'chain_anchor': chainAnchor.toJson(),
      'prev_witnesses': prevWitnesses,
      'is_spent': isSpent,
      'lease_owner': leaseOwner,
      'lease_expiry': leaseExpiry,
      'is_burn': isBurn,
    };
  }
}

class AssetGenesis {
  String genesisPoint;
  String name;
  String metaHash;
  String assetId;
  String assetType;
  int outputIndex;
  int version;

  AssetGenesis({
    required this.genesisPoint,
    required this.name,
    required this.metaHash,
    required this.assetId,
    required this.assetType,
    required this.outputIndex,
    required this.version,
  });

  factory AssetGenesis.fromJson(Map<String, dynamic> json) {
    return AssetGenesis(
      genesisPoint: json['genesis_point'],
      name: json['name'],
      metaHash: json['meta_hash'],
      assetId: json['asset_id'],
      assetType: json['asset_type'],
      outputIndex: json['output_index'],
      version: json['version'],
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
  String anchorTx;
  String anchorBlockHash;
  String anchorOutpoint;
  String internalKey;
  String merkleRoot;
  String tapscriptSibling;
  int blockHeight;

  ChainAnchor({
    required this.anchorTx,
    required this.anchorBlockHash,
    required this.anchorOutpoint,
    required this.internalKey,
    required this.merkleRoot,
    required this.tapscriptSibling,
    required this.blockHeight,
  });

  factory ChainAnchor.fromJson(Map<String, dynamic> json) {
    return ChainAnchor(
      anchorTx: json['anchor_tx'],
      anchorBlockHash: json['anchor_block_hash'],
      anchorOutpoint: json['anchor_outpoint'],
      internalKey: json['internal_key'],
      merkleRoot: json['merkle_root'],
      tapscriptSibling: json['tapscript_sibling'],
      blockHeight: json['block_height'],
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

