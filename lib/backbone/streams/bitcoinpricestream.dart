import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nexus_wallet/components/chart.dart';

class BitcoinPriceStream {
  final String _url = 'https://api.coingecko.com/api/v3/simple/price';
  StreamController<ChartLine> _priceController = StreamController<ChartLine>();
  late Timer _timer;
  Duration _updateInterval = Duration(seconds: 5);

  Stream<ChartLine> get priceStream => _priceController.stream;

  void start() {
    _timer = Timer.periodic(_updateInterval, (_) async {
      try {
        final Map<String, String> params = {
          'ids': 'bitcoin',
          'vs_currencies': 'eur',
          'include_last_updated_at': 'true'
        };
        final response = await get(
            Uri.parse(_url).replace(queryParameters: params),
            headers: {});
        final data = jsonDecode(response.body);
        String price = data['bitcoin']['eur'].toString();
        final time = data['bitcoin']['last_updated_at'].toString();
        print('The current price of Bitcoin in Euro is $price');
        double priceasdouble = double.parse(price);
        double timeasdouble = double.parse(time);
        final ChartLine latestchart =
            ChartLine(time: timeasdouble, price: priceasdouble);
        print(latestchart);
        _priceController.add(latestchart);
      } catch (e) {
        print('Error fetching Bitcoin price: $e');
      }
    });
  }

  void stop() {
    _timer.cancel();
    _priceController.close();
  }
}
