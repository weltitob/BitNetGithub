class UserWallet {
  String walletAdress;
  String walletType;
  String walletBalance;
  String privateKey;
  String email;
  String useruid;

  UserWallet({
    required this.walletAdress,
    required this.walletType,
    required this.walletBalance,
    required this.privateKey,
    required this.email,
    required this.useruid,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) {
    return UserWallet(
      walletAdress: json['walletAdress'].toString(),
      walletType: json['walletType'].toString(),
      walletBalance: json['walletBalance'].toString(),
      privateKey: json['privateKey'].toString(),
      email: json['email'].toString(),
      useruid: json['useruid'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'walletAdress': walletAdress,
      'walletType': walletType,
      'walletBalance': walletBalance,
      'privateKey': privateKey,
      'email': email,
      'useruid': useruid,
    };
  }

  UserWallet copyWith({
    String? walletAdress,
    String? walletType,
    String? walletBalance,
    String? privateKey,
    String? email,
    String? useruid,
  }) {
    return UserWallet(
      walletAdress: walletAdress ?? this.walletAdress,
      walletType: walletType ?? this.walletType,
      walletBalance: walletType ?? this.walletBalance,
      privateKey: privateKey ?? this.privateKey,
      email: email ?? this.email,
      useruid: email ?? this.useruid,
    );
  }
}
