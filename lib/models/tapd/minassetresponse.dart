import 'package:bitnet/models/tapd/pendingbatch.dart';

class MintAssetResponse {
  final PendingBatch pendingBatch;

  MintAssetResponse({
    required this.pendingBatch,
  });

  factory MintAssetResponse.fromJson(Map<String, dynamic> json) {
    return MintAssetResponse(
      pendingBatch: PendingBatch.fromJson(json['pending_batch']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending_batch': pendingBatch.toJson(),
    };
  }
}
