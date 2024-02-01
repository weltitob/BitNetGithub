import 'package:flutter/material.dart';

class OnchainBalance {
  String totalBalance;
  String confirmedBalance;
  String unconfirmedBalance;
  String lockedBalance;
  String reservedBalanceAnchorChan;
  String accountBalance; // Assuming AccountBalanceEntry is represented as a string

  OnchainBalance({
    required this.totalBalance,
    required this.confirmedBalance,
    required this.unconfirmedBalance,
    required this.lockedBalance,
    required this.reservedBalanceAnchorChan,
    required this.accountBalance,
  });

  // From JSON
  factory OnchainBalance.fromJson(Map<String, dynamic> json) {
    return OnchainBalance(
      totalBalance: json['total_balance'].toString(),
      confirmedBalance: json['confirmed_balance'].toString(),
      unconfirmedBalance: json['unconfirmed_balance'].toString(),
      lockedBalance: json['locked_balance'].toString(),
      reservedBalanceAnchorChan: json['reserved_balance_anchor_chan'].toString(),
      accountBalance: json['account_balance'].toString(), // Adjust if AccountBalanceEntry has a specific structure
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'total_balance': totalBalance,
      'confirmed_balance': confirmedBalance,
      'unconfirmed_balance': unconfirmedBalance,
      'locked_balance': lockedBalance,
      'reserved_balance_anchor_chan': reservedBalanceAnchorChan,
      'account_balance': accountBalance,
    };
  }
}
