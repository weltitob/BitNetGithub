import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getCurrency(String cuName) {
  var format = NumberFormat.simpleCurrency(name: cuName);

  return format.currencySymbol;
}

IconData getCurrencyIcon(String unit) {
  switch (unit) {
    case "BTC":
      return Icons.currency_bitcoin;
    case "SAT":
      return AppTheme.satoshiIcon;
    default:
      return Icons.error;
  }
}
