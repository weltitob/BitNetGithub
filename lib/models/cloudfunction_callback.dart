// This class defines a callback that contains status and message strings 
class CloudfunctionCallback {
  String status;
  String message;

  // Constructor that initializes status and message strings
  CloudfunctionCallback({
    required this.status,
    required this.message,
  });

  // Factory method to create a CloudfunctionCallback instance from a JSON map
  factory CloudfunctionCallback.fromJson(Map<String, dynamic> json) {
    return CloudfunctionCallback(
      status: json['status'].toString(),
      message: json['message'].toString(),
    );
  }

  // Method to convert a CloudfunctionCallback instance to a map
  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  // Method to create a new CloudfunctionCallback instance from the existing instance with updated values
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