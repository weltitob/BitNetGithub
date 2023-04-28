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
}