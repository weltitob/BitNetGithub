class UserWallet {
  String walletAddress;
  String walletType;
  String walletBalance;
  String privateKey;
  String email;
  String useruid;

  // constructor
  UserWallet({
    required this.walletAddress,
    required this.walletType,
    required this.walletBalance,
    required this.privateKey,
    required this.email,
    required this.useruid,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) {
    return UserWallet(
      walletAddress: json['walletAddress'].toString(),
      walletType: json['walletType'].toString(),
      walletBalance: json['walletBalance'].toString(),
      privateKey: json['privateKey'].toString(),
      email: json['email'].toString(),
      useruid: json['useruid'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'walletAddress': walletAddress,
      'walletType': walletType,
      'walletBalance': walletBalance,
      'privateKey': privateKey,
      'email': email,
      'useruid': useruid,
    };
  }

  factory UserWallet.fromMap(Map<String, dynamic> map) {
    return UserWallet(
      walletAddress: map['walletAddress'] ?? '',
      walletType: map['walletType'] ?? '',
      walletBalance: map['walletBalance'] ?? '',
      privateKey: map['privateKey'] ?? '',
      email: map['email'] ?? '',
      useruid: map['useruid'] ?? '',
    );
  }

  UserWallet copyWith({
    String? walletAddress,
    String? walletType,
    String? walletBalance,
    String? privateKey,
    String? email,
    String? useruid,
  }) {
    return UserWallet(
      walletAddress: walletAddress ?? this.walletAddress,
      walletType: walletType ?? this.walletType,
      walletBalance: walletType ?? this.walletBalance,
      privateKey: privateKey ?? this.privateKey,
      email: email ?? this.email,
      useruid: useruid ?? this.useruid,
    );
  }
}
