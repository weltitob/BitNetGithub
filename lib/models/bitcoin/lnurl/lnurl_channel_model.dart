class LnurlChannelRequest {
  final String tag;
  final String k1;
  final String callback;
  final String uri;
  final String nodeId;
  final String? metadata;
  final int? localAmt;
  final int? pushAmt;

  LnurlChannelRequest({
    required this.tag,
    required this.k1,
    required this.callback,
    required this.uri,
    required this.nodeId,
    this.metadata,
    this.localAmt,
    this.pushAmt,
  });

  factory LnurlChannelRequest.fromJson(Map<String, dynamic> json) {
    return LnurlChannelRequest(
      tag: json['tag'] as String,
      k1: json['k1'] as String,
      callback: json['callback'] as String,
      uri: json['uri'] as String,
      nodeId: json['nodeId'] as String,
      metadata: json['metadata'] as String?,
      localAmt: json['localAmt'] as int?,
      pushAmt: json['pushAmt'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'k1': k1,
      'callback': callback,
      'uri': uri,
      'nodeId': nodeId,
      if (metadata != null) 'metadata': metadata,
      if (localAmt != null) 'localAmt': localAmt,
      if (pushAmt != null) 'pushAmt': pushAmt,
    };
  }
}

class LnurlChannelResponse {
  final String status;
  final String? reason;
  final String? event;

  LnurlChannelResponse({
    required this.status,
    this.reason,
    this.event,
  });

  factory LnurlChannelResponse.fromJson(Map<String, dynamic> json) {
    return LnurlChannelResponse(
      status: json['status'] as String,
      reason: json['reason'] as String?,
      event: json['event'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      if (reason != null) 'reason': reason,
      if (event != null) 'event': event,
    };
  }
}

class LnurlChannelResult {
  final bool success;
  final String message;
  final LnurlChannelRequest? channelRequest;
  final LnurlChannelResponse? channelResponse;

  LnurlChannelResult({
    required this.success,
    required this.message,
    this.channelRequest,
    this.channelResponse,
  });
}

class ChannelOpeningProgress {
  final String status;
  final String message;
  final double? progress;
  final bool isCompleted;
  final String? errorMessage;

  ChannelOpeningProgress({
    required this.status,
    required this.message,
    this.progress,
    this.isCompleted = false,
    this.errorMessage,
  });

  factory ChannelOpeningProgress.connecting() {
    return ChannelOpeningProgress(
      status: 'connecting',
      message: 'Connecting to Lightning Service Provider...',
      progress: 0.25,
    );
  }

  factory ChannelOpeningProgress.checkingConnection() {
    return ChannelOpeningProgress(
      status: 'checking_connection',
      message: 'Checking peer connection status...',
      progress: 0.20,
    );
  }

  factory ChannelOpeningProgress.claiming() {
    return ChannelOpeningProgress(
      status: 'claiming',
      message: 'Claiming channel...',
      progress: 0.50,
    );
  }

  factory ChannelOpeningProgress.opening() {
    return ChannelOpeningProgress(
      status: 'opening',
      message: 'Opening channel...',
      progress: 0.60,
    );
  }

  factory ChannelOpeningProgress.verifying() {
    return ChannelOpeningProgress(
      status: 'verifying',
      message: 'Verifying channel is active...',
      progress: 0.85,
    );
  }

  factory ChannelOpeningProgress.completed() {
    return ChannelOpeningProgress(
      status: 'completed',
      message: 'Channel opened and verified successfully!',
      progress: 1.0,
      isCompleted: true,
    );
  }

  factory ChannelOpeningProgress.error(String errorMessage) {
    return ChannelOpeningProgress(
      status: 'error',
      message: 'Failed to open channel',
      errorMessage: errorMessage,
      isCompleted: true,
    );
  }
}