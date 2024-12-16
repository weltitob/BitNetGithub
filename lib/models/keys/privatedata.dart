class PrivateData {
  String
      mnemonic; //izak: we need some way to keep track of the mnemonic as we will be using it across the app for the new onchain wallet system
  // Constructor that creates a [PrivateData] instance.
  PrivateData({required this.mnemonic});

  // Factory method that creates a [PrivateData] instance from a JSON map.
  factory PrivateData.fromJson(Map<String, dynamic> json) {
    return PrivateData(mnemonic: json['mnemonic'].toString());
  }

  // Method that converts a [PrivateData] instance to a map.
  Map<String, dynamic> toMap() {
    return {'mnemonic': mnemonic};
  }

  // Factory method that creates a [PrivateData] instance from a map.
  factory PrivateData.fromMap(Map<String, dynamic> map) {
    return PrivateData(mnemonic: map['mnemonic'] ?? '');
  }

  // Method that creates a copy of a [PrivateData] instance with new values.
  PrivateData copyWith({
    String? did,
    String? privateKey,
    String? mnemonic,
  }) {
    return PrivateData(mnemonic: mnemonic ?? this.mnemonic);
  }
}
