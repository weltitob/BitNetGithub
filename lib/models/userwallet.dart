class UserWallet {
  String walletAdress;
  String walletType;
  String seedPhrases;
  String email;

  UserWallet({
    required this.walletAdress,
    required this.walletType,
    required this.seedPhrases,
    required this.email,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) {
    return UserWallet(
      walletAdress: json['walletAdress'].toString(),
      walletType: json['walletType'].toString(),
      seedPhrases: json['seedPhrases'].toString(),
      email: json['email'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'walletAdress': walletAdress,
      'walletType': walletType,
      'seedPhrases': seedPhrases,
      'email': email,
    };
  }

  UserWallet copyWith({
    String? walletAdress,
    String? walletType,
    String? seedPhrases,
    String? email,
  }) {
    return UserWallet(
      walletAdress: walletAdress ?? this.walletAdress,
      walletType: walletType ?? this.walletType,
      seedPhrases: seedPhrases ?? this.seedPhrases,
      email: email ?? this.email,
    );
  }
}
