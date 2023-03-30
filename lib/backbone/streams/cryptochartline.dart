
import 'dart:convert';

import 'package:http/http.dart';
import 'package:nexus_wallet/components/chart.dart';

class CryptoChartLine {
  final String crypto;
  final String interval;
  final String days;
  final String currency;

  CryptoChartLine({
    required this.crypto,
    required this.interval,
    required this.days,
    required this.currency,
  });

  //fetch chartdatas from coingecko api
  List<ChartLine> chartLine = [];
  Future<void> getChartData() async {
    var url =
        "https://api.coingecko.com/api/v3/coins/$crypto/market_chart?vs_currency=$currency&days=$days&interval=$interval";
    Response res = await get(Uri.parse(url));
    var jsonData = jsonDecode(res.body);
    if (res.statusCode == 200) {
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
      throw "Unable to retrieve chart data from Coingecko.";
    }
  }
}