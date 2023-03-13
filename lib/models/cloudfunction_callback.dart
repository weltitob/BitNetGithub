class CloudfunctionCallback {
  String status;
  String message;

  CloudfunctionCallback({
    required this.status,
    required this.message,
  });

  factory CloudfunctionCallback.fromJson(Map<String, dynamic> json) {
    return CloudfunctionCallback(
      status: json['status'].toString(),
      message: json['message'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  CloudfunctionCallback copyWith({
    String? status,
    String? message,
  }) {
    return CloudfunctionCallback(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
