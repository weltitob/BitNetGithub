import 'dart:async';
import 'dart:convert';

import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:http/http.dart' as http;
import 'package:matrix/matrix.dart';

/*
This class represents a stream that periodically fetches the current price of Bitcoin in Euro from a REST API.
It uses a StreamController to emit ChartLine objects, which contain the timestamp and the price of the fetched data.
The price is fetched every 12 seconds using a Timer, and the result is sent to the StreamController.
The start() method starts the timer and begins the stream, while the stop() method cancels the timer and closes the stream.
If there is an error fetching the price, it is caught and printed to the console.
*/
// Stream<ChartLine> bitcoinPriceStream(Duration updateInterval) async* {
//   Timer.periodic(updateInterval, (Timer timer) async* {
//     Logs().w("Fetching Bitcoin price...");
//     try {
//       final Map<String, String> params = {
//         'ids': 'bitcoin',
//         'vs_currencies': 'eur',
//         'include_last_updated_at': 'true',
//       };
//       final response = await http.get(Uri.parse(AppTheme.baseUrlCoinGecko).replace(queryParameters: params));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final double price = double.parse(data['bitcoin']['eur'].toString());
//         final int lastUpdated = data['bitcoin']['last_updated_at'];
//         final ChartLine chartLine = ChartLine(time: DateTime.now().millisecondsSinceEpoch.toDouble(), price: price);
//         yield chartLine;
//       } else {
//         print('Error fetching data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   });
// }
//
//
// class BitcoinPriceStream {
//   final String _url = 'https://api.coingecko.com/api/v3/simple/price';
//   StreamController<ChartLine> _priceController = StreamController<ChartLine>();
//   late Timer _timer;
//   Duration _updateInterval = Duration(seconds: 10);
//
//   Stream<ChartLine> get priceStream => _priceController.stream;
//
//   // This function starts the Bitcoin price stream by creating a Timer that periodically fetches the Bitcoin price from Coingecko API
//   void start() {
//     _timer = Timer.periodic(_updateInterval, (_) async {
//       try {
//         final Map<String, String> params = {
//           'ids': 'bitcoin',
//           'vs_currencies': 'eur',
//           'include_last_updated_at': 'true'
//         };
//         // Fetch the Bitcoin price from the Coingecko API using the HTTP GET method
//         final response = await get(
//             Uri.parse(_url).replace(queryParameters: params),
//             headers: {});
//         // If the response status code is 200, then parse the response body and send the Bitcoin price to the stream
//         if (response.statusCode == 200) {
//           print('Getting BTC price...');
//           String price = jsonDecode(response.body)['bitcoin']['eur'].toString();
//           final time = jsonDecode(response.body)['bitcoin']['last_updated_at']
//               .toString();
//           double priceasdouble = double.parse(price);
//           double timeasdouble = double.parse(time);
//           final ChartLine latestchart =
//           ChartLine(time: timeasdouble, price: priceasdouble);
//           _priceController.add(latestchart);
//           print('The current price of Bitcoin in Euro is $price');
//         } else {
//           // If the response status code is not 200, then log an error message
//           print("An Error occured trying to livefetch the bitcoinprice");
//           print('Error ${response.statusCode}: ${response.reasonPhrase}');
//         }
//       } catch (e) {
//         // If an error occurs while fetching the Bitcoin price, then log an error message
//         print('Error fetching Bitcoin price: $e');
//       }
//     });
//   }
//
//   // This function stops the Bitcoin price stream by canceling the Timer and closing the StreamController
//   void stop() {
//     _timer.cancel();
//     _priceController.close();
//   }
// }
class BitcoinPriceStream {
  final String _url = 'https://api.coingecko.com/api/v3/simple/price';
  late StreamController<ChartLine> _priceController;
  Timer? _timer;
  final Duration _updateInterval = Duration(seconds: 45);
  String localCurrency = 'eur'; // Default currency

  BitcoinPriceStream() {
    _priceController = StreamController<ChartLine>(
      onListen: _startStream,
      onCancel: _stopStream,
    );
  }

  BitcoinPriceStream.withCurrency(String currency) {
    if (localCurrency != currency) {
      localCurrency = currency.toLowerCase();
    }
    _priceController = StreamController<ChartLine>(
      onListen: _startStream,
      onCancel: _stopStream,
    );
    _startStream();
  }
  Stream<ChartLine> get priceStream => _priceController.stream;

  void updateCurrency(String currency) {
    if (localCurrency != currency) {
      localCurrency = currency.toLowerCase();
      _restartStream();
    }
  }

  void _startStream() {
    _fetchAndUpdate();
    _timer = Timer.periodic(_updateInterval, (_) => _fetchAndUpdate());
  }

  Future<void> _fetchAndUpdate() async {
    Logs().d("Fetching bitcoin price in $localCurrency...");
    try {
      final Map<String, String> params = {
        'ids': 'bitcoin',
        'vs_currencies': localCurrency,
        'include_last_updated_at': 'true',
      };
      final response =
          await http.get(Uri.parse(_url).replace(queryParameters: params));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final double price =
            double.parse(data['bitcoin'][localCurrency].toString());
        final double time =
            double.parse(data['bitcoin']['last_updated_at'].toString());
        Logs().d("Price of bitcoin in $localCurrency: $price");
        final ChartLine latestChartLine = ChartLine(time: time, price: price);
        _priceController.add(latestChartLine);
      } else {
        Logs().e(
            "Error fetching Bitcoin price stream data: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      Logs().e("Error fetching Bitcoin price: $e");
    }
  }

  void _stopStream() {
    _timer?.cancel();
  }

  void _restartStream() {
    _stopStream();
    _startStream();
  }

  void dispose() {
    _stopStream();
    _priceController.close();
  }
}
