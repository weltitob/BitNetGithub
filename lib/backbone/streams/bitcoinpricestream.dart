import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nexus_wallet/components/chart.dart';

class BitcoinPriceStream {
  final String _url = 'https://api.coingecko.com/api/v3/simple/price';
  StreamController<ChartLine> _priceController = StreamController<ChartLine>();
  late Timer _timer;
  Duration _updateInterval = Duration(seconds: 12);

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
        if (response.statusCode == 200) {
          print('Getting BTC price...');
          String price = jsonDecode(response.body)['bitcoin']['eur'].toString();
          final time = jsonDecode(response.body)['bitcoin']['last_updated_at']
              .toString();
          double priceasdouble = double.parse(price);
          double timeasdouble = double.parse(time);
          final ChartLine latestchart =
          ChartLine(time: timeasdouble, price: priceasdouble);
          _priceController.add(latestchart);
          print('The current price of Bitcoin in Euro is $price');
        } else {
          print("An Error occured trying to livefetch the bitcoinprice");
          print('Error ${response.statusCode}: ${response.reasonPhrase}');
        }
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