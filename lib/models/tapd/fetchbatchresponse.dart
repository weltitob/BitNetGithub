import 'package:bitnet/models/tapd/batch.dart';

class FetchBatchResponse {
  final List<Batch> batches;

  FetchBatchResponse({
    required this.batches,
  });

  factory FetchBatchResponse.fromJson(Map<String, dynamic> json) {
    var batchesJson = json['batches'] as List;
    List<Batch> batchesList =
        batchesJson.map((i) => Batch.fromJson(i)).toList();

    return FetchBatchResponse(
      batches: batchesList,
    );
  }

  Map<String, dynamic> toJson() => {
        'batches': batches.map((e) => e.toJson()).toList(),
      };
}
