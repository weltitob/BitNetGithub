import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class BitcoinPrice extends StatefulWidget {
  @override
  _BitcoinPriceState createState() => _BitcoinPriceState();
}

class _BitcoinPriceState extends State<BitcoinPrice> {
  StreamController<double> _priceStreamController =
  StreamController<double>();

  late StreamSubscription<double> _priceStreamSubscription;

  double _currentPrice = 0;

  void _getBitcoinPrice() async {
    final String url = 'https://api.coingecko.com/api/v3/simple/price';
    final Map<String, String> params = {
      'ids': 'bitcoin',
      'vs_currencies': 'eur',
      'include_last_updated_at': 'true'
    };
    final response =
    await get(Uri.parse(url).replace(queryParameters: params), headers: {});

    if (response.statusCode == 200) {
      print('Getting BTC price...');
      String price = jsonDecode(response.body)['bitcoin']['eur'].toString();
      final time = jsonDecode(response.body)['bitcoin']['last_updated_at'].toString();
      print('The current price of Bitcoin in Euro is $price');
      double priceasdouble = double.parse(price);
      setState(() {
        _priceStreamController.add(priceasdouble);
      });
    } else {
      print('Error ${response.statusCode}: ${response.reasonPhrase}');
      setState(() {
        print("An Error occured trying to livefetch the bitcoinprice");
      });
      await Timer(const Duration(seconds: 5), () => print('Timer finished'));
      _getBitcoinPrice();
    }
  }

  @override
  void initState() {
    super.initState();
    _getBitcoinPrice();
    _priceStreamSubscription = _priceStreamController.stream.listen((price) {
      setState(() {
        _currentPrice = price;
      });
    });
  }

  @override
  void dispose() {
    _priceStreamSubscription.cancel();
    _priceStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          '\$${_currentPrice.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}