import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/currency/currencies_model.dart';
import 'package:bitnet/models/currency/rates_model.dart';
import 'package:http/http.dart' as http;



Future<RatesModel> fetchRates() async {
  var response = await http.get(Uri.parse(AppTheme.ratesUrl));
  final ratesModel = ratesModelFromJson(response.body);
  return ratesModel;
}

