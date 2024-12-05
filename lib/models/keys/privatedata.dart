class PrivateData {
  String did; // The decentralized identifier (DID) associated with the private data.
  String privateKey; // The private key associated with the private data.

  // Constructor that creates a [PrivateData] instance.
  PrivateData({
    required this.did,
    required this.privateKey,
  });

  // Factory method that creates a [PrivateData] instance from a JSON map.
  factory PrivateData.fromJson(Map<String, dynamic> json) {
    return PrivateData(
      did: json['did'].toString(),
      privateKey: json['privateKey'].toString(),
    );
  }

  // Method that converts a [PrivateData] instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'did': did,
      'privateKey': privateKey,
    };
  }

  // Factory method that creates a [PrivateData] instance from a map.
  factory PrivateData.fromMap(Map<String, dynamic> map) {
    return PrivateData(
      did: map['did'] ?? '',
      privateKey: map['privateKey'] ?? '',
    );
  }

  // Method that creates a copy of a [PrivateData] instance with new values.
  PrivateData copyWith({
    String? did,
    String? privateKey,
  }) {
    return PrivateData(
      did: did ?? this.did,
      privateKey: privateKey ?? this.privateKey,
    );
  }
}
