
// This method is used to fetch the current Bitcoin price from the CoinGecko API.
import 'dart:convert';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:http/http.dart';

Future<double> getBitcoinPrice() async {
  final String url = '${AppTheme.baseUrlCoinGeckoApiPro}/simple/price?x_cg_pro_api_key=${AppTheme.coinGeckoApiKey}';

  final Map<String, String> params = {
    'ids': 'bitcoin',
    'vs_currencies': 'eur',
    'include_last_updated_at': 'true'
  };

  final response =
  await get(Uri.parse(url).replace(queryParameters: params), headers: {});
  if (response.statusCode == 200) {
    final bitcoinprice =
        double.parse(jsonDecode(response.body)['bitcoin']['eur'].toString());
    print('The current price of Bitcoin in Euro is $bitcoinprice');
    return bitcoinprice;
  } else {
    print(
        'Error beim Laden des Bitcoin Preises: ${response.statusCode}: ${response.reasonPhrase}');

      final moneyineur = "Ein Fehler ist aufgetreten";
      return 0.00;
  }
}