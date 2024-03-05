import 'package:intl/intl.dart';

String getCurrency(String cuName) {
  var format = NumberFormat.simpleCurrency(name: cuName);

  return format.currencySymbol;
}