import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nexus_wallet/components/chart.dart';

/*
 This class represents a stream that periodically fetches the current price of Bitcoin in Euro from a REST API.
 It uses a StreamController to emit ChartLine objects, which contain the timestamp and the price of the fetched data.
 The price is fetched every 12 seconds using a Timer, and the result is sent to the StreamController.
 The start() method starts the timer and begins the stream, while the stop() method cancels the timer and closes the stream.
 If there is an error fetching the price, it is caught and printed to the console.
 */
class BitcoinPriceStream {
  final String _url = 'https://api.coingecko.com/api/v3/simple/price';
  StreamController<ChartLine> _priceController = StreamController<ChartLine>();
  late Timer _timer;
  Duration _updateInterval = Duration(seconds: 12);

  Stream<ChartLine> get priceStream => _priceController.stream;

  // This function starts the Bitcoin price stream by creating a Timer that periodically fetches the Bitcoin price from Coingecko API
  void start() {
    _timer = Timer.periodic(_updateInterval, (_) async {
      try {
        final Map<String, String> params = {
          'ids': 'bitcoin',
          'vs_currencies': 'eur',
          'include_last_updated_at': 'true'
        };
        // Fetch the Bitcoin price from the Coingecko API using the HTTP GET method
        final response = await get(
            Uri.parse(_url).replace(queryParameters: params),
            headers: {});
        // If the response status code is 200, then parse the response body and send the Bitcoin price to the stream
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
          // If the response status code is not 200, then log an error message
          print("An Error occured trying to livefetch the bitcoinprice");
          print('Error ${response.statusCode}: ${response.reasonPhrase}');
        }
      } catch (e) {
        // If an error occurs while fetching the Bitcoin price, then log an error message
        print('Error fetching Bitcoin price: $e');
      }
    });
  }

  // This function stops the Bitcoin price stream by canceling the Timer and closing the StreamController
  void stop() {
    _timer.cancel();
    _priceController.close();
  }
}