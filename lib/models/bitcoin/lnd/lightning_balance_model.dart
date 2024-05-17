
class LightningBalance {
  String balance;
  String pendingOpenBalance;
  String localBalance;
  String remoteBalance;
  String unsettledLocalBalance;
  String unsettledRemoteBalance;
  String pendingOpenLocalBalance;
  String pendingOpenRemoteBalance;

  LightningBalance({
    required this.balance,
    required this.pendingOpenBalance,
    required this.localBalance,
    required this.remoteBalance,
    required this.unsettledLocalBalance,
    required this.unsettledRemoteBalance,
    required this.pendingOpenLocalBalance,
    required this.pendingOpenRemoteBalance,
  });

  // From JSON
  factory LightningBalance.fromJson(Map<String, dynamic> json) {
    return LightningBalance(
      balance: json['balance'].toString(),
      pendingOpenBalance: json['pending_open_balance'].toString(),
      localBalance: json['local_balance'].toString(),
      remoteBalance: json['remote_balance'].toString(),
      unsettledLocalBalance: json['unsettled_local_balance'].toString(),
      unsettledRemoteBalance: json['unsettled_remote_balance'].toString(),
      pendingOpenLocalBalance: json['pending_open_local_balance'].toString(),
      pendingOpenRemoteBalance: json['pending_open_remote_balance'].toString(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'pending_open_balance': pendingOpenBalance,
      'local_balance': localBalance,
      'remote_balance': remoteBalance,
      'unsettled_local_balance': unsettledLocalBalance,
      'unsettled_remote_balance': unsettledRemoteBalance,
      'pending_open_local_balance': pendingOpenLocalBalance,
      'pending_open_remote_balance': pendingOpenRemoteBalance,
    };
  }
}
