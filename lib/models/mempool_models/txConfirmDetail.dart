// To parse this JSON data, do
//
//     final transactionConfirmedDetail = transactionConfirmedDetailFromJson(jsonString);

import 'dart:convert';

TransactionConfirmedDetail transactionConfirmedDetailFromJson(String str) =>
    TransactionConfirmedDetail.fromJson(json.decode(str));

String transactionConfirmedDetailToJson(TransactionConfirmedDetail data) =>
    json.encode(data.toJson());

class TransactionConfirmedDetail {
  String id;
  int height;
  int version;
  int timestamp;
  int bits;
  int nonce;
  double difficulty;
  String merkleRoot;
  int txCount;
  int size;
  int weight;
  String previousblockhash;
  int mediantime;
  bool stale;
  Extras extras;

  TransactionConfirmedDetail({
    required this.id,
    required this.height,
    required this.version,
    required this.timestamp,
    required this.bits,
    required this.nonce,
    required this.difficulty,
    required this.merkleRoot,
    required this.txCount,
    required this.size,
    required this.weight,
    required this.previousblockhash,
    required this.mediantime,
    required this.stale,
    required this.extras,
  });

  factory TransactionConfirmedDetail.fromJson(Map<String, dynamic> json) =>
      TransactionConfirmedDetail(
        id: json["id"],
        height: json["height"],
        version: json["version"],
        timestamp: json["timestamp"],
        bits: json["bits"],
        nonce: json["nonce"],
        difficulty: json["difficulty"]?.toDouble(),
        merkleRoot: json["merkle_root"],
        txCount: json["tx_count"],
        size: json["size"],
        weight: json["weight"],
        previousblockhash: json["previousblockhash"],
        mediantime: json["mediantime"],
        stale: json["stale"] == null ? false : json["stale"],
        extras: Extras.fromJson(json["extras"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "height": height,
        "version": version,
        "timestamp": timestamp,
        "bits": bits,
        "nonce": nonce,
        "difficulty": difficulty,
        "merkle_root": merkleRoot,
        "tx_count": txCount,
        "size": size,
        "weight": weight,
        "previousblockhash": previousblockhash,
        "mediantime": mediantime,
        "stale": stale,
        "extras": extras.toJson(),
      };
}

class Extras {
  int reward;
  String coinbaseRaw;
  List<dynamic> orphans;
  double medianFee;
  List<double> feeRange;
  int totalFees;
  int avgFee;
  int avgFeeRate;
  int utxoSetChange;
  double avgTxSize;
  int totalInputs;
  int totalOutputs;
  int totalOutputAmt;
  int segwitTotalTxs;
  int segwitTotalSize;
  int segwitTotalWeight;
  dynamic feePercentiles;
  double virtualSize;
  String coinbaseAddress;
  String coinbaseSignature;
  String coinbaseSignatureAscii;
  String header;
  dynamic utxoSetSize;
  dynamic totalInputAmt;
  Pool pool;
  double matchRate;
  int expectedFees;
  int expectedWeight;
  double similarity;

  Extras({
    required this.reward,
    required this.coinbaseRaw,
    required this.orphans,
    required this.medianFee,
    required this.feeRange,
    required this.totalFees,
    required this.avgFee,
    required this.avgFeeRate,
    required this.utxoSetChange,
    required this.avgTxSize,
    required this.totalInputs,
    required this.totalOutputs,
    required this.totalOutputAmt,
    required this.segwitTotalTxs,
    required this.segwitTotalSize,
    required this.segwitTotalWeight,
    required this.feePercentiles,
    required this.virtualSize,
    required this.coinbaseAddress,
    required this.coinbaseSignature,
    required this.coinbaseSignatureAscii,
    required this.header,
    required this.utxoSetSize,
    required this.totalInputAmt,
    required this.pool,
    required this.matchRate,
    required this.expectedFees,
    required this.expectedWeight,
    required this.similarity,
  });

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
        reward: json["reward"],
        coinbaseRaw: json["coinbaseRaw"],
        orphans: List<dynamic>.from(json["orphans"].map((x) => x)),
        medianFee: json["medianFee"]?.toDouble(),
        feeRange: List<double>.from(json["feeRange"].map((x) => x?.toDouble())),
        totalFees: json["totalFees"],
        avgFee: json["avgFee"],
        avgFeeRate: json["avgFeeRate"],
        utxoSetChange: json["utxoSetChange"],
        avgTxSize: json["avgTxSize"]?.toDouble(),
        totalInputs: json["totalInputs"],
        totalOutputs: json["totalOutputs"],
        totalOutputAmt: json["totalOutputAmt"],
        segwitTotalTxs: json["segwitTotalTxs"],
        segwitTotalSize: json["segwitTotalSize"],
        segwitTotalWeight: json["segwitTotalWeight"],
        feePercentiles: json["feePercentiles"],
        virtualSize: json["virtualSize"]?.toDouble(),
        coinbaseAddress: json["coinbaseAddress"],
        coinbaseSignature: json["coinbaseSignature"],
        coinbaseSignatureAscii: json["coinbaseSignatureAscii"],
        header: json["header"],
        utxoSetSize: json["utxoSetSize"],
        totalInputAmt: json["totalInputAmt"],
        pool: Pool.fromJson(json["pool"]),
        matchRate: json["matchRate"]?.toDouble() ?? 0.0,
        expectedFees: json["expectedFees"],
        expectedWeight: json["expectedWeight"],
        similarity: json["similarity"]?.toDouble() == null
            ? 0.0
            : json["similarity"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "reward": reward,
        "coinbaseRaw": coinbaseRaw,
        "orphans": List<dynamic>.from(orphans.map((x) => x)),
        "medianFee": medianFee,
        "feeRange": List<dynamic>.from(feeRange.map((x) => x)),
        "totalFees": totalFees,
        "avgFee": avgFee,
        "avgFeeRate": avgFeeRate,
        "utxoSetChange": utxoSetChange,
        "avgTxSize": avgTxSize,
        "totalInputs": totalInputs,
        "totalOutputs": totalOutputs,
        "totalOutputAmt": totalOutputAmt,
        "segwitTotalTxs": segwitTotalTxs,
        "segwitTotalSize": segwitTotalSize,
        "segwitTotalWeight": segwitTotalWeight,
        "feePercentiles": feePercentiles,
        "virtualSize": virtualSize,
        "coinbaseAddress": coinbaseAddress,
        "coinbaseSignature": coinbaseSignature,
        "coinbaseSignatureAscii": coinbaseSignatureAscii,
        "header": header,
        "utxoSetSize": utxoSetSize,
        "totalInputAmt": totalInputAmt,
        "pool": pool.toJson(),
        "matchRate": matchRate,
        "expectedFees": expectedFees,
        "expectedWeight": expectedWeight,
        "similarity": similarity,
      };
}

class Pool {
  int id;
  String name;
  String slug;

  Pool({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Pool.fromJson(Map<String, dynamic> json) => Pool(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}
