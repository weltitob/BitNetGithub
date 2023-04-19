class createDIDCallback {
  String did;
  String username;
  String publicIONKey;
  String privateIONKey;
  String customToken;

  createDIDCallback({
    required this.did,
    required this.username,
    required this.customToken,
    required this.publicIONKey,
    required this.privateIONKey,
  });

  factory createDIDCallback.fromJson(Map<String, dynamic> json) {
    return createDIDCallback(
      did: json['did'].toString(),
      username: json['username'].toString(),
      privateIONKey: json['privateKey'].toString(),
      publicIONKey: json['publicKey'].toString(),
      customToken: json['customToken'].toString(),
    );
  }
}