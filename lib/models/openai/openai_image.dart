// This class defines a callback that contains status and message strings
class OpenAiCallback {
  String timestamp;
  String imageurl;

  // Constructor that initializes status and message strings
  OpenAiCallback({
    required this.timestamp,
    required this.imageurl,
  });

  // Factory method to create a CloudfunctionCallback instance from a JSON map
  factory OpenAiCallback.fromJson(Map<String, dynamic> json) {
    return OpenAiCallback(
      timestamp: json['created'].toString(),
      imageurl: json['data'][0]['url'].toString(),
    );
  }

  // Method to convert a CloudfunctionCallback instance to a map
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'imageurl': imageurl,
    };
  }

  // Method to create a new CloudfunctionCallback instance from the existing instance with updated values
  OpenAiCallback copyWith({
    String? timestamp,
    String? imageurl,
  }) {
    return OpenAiCallback(
      timestamp: timestamp ?? this.timestamp,
      imageurl: imageurl ?? this.imageurl,
    );
  }
}
