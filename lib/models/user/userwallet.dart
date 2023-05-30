class UserWallet {
  String walletAddress;
  String walletType;
  String walletBalance;
  String privateKey;
  String userdid;

  // constructor
  UserWallet({
    required this.walletAddress,
    required this.walletType,
    required this.walletBalance,
    required this.privateKey,
    required this.userdid,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) {
    return UserWallet(
      walletAddress: json['walletAddress'].toString(),
      walletType: json['walletType'].toString(),
      walletBalance: json['walletBalance'].toString(),
      privateKey: json['privateKey'].toString(),
      userdid: json['userdid'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'walletAddress': walletAddress,
      'walletType': walletType,
      'walletBalance': walletBalance,
      'privateKey': privateKey,
      'userdid': userdid,
    };
  }

  factory UserWallet.fromMap(Map<String, dynamic> map) {
    return UserWallet(
      walletAddress: map['walletAddress'] ?? '',
      walletType: map['walletType'] ?? '',
      walletBalance: map['walletBalance'] ?? '',
      privateKey: map['privateKey'] ?? '',
      userdid: map['userdid'] ?? '',
    );
  }

  UserWallet copyWith({
    String? walletAddress,
    String? walletType,
    String? walletBalance,
    String? privateKey,
    String? userdid,
  }) {
    return UserWallet(
      walletAddress: walletAddress ?? this.walletAddress,
      walletType: walletType ?? this.walletType,
      walletBalance: walletType ?? this.walletBalance,
      privateKey: privateKey ?? this.privateKey,
      userdid: userdid ?? this.userdid,
    );
  }
}
