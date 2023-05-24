class QR_PrivateKey {
  String did; // The decentralized identifier (DID) associated with the private data.
  String privateKey; // The private key associated with the private data.

  // Constructor that creates a [QRCodePrivateData] instance.
  QR_PrivateKey({
    required this.did,
    required this.privateKey,
  });

  // Factory method that creates a [QRCodePrivateData] instance from a JSON map.
  factory QR_PrivateKey.fromJson(Map<String, dynamic> json) {
    return QR_PrivateKey(
      did: json['did'].toString(),
      privateKey: json['privateKey'].toString(),
    );
  }

  // Method that converts a [QRCodePrivateData] instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'did': did,
      'privateKey': privateKey,
    };
  }

  // Factory method that creates a [QRCodePrivateData] instance from a map.
  factory QR_PrivateKey.fromMap(Map<String, dynamic> map) {
    return QR_PrivateKey(
      did: map['did'] ?? '',
      privateKey: map['privateKey'] ?? '',
    );
  }

  // Method that creates a copy of a [QRCodePrivateData] instance with new values.
  QR_PrivateKey copyWith({
    String? did,
    String? privateKey,
  }) {
    return QR_PrivateKey(
      did: did ?? this.did,
      privateKey: privateKey ?? this.privateKey,
    );
  }
}
