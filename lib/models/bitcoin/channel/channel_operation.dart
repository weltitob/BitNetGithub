import 'package:cloud_firestore/cloud_firestore.dart';

/// Model for channel opening/closing operations to track in activity feed
class ChannelOperation {
  final String channelId;
  final String remoteNodeId;
  final String remoteNodeAlias;
  final int capacity;
  final int localBalance;
  final int pushAmount;
  final int timestamp;
  final ChannelOperationStatus status;
  final ChannelOperationType type;
  final String? txHash;
  final String? channelPoint;
  final bool isPrivate;
  final String? errorMessage;
  final Map<String, dynamic>? metadata;

  ChannelOperation({
    required this.channelId,
    required this.remoteNodeId,
    required this.remoteNodeAlias,
    required this.capacity,
    required this.localBalance,
    required this.pushAmount,
    required this.timestamp,
    required this.status,
    required this.type,
    this.txHash,
    this.channelPoint,
    this.isPrivate = false,
    this.errorMessage,
    this.metadata,
  });

  factory ChannelOperation.fromFirestore(Map<String, dynamic> data) {
    return ChannelOperation(
      channelId: data['channel_id'] ?? '',
      remoteNodeId: data['remote_node_id'] ?? '',
      remoteNodeAlias: data['remote_node_alias'] ?? 'Unknown',
      capacity: data['capacity'] ?? 0,
      localBalance: data['local_balance'] ?? 0,
      pushAmount: data['push_amount'] ?? 0,
      timestamp: data['timestamp'] ?? 0,
      status: ChannelOperationStatus.fromString(data['status'] ?? 'pending'),
      type: ChannelOperationType.fromString(data['type'] ?? 'open'),
      txHash: data['tx_hash'],
      channelPoint: data['channel_point'],
      isPrivate: data['is_private'] ?? false,
      errorMessage: data['error_message'],
      metadata: data['metadata'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'channel_id': channelId,
      'remote_node_id': remoteNodeId,
      'remote_node_alias': remoteNodeAlias,
      'capacity': capacity,
      'local_balance': localBalance,
      'push_amount': pushAmount,
      'timestamp': timestamp,
      'status': status.value,
      'type': type.value,
      if (txHash != null) 'tx_hash': txHash,
      if (channelPoint != null) 'channel_point': channelPoint,
      'is_private': isPrivate,
      if (errorMessage != null) 'error_message': errorMessage,
      if (metadata != null) 'metadata': metadata,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }

  ChannelOperation copyWith({
    String? channelId,
    String? remoteNodeId,
    String? remoteNodeAlias,
    int? capacity,
    int? localBalance,
    int? pushAmount,
    int? timestamp,
    ChannelOperationStatus? status,
    ChannelOperationType? type,
    String? txHash,
    String? channelPoint,
    bool? isPrivate,
    String? errorMessage,
    Map<String, dynamic>? metadata,
  }) {
    return ChannelOperation(
      channelId: channelId ?? this.channelId,
      remoteNodeId: remoteNodeId ?? this.remoteNodeId,
      remoteNodeAlias: remoteNodeAlias ?? this.remoteNodeAlias,
      capacity: capacity ?? this.capacity,
      localBalance: localBalance ?? this.localBalance,
      pushAmount: pushAmount ?? this.pushAmount,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      type: type ?? this.type,
      txHash: txHash ?? this.txHash,
      channelPoint: channelPoint ?? this.channelPoint,
      isPrivate: isPrivate ?? this.isPrivate,
      errorMessage: errorMessage ?? this.errorMessage,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Get display title for the activity feed
  String get displayTitle {
    switch (type) {
      case ChannelOperationType.open:
        return 'Channel Opening';
      case ChannelOperationType.close:
        return 'Channel Closing';
      case ChannelOperationType.forceClose:
        return 'Force Closing Channel';
      case ChannelOperationType.existing:
        return 'Existing Channel Detected';
    }
  }

  /// Get display subtitle for the activity feed
  String get displaySubtitle {
    return remoteNodeAlias;
  }

  /// Get status message for detailed view
  String get statusMessage {
    switch (status) {
      case ChannelOperationStatus.pending:
        return 'Waiting for blockchain confirmation...';
      case ChannelOperationStatus.opening:
        return 'Channel is being opened on-chain...';
      case ChannelOperationStatus.active:
        return 'Channel is active and ready for payments';
      case ChannelOperationStatus.closing:
        return 'Channel is being closed...';
      case ChannelOperationStatus.closed:
        return 'Channel has been closed';
      case ChannelOperationStatus.failed:
        return errorMessage ?? 'Channel operation failed';
    }
  }
}

enum ChannelOperationStatus {
  pending('pending'),
  opening('opening'),
  active('active'),
  closing('closing'),
  closed('closed'),
  failed('failed');

  final String value;
  const ChannelOperationStatus(this.value);

  static ChannelOperationStatus fromString(String status) {
    return ChannelOperationStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => ChannelOperationStatus.pending,
    );
  }
}

enum ChannelOperationType {
  open('open'),
  close('close'),
  forceClose('force_close'),
  existing('existing');

  final String value;
  const ChannelOperationType(this.value);

  static ChannelOperationType fromString(String type) {
    return ChannelOperationType.values.firstWhere(
      (e) => e.value == type,
      orElse: () => ChannelOperationType.open,
    );
  }
}
