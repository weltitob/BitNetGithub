class LitdAccountResponse {
  final Account? account;
  final String? macaroon;

  LitdAccountResponse({this.account, this.macaroon});

  factory LitdAccountResponse.fromJson(Map<String, dynamic> json) {
    return LitdAccountResponse(
      account:
          json['account'] != null ? Account.fromJson(json['account']) : null,
      macaroon: json['macaroon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account': account?.toJson(),
      'macaroon': macaroon,
    };
  }
}

class Account {
  final String? id;
  final String? initialBalance;
  final String? currentBalance;
  final String? lastUpdate;
  final String? expirationDate;
  final List<dynamic>? invoices;
  final List<dynamic>? payments;
  final String? label;

  Account({
    this.id,
    this.initialBalance,
    this.currentBalance,
    this.lastUpdate,
    this.expirationDate,
    this.invoices,
    this.payments,
    this.label,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      initialBalance: json['initial_balance'],
      currentBalance: json['current_balance'],
      lastUpdate: json['last_update'],
      expirationDate: json['expiration_date'],
      invoices: json['invoices'] ?? [],
      payments: json['payments'] ?? [],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'initial_balance': initialBalance,
      'current_balance': currentBalance,
      'last_update': lastUpdate,
      'expiration_date': expirationDate,
      'invoices': invoices,
      'payments': payments,
      'label': label,
    };
  }
}
