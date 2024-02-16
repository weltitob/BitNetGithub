class RestResponse {
  String statusCode;
  String message;
  Map<String, dynamic> data;

  // Constructor that initializes status, message, and data
  RestResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  // Factory method to create a CloudfunctionCallback instance from a JSON map
  factory RestResponse.fromJson(Map<String, dynamic> json) {
    return RestResponse(
      statusCode: json['statusCode'].toString(),
      message: json['message'].toString(),
      data: json['data'] ?? {},
    );
  }

  // Method to convert a CloudfunctionCallback instance to a map
  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data,
    };
  }

  // Method to create a new CloudfunctionCallback instance from the existing instance with updated values
  RestResponse copyWith({
    String? statusCode,
    String? message,
    Map<String, dynamic>? data,
  }) {
    return RestResponse(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'RestResponse{statusCode: $statusCode, message: $message, data: $data}';
  }
}
