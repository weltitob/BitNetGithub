class TransactionStatus {
  String status;
  String message;

  TransactionStatus({
    required this.status,
    required this.message,
  });

  factory TransactionStatus.fromJson(Map<String, dynamic> json) {
    return TransactionStatus(
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

  TransactionStatus copyWith({
    String? status,
    String? message,
  }) {
    return TransactionStatus(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
