const String key = 'b16be475b04d4272b9a06fcb2b4c0bbd';

class AppUrl {
  static const String baseUrl = 'https://openexchangerates.org/api/';
  static const String currenciesUrl = '${baseUrl}currencies.json?app_id=$key';
  static const String ratesUrl = '${baseUrl}latest.json?base=USD&app_id=$key';
}