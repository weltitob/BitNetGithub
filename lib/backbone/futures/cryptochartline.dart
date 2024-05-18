import 'dart:convert';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


/*
This class represents a chart line for a given cryptocurrency and allows fetching its chart data from the Coingecko API.
 */
class CryptoChartLine {
  final String crypto;
  final String days;
  final String currency;
  final String apiKey = AppTheme.coinGeckoApiKey;

  CryptoChartLine({
    required this.crypto,
    required this.days,
    required this.currency,
  });

  // List to store the chart data
  List<ChartLine> chartLine = [];

  // Function to fetch chart data from Coingecko API
  Future<void> getChartData() async {
    LoggerService logger = Get.find();
    logger.d("Fetching chart data for $crypto... $days days, $currency currency");
    final currencyLower = currency.toLowerCase();
    var url =
        "https://api.coingecko.com/api/v3/coins/$crypto/market_chart?vs_currency=$currencyLower&days=$days&api_key=$apiKey";
    http.Response res = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(res.body);
    if (res.statusCode == 200) {
      // If 'days' is 'max', get data for every 15th element, otherwise get data for every 4th element
      if (days == "max") {
        for (var i = 0; i < jsonData["prices"].length; i += 15) {
          dynamic element = jsonData["prices"][i];
          double time = element[0].toDouble();
          double price = element[1].toDouble();
          ChartLine chartData = ChartLine(
            time: time,
            price: price,
          );
          chartLine.add(chartData);
        }
      } else if (days == "30") {
        for (var i = 0; i < jsonData["prices"].length; i += 4) {
          dynamic element = jsonData["prices"][i];
          double time = element[0].toDouble();
          double price = element[1].toDouble();
          ChartLine chartData = ChartLine(
            time: time,
            price: price,
          );
          chartLine.add(chartData);
        }
      } else {
        // Get all the chart data
        jsonData["prices"].forEach((element) {
          double time = element[0].toDouble();
          double price = element[1].toDouble();
          ChartLine chartData = ChartLine(
            time: time,
            price: price,
          );
          chartLine.add(chartData);
        });
      }
    } else {
      logger.e("Unable to retrieve chart data from Coingecko. Status code: ${res.statusCode} Response: ${res.body}");
      // Throw an error if unable to retrieve chart data from Coingecko
    }
  }
}