import 'dart:convert';

class IONData {
  String did;
  String username;
  String publicIONKey;
  String privateIONKey;
  String customToken;

  IONData({
    required this.did,
    required this.username,
    required this.customToken,
    required this.publicIONKey,
    required this.privateIONKey,
  });

  factory IONData.fromJson(Map<String, dynamic> json) {
    return IONData(
      did: json['did'].toString(),
      username: json['username'].toString(),
      privateIONKey: json['privateKey'].toString(),
      publicIONKey: json['publicKey'].toString(),
      customToken: json['customToken'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'did': did,
      'username': username,
      'publicKey': publicIONKey,
      'privateKey': privateIONKey,
      'customToken': customToken,
    };
  }

  factory IONData.fromMap(Map<String, dynamic> map) {
    return IONData(
      did: map['did'],
      username: map['username'],
      publicIONKey: map['publicKey'],
      privateIONKey: map['privateKey'],
      customToken: map['customToken'],
    );
  }

  // Add this method
  @override
  String toString() {
    return jsonEncode(toMap());
  }
}
